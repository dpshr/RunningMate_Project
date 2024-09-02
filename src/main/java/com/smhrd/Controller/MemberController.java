 package com.smhrd.Controller;

import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.smhrd.entity.PlantListDTO;
import com.smhrd.entity.TblMember;
import com.smhrd.mapper.MemberMapper;
import com.smhrd.mapper.PlantMapper;
import com.smhrd.repository.MemberRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {

	@Autowired
	MemberRepository MemRepo;

	@Autowired
	MemberMapper Mapper;
	
	@Autowired
	PlantMapper plantMapper;
	
	// 메인 페이지 호출
	@RequestMapping("/main")
	public String goMain() {
		return "main";
	}

	// 로그인
	@RequestMapping("/Real_Login")
	public String Real_Login(String memId, String memPw, HttpSession session) {

		TblMember member = MemRepo.findByMemIdAndMemPw(memId, memPw);

		if (member != null && member.getMemDel().equals("N")) {
			session.setAttribute("user", member);
			session.setAttribute("msg", "로그인 성공했습니다.");

		} else {
			session.setAttribute("msg", "로그인 실패했습니다. 다시 시도해주세요.");
			return "Login";
		}
		return "redirect:main";
	}

	// 회원가입 화면 이동
	@RequestMapping("/Go_Real_Join")
	public String Go_Real_Join() {

		return "Real_Join";
	}

	// 회원 가입
	@RequestMapping("/Real_Join")
	public String Real_Join(TblMember member) {

		MemRepo.save(member);
		
		return "redirect:main";
	}

	
	// 로그인 화면 이동
	@RequestMapping("/Go_Login")
	public String Go_Login() {

		return "Login";
	}

	// 로그아웃
	@RequestMapping("/Logout")
	public String Logout(HttpSession session) {
		session.invalidate();
		return "redirect:main";
	}

	// 카카오 로그인
	@RequestMapping("/KakaoLogSuc")
	public String KakaoLogSuc(String nickname, HttpSession session) {

		session.setAttribute("user_nick", nickname);
		session.setAttribute("msgg", "로그인 성공했습니다.");
		return "redirect:main";
	}
	
	// 로그인 후 내 발전소 페이지 이동, 내 발전소 리스트 가져오기
	@RequestMapping("/loginon")
	public String gologinon(HttpSession session) {
		TblMember member=(TblMember)session.getAttribute("user");
		if (member==null) {
			session.setAttribute("ms", "로그인 후 사용가능합니다.");
			return "redirect:/main";
		}else 
		{
		String memId = member.getMemId();
		ArrayList<PlantListDTO> plantList = plantMapper.plantList(memId);
		session.setAttribute("PlnatList", plantList);
		return "loginon";
		}
	}
	
	// 마이페이지로 이동
	@RequestMapping("/Go_Mypage")
	public String Go_Mypage() {

		return "myPage";
	}

	// 회원정보 수정
	@RequestMapping("/M_modify")
	public String M_modify(TblMember member, HttpSession session) {

		TblMember user = (TblMember) session.getAttribute("user");

		member.setMemId(user.getMemId());

		MemRepo.save(member);

		session.setAttribute("user", member);

		return "redirect:main";
	}

	// 회원탈퇴
	@RequestMapping("/M_delete")
	public String M_delete(TblMember member, HttpSession session) {

		TblMember user = (TblMember) session.getAttribute("user");

		member.setMemId(user.getMemId());
		member.setMemDel("Y");
		MemRepo.save(member);

		session.removeAttribute("user");
		return "redirect:main";
	}

	// 발전지도화면 이동
	@RequestMapping("/Go_PowerMap")
	public String Go_PowerMap() {
		
		return "powerMap";
	}

	// 아이디 중복 체크
	@GetMapping("/idCheck")
	public ResponseEntity<Boolean> checkId(@RequestParam("memId") String memId) {
		boolean isDuplicate = MemRepo.existsByMemId(memId);
		return ResponseEntity.ok(isDuplicate);
	}

}