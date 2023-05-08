package org.hub.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.hub.domain.AttachFileDTO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<AttachFileDTO> uploadAjaxPost(MultipartFile uploadFile) {
		
		log.info("update ajax post . . . . . . .");
		
		// 사용자 이미지 복사본/섬네일이 저장되는 위치
		String uploadFolder = "C:\\upload";
		
		// '파일을 저장할 폴더 경로 문자열' 반환받아 변수에 저장
		String uploadFolderPath = getFolder();
		
		//make folder - - - - - -
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path: " + uploadPath);
		
		// 해당 경로가 있는지 검사
		if (uploadPath.exists() == false) { 
		 uploadPath.mkdirs(); // make yyyy/MM/dd folder
		}				
			
		AttachFileDTO attachDTO = new AttachFileDTO();

		String uploadFileName = uploadFile.getOriginalFilename();

		log.info("= = = = = = = = = = = = = = = = = =");
		log.info("Upload File Name : " + uploadFile.getOriginalFilename());
		log.info("Upload File Size : " + uploadFile.getSize());
		log.info("only file name: " + uploadFileName);
		log.info("= = = = = = = = = = = = = = = = = =");
		
		attachDTO.setFileName(uploadFileName);

		/* random으로 임의의값을 생성한 후 => uuid_원래파일이름 */
		UUID uuid = UUID.randomUUID();

		uploadFileName = uuid.toString() + "_" + uploadFileName;
		
		// saveFile = 섬네일용 복사본 만들기
		try {
			// 1. 업로드된 파일을 저장할 경로와 파일 이름을 인자로 받아서, 해당 경로에 지정된 이름의 파일 객체를 생성
			File saveFile = new File(uploadPath, uploadFileName);
			// 2. 업로드된 파일을 생성한 파일 객체에 저장
			uploadFile.transferTo(saveFile);

			attachDTO.setUuid(uuid.toString());
			attachDTO.setUploadPath(uploadFolderPath);

			// check image type file
			if (checkImageType(saveFile)) {
				attachDTO.setImage(true);
				FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
				Thumbnailator.createThumbnail(uploadFile.getInputStream(), thumbnail, 100, 100);

				thumbnail.close();
			} // end if

		} catch (Exception e) {
			e.printStackTrace();
		} // end catch
		
		return new ResponseEntity<AttachFileDTO>(attachDTO, HttpStatus.OK);
		
	}
	
	// 특정한 파일 이름을 받아 이미지 데이터를 전송하는 메소드
	@GetMapping("/display")	
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		// 문자열로 파일의 경로가 포함된 fileName을 받고, byte[]를 전송
		log.info("fileName: " + fileName);

		File file = new File("c:\\upload\\" + fileName);

		log.info("file: " + file);

		ResponseEntity<byte[]> result = null;

		try {
			HttpHeaders header = new HttpHeaders();
			// 브라우저에 보내주는 MIME 타입이 파일의 종류에 따라 달라지는 것을 해결하기위함								
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	// 서버에서 첨부파일 삭제
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {

		log.info("deleteFile: " + fileName);

		File file;

		try {
			file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));

			file.delete();
			
			// 이미지 파일인지 확인 후, 섬네일용 복사본도 삭제
			if (type.equals("image")) {

				String largeFileName = file.getAbsolutePath().replace("s_", "");

				log.info("largeFileName: " + largeFileName);

				file = new File(largeFileName);

				file.delete();
			}

		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<String>(HttpStatus.NOT_FOUND);
		}

		return new ResponseEntity<String>("deleted", HttpStatus.OK);

	}
	
	// 인자로 받는 파일이 이미지 파일인지 확인
	private boolean checkImageType(File file) {
		
		try {					// MIME 타입을 반환
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}
	
	// 오늘날짜의 경로를 문자열로 생성 -> 폴더 경로로 수정 후 반환하는 메소드
	private String getFolder() { 
		// SimpleDataFormat 클래스를 이용해 날짜를 원하는 형식으로 출력할 수 있음
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// 현재 날짜 생성
		Date date = new Date();
		
		// SimpleDataFormat 클래스에서 생성한 형식으로 현재 날짜를 문자열로 변환
		String str = sdf.format(date);
		
		// 생성된 문자열에서 "-" 문자를 운영체제에 맞는 파일 경로 구분자로 변경 후 반환
		return str.replace("-", File.separator);
	}
	
	
	
}
