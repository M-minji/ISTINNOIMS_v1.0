package egovframework.com.cmm.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Map;

import egovframework.com.cmm.SessionVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.rndp.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovResourceCloseHelper;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


/**
 * @Class Name : EgovImageProcessController.java
 * @Description :
 * @Modification Information
 *
 *    수정일       	수정자         수정내용
 *    ----------   ---------     -------------------
 *    2009.04.02	이삼섭			최초생성
 *    2014.03.31	유지보수		fileSn 오류수정
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 4. 2.
 * @version
 * @see
 *
 */
@SuppressWarnings("serial")
@Controller
public class EgovImageProcessController extends HttpServlet {

    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileService;

    private static final Logger LOGGER = LoggerFactory.getLogger(EgovImageProcessController.class);

    /**
     * 첨부된 이미지에 대한 미리보기 기능을 제공한다.
     *
     * @param atchFileId
     * @param fileSn
     * @param sessionVO
     * @param model
     * @param response
     * @throws Exception
     */
    @RequestMapping("/cmm/fms/getImage.do")
    public void getImageInf(SessionVO sessionVO, ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

		//@RequestParam("atchFileId") String atchFileId,
		//@RequestParam("fileSn") String fileSn,
    	
		String atchFileId = (String)commandMap.get("atchFileId");
		String fileSn = (String)commandMap.get("fileSn");
		 
		FileVO vo = new FileVO();

		vo.setAtchFileId(atchFileId);
		vo.setFileSn(fileSn);

		//------------------------------------------------------------
		// fileSn이 없는 경우 마지막 파일 참조
		//------------------------------------------------------------
		if (fileSn == null || fileSn.equals("")) {
			int newMaxFileSN = fileService.getMaxFileSN(vo);
			vo.setFileSn(Integer.toString(newMaxFileSN - 1));
		}
		//------------------------------------------------------------

		FileVO fvo = fileService.selectFileInf(vo);

		//String fileLoaction = fvo.getFileStreCours() + fvo.getStreFileNm();
		// fvo 유효성 체크 추가
		if (fvo == null || fvo.getFileStreCours() == null || fvo.getStreFileNm() == null || fvo.getFileExtsn() == null) {
		    response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
		    return;
		}
		File file = null;
		FileInputStream fis = null;

		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;
		String fileStreCours = EgovProperties.getProperty("fileStorePath") + fvo.getFileStreCours();
		try {
		    file = new File(fileStreCours, fvo.getStreFileNm()+"."+fvo.getFileExtsn());
		    fis = new FileInputStream(file);

		    in = new BufferedInputStream(fis);
		    bStream = new ByteArrayOutputStream();

		    int imgByte;
		    while ((imgByte = in.read()) != -1) {
		    	bStream.write(imgByte);
		    }

			String type = "";

			if (fvo.getFileExtsn() != null && !"".equals(fvo.getFileExtsn())) {
			    if ("jpg".equals(fvo.getFileExtsn().toLowerCase())) {
				type = "image/jpeg";
			    } else {
			    	type = "image/" + fvo.getFileExtsn().toLowerCase();
			    }
			    type = "image/" + fvo.getFileExtsn().toLowerCase();

			} else {
				LOGGER.debug("Image fileType is null.");
			}

			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());

			bStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
			response.getOutputStream().close();

		} finally {
			EgovResourceCloseHelper.close(bStream, in, fis);
		}
		
		
    }
    

    @RequestMapping("/cmm/fms/getPdf.do")
    public void getPdfInf(SessionVO sessionVO, ModelMap model, @RequestParam Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

       String atchFileId = (String)commandMap.get("atchFileId");
       String fileSn = (String)commandMap.get("fileSn");

       FileVO vo = new FileVO();

       vo.setAtchFileId(atchFileId);
       vo.setFileSn(fileSn);

       //------------------------------------------------------------
       // fileSn이 없는 경우 마지막 파일 참조
       //------------------------------------------------------------
       if (fileSn == null || fileSn.equals("")) {
          int newMaxFileSN = fileService.getMaxFileSN(vo);
          vo.setFileSn(Integer.toString(newMaxFileSN - 1));
       }
       //------------------------------------------------------------

       FileVO fvo = fileService.selectFileInf(vo);

       //String fileLoaction = fvo.getFileStreCours() + fvo.getStreFileNm();

       File file = null;
       FileInputStream fis = null;

       BufferedInputStream in = null;
       ByteArrayOutputStream bStream = null;

       String fileStreCours = EgovProperties.getProperty("fileStorePath") + fvo.getFileStreCours();


       try {
          file = new File(fileStreCours, fvo.getStreFileNm()+"."+fvo.getFileExtsn());
          fis = new FileInputStream(file);

          in = new BufferedInputStream(fis);
          bStream = new ByteArrayOutputStream();

          int imgByte;
          while ((imgByte = in.read()) != -1) {
             bStream.write(imgByte);
          }



          response.setHeader("Content-Type", "application/pdf");
          response.setContentLength(bStream.size());

          bStream.writeTo(response.getOutputStream());

          response.getOutputStream().flush();
          response.getOutputStream().close();

       } finally {
          EgovResourceCloseHelper.close(bStream, in, fis);
       }
    }
}
