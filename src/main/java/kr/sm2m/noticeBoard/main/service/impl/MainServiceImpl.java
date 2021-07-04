package kr.sm2m.noticeBoard.main.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.userdetails.User;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
//import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import kr.sm2m.noticeBoard.main.domain.Main;
import kr.sm2m.noticeBoard.main.mapper.MainMapper;
import kr.sm2m.noticeBoard.main.service.MainService;

@Service
public class MainServiceImpl implements MainService {
	
	@Resource(name = "kr.sm2m.noticeBoard.main.mapper.MainMapper")
	private MainMapper mainMapper;
	
//	@Autowired
//	private PasswordEncoder passwordEncoder;

	//아이디중복검사
	public int idCheck(Main main) throws Exception{
		return mainMapper.idCheck(main);
	}
	
	//회원정보수정
	public void editMemInfo(Main main) throws Exception{
		mainMapper.editMemInfo(main);
	}
	//회원가입
	public void insertRegister(Main main) throws Exception{
		
		// client ip
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
    	String ip = req.getHeader("X-FORWARDED-FOR");
        if (ip == null) {
        	ip = req.getRemoteAddr();
        }
        main.setMiIp(ip);
        
//        main.setMiPwd(passwordEncoder.encode(main.getMiPwd())); // 비밀번호 암호화
        
		mainMapper.insertRegister(main);
	}
	
	//회원탈퇴
	public void deleteRegister(Main main) throws Exception{
		mainMapper.deleteRegister(main);
	}
	
	//로그인
	public Main selectLogin(Main main) throws Exception{
//		String pw = mainMapper.selectLogin(main);
		
//		if(passwordEncoder.matches(pw, main.getMiPwd())) {
//			System.out.println("일치일치일치일치일치일치일치일치");
//		} else {
//			System.out.println("불일치불일치불일치불일치불일치불일치불일치불일치불일치");
//		}
		
//		main = mainMapper.selectLogin(main);
//		session.setAttribute("mi", main);
//		System.out.println(session.getAttribute("mi"));
//		main.setMiPwd(((Main)session.getAttribute("mi").getMiName());    
//		((User)session.getAttribute("memInfo")).getMemberCode()
		return mainMapper.selectLogin(main);
	}
	
//	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//		return ;
//	}
	
	//카테고리조회
	public List<Main> selectCate() throws Exception{
		return mainMapper.selectCate();
	}
	
	//bar차트 데이터
	public Map<String, Object> selectBarData() throws Exception{
		Map<String, Object> selectBarData = new HashMap<String, Object>();

		List<Main> barDataVo = mainMapper.selectBarData();
		
		List<String> bcTitle = new ArrayList<String>();
		List<Integer> bdSum = new ArrayList<Integer>();
		
		for(int i=0; i < barDataVo.size(); i++) {
			bcTitle.add(barDataVo.get(i).getBcTitle());
			bdSum.add(barDataVo.get(i).getBdSum());
		}
		
		selectBarData.put("bcTitle", bcTitle);
		selectBarData.put("bdSum", bdSum);
		
		return selectBarData;
	}
	
	//line차트 데이터
	public Map<String, Object> selectLineData() throws Exception{
		Map<String, Object> selectLineData = new HashMap<String, Object>();
		
		List<Integer> bdEnrollDate = mainMapper.selectLineData(); //line차트 데이터
		
		//grouping 후 counting
		Map<Integer, Long> result =
				bdEnrollDate.stream().collect(
                        Collectors.groupingBy(
                                Function.identity(), Collectors.counting()
                        )
                );
		
		Map<Integer, Long> finalMap = new LinkedHashMap<>();
        //Sort a map and add to finalMap
        result.entrySet().stream()
                .sorted(Map.Entry.<Integer, Long>comparingByKey()).forEachOrdered(e -> finalMap.put(e.getKey(), e.getValue()));
		
		List<Integer> date = new ArrayList<Integer>();
		List<Long> sum = new ArrayList<Long>();
		
		//현재날짜
		SimpleDateFormat format = new SimpleDateFormat("dd"); 
		
		Date time = new Date();
		String currentDateStr = format.format(time);
		int currentDate = Integer.parseInt(currentDateStr);
		
		//리스트 date값
		for(int i=currentDate-6; i<=currentDate; i++) {
			date.add(i);
		}
		//리스트 sum값
		for(int i=0; i< date.size(); i++) {
			
			//map의 key값 체크
			if(finalMap.containsKey(date.get(i))) {
				sum.add(finalMap.get(date.get(i)));
			} else {
				sum.add(0L);
			}
		}
		selectLineData.put("date", date);
		selectLineData.put("sum", sum);
		
		return selectLineData;
	}
	//pie차트 데이터
	public Map<String, Object> selectPieData() throws Exception{
		Map<String, Object> selectPieData = new HashMap<String, Object>();
		
		List<Main> pieDataVo = mainMapper.selectPieData();
		List<String> miName = new ArrayList<String>();
		List<Integer> bdSum = new ArrayList<Integer>();
		for(int i=0; i < pieDataVo.size(); i++) {
			miName.add(pieDataVo.get(i).getMiName());
			bdSum.add(pieDataVo.get(i).getBdSum());
		}
		
		selectPieData.put("miName", miName);
		selectPieData.put("bdSum", bdSum);
		
		return selectPieData;
	}
	//테이블 데이터
	public Map<String, Object> selectTabData() throws Exception{
		Map<String, Object> selectTabData = new HashMap<String, Object>();
		
		List<Main> selectViewTop = mainMapper.selectViewTop(); //조회수많은글
		List<Main> selectReplyTop = mainMapper.selectReplyTop(); //댓글많은글
		
		selectTabData.put("selectViewTop", selectViewTop);
		selectTabData.put("selectReplyTop", selectReplyTop);
		
		return selectTabData;
	}
}
