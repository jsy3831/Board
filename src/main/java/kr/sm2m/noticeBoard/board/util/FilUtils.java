package kr.sm2m.noticeBoard.board.util;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.sm2m.noticeBoard.board.domain.Board;

@Component("filUtils")
public class FilUtils {
	public List<Board> parseInsertFileInfo(Board board, MultipartHttpServletRequest request) throws Exception{
		
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		
		String listThumb = null;
		String viewThumb = null;
		
		String folder = null;
		
		String stoFileSize = null;
		
		double fileSizeKb;
		double fileSizeMb;
		
		if(board.getBcType() == 1) {
			folder = "basicBoard";
		}
		else if(board.getBcType() == 2) {
			folder = "imgBoard";
		}
		else {
			folder = "mediaBoard";
		}
		
		List<Board> fileInfo = new ArrayList<Board>();
		
		String localBaseFilePath = request.getSession().getServletContext().getRealPath("/"); //로컬파일상대경로
		localBaseFilePath = localBaseFilePath.substring(0, localBaseFilePath.indexOf("webapp"));
		localBaseFilePath += "resources\\static\\uploadFiles\\"+ folder +"\\board" + board.getBdCode() + "\\"; 
		
//		String tomcatBaseFilePath = request.getSession().getServletContext().getRealPath("/"); //서버파일상대경로
//		tomcatBaseFilePath += "WEB-INF\\classes\\static\\uploadFiles\\" + folder + "\\board" + board.getBdCode() + "\\";
		
		String filePath = "uploadFiles\\"+ folder +"\\board" + board.getBdCode() + "\\"; //파일절대경로(저장)
				
		File file = new File(localBaseFilePath);
		if(file.exists() == false){ 
			file.mkdirs();
		}
		
			List<MultipartFile> list = request.getFiles("files");
			for(MultipartFile multipartFile : list) {
				if(multipartFile.isEmpty() == false){
					
					
					fileSizeKb = multipartFile.getSize() / 1024;
					fileSizeMb = fileSizeKb / 1024;
					
					if((1024*1024) <= multipartFile.getSize()) {
						stoFileSize = Math.round(fileSizeMb*100)/100.0 + " Mb";
						
					} else if(1024 <= multipartFile.getSize()) {
						stoFileSize = Math.round(fileSizeKb) + " Kb";
					} else {
						stoFileSize = Math.round(multipartFile.getSize()) + " Byte";
					}
					
					originalFileName = multipartFile.getOriginalFilename();
					originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
					storedFileName = CommonUtils.getRandomString() + originalFileExtension;
					
					file = new File(localBaseFilePath + storedFileName);
					multipartFile.transferTo(file);
					
					Board fileBoard = new Board();
					fileBoard.setBfOriTitle(originalFileName);
					fileBoard.setBfStoTitle(storedFileName);
					fileBoard.setBfSize(stoFileSize);
					fileBoard.setBfPath(filePath);
					fileBoard.setBdCode(board.getBdCode());
					
					if(board.getBcType() == 2) {
						listThumb = makeListThumbnail(localBaseFilePath, storedFileName); //목록 썸네일
						fileBoard.setListThumb(listThumb);
						
						viewThumb = makeViewThumbnail(localBaseFilePath, storedFileName); //본문 썸네일
						fileBoard.setViewThumb(viewThumb);	
					} //이미지업로드시
					
					else if(board.getBcType() == 3) {
						String removeExt = videoThumb(board, localBaseFilePath, storedFileName); //영상 썸네일
						
						listThumb = makeListThumbnail(localBaseFilePath, removeExt + ".jpg"); //목록 썸네일
						
						fileBoard.setListThumb(listThumb);
					} //비디오업로드시
					
					fileInfo.add(fileBoard);
				}
			}
			return fileInfo;
	}
	//비디오 썸네일
	public String videoThumb(Board board, String path, String name) throws Exception{
		System.out.println("비디오썸네일확인");
		String str = null;
		
		String localBaseFilePath = board.getLocalBaseFilePath();
//		String tomcatBaseFilePath = board.getTomcatBaseFilePath();
		
		String ffmpeg = localBaseFilePath + "uploadFiles\\ffmpeg\\ffmpeg";
		String video = path + name;
		
		String removeExt = name.substring(0, name.lastIndexOf("."));
		
		String img = path + removeExt + ".jpg";
		
		String[] cmd = new String[] {
				ffmpeg
				, "-i"
				, video
				, "-an"
				, "-ss"
				, "00:00:01"
				, "-r"
				, "1"
				, "-vframes"
				, "1"
				, "-y"
				, img
		};
		
		Process process = null;
		
		try {
			// 프로세스 빌더를 통하여 외부 프로그램 실행
			process = new ProcessBuilder(cmd).start();
			
			// 외부 프로그램의 표준출력 상태 버퍼에 저장
			BufferedReader stdOut = new BufferedReader(new InputStreamReader(process.getInputStream()));
			
			// 표준출력 상태를 출력
			while((str = stdOut.readLine()) != null) {
				System.out.println(str);
			}
		}
		catch(IOException e) {
			e.printStackTrace();
		}
		return removeExt;
	}
	
	//목록 썸네일
	public String makeListThumbnail(String path, String name) throws Exception {
		
		String fileExt = name.substring(name.lastIndexOf(".") + 1);
		
		BufferedImage srcImg = ImageIO.read(new File(path + name));
		
		int dw = 340, dh = 255; //썸네일 너비, 높이(4:3)
		
		//원본 이미지 너비, 높이
		int ow = srcImg.getWidth(); 
		int oh = srcImg.getHeight();
		
		//원본너비 기준를 기준으로 하여 썸네일의 비율로 높이 계산 
		int nw = ow;
		int nh = (ow * dh) / dw;
		
		//계산된 높이가 원본보다 높으면 crop이 안되므로
		//원본 높이를 기준으로 썸네일의 비율로 너비를 계산
		if(nh > oh) { 
			nw = (oh * dw) / dh; 
			nh = oh; 
		}
		
		//계산된 크기로 원본이미지를 가운데에서 crop
		BufferedImage cropImg = Scalr.crop(srcImg, (ow-nw)/2, (oh-nh)/2, nw, nh);
		
		//crop된 이미지로 썸네일 생성
		BufferedImage destImg = Scalr.resize(cropImg, dw, dh);
		
		//썸네일 저장
		String thumbName = path + "LIST_THUMB_" + name;
		File thumbFile = new File(thumbName);
		
		ImageIO.write(destImg, fileExt, thumbFile);
		
		String saveName = "LIST_THUMB_" + name;
		
		return saveName;
	}
	
	//본문 썸네일
	public String makeViewThumbnail(String path, String name) throws Exception {
			
		String fileExt = name.substring(name.lastIndexOf(".") + 1);
		String thumbName = null;
		String saveName = null;
		
		BufferedImage srcImg = ImageIO.read(new File(path + name));
			
		int dw = 840; //썸네일 너비
		
		int ow = srcImg.getWidth(); //원본 이미지 너비 
		
		if(dw < ow) {
			//썸네일 저장
			thumbName = path + "VIEW_THUMB_" + name;
			File thumbFile = new File(thumbName);
			
			BufferedImage destImg = Scalr.resize(srcImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_WIDTH, dw);
			ImageIO.write(destImg, fileExt, thumbFile);
			
			saveName = "VIEW_THUMB_" + name;
		}
		else {
			saveName = name;
		}
	
		return saveName;
	}
}
