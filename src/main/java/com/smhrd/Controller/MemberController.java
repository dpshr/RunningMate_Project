package com.smhrd.Controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import com.smhrd.entity.TblMember;
import com.smhrd.mapper.MemberMapper;
import com.smhrd.repository.MemberRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {

	@Autowired
	MemberRepository MemRepo;
	
	@Autowired
	MemberMapper Mapper;
	
	// 메인 페이지 호출
	@RequestMapping("/main")
	public String goMain() {
		return "main";
	}

	// 로그인
	@RequestMapping("/Real_Login")
	public String Real_Login(String memId, String memPw, HttpSession session) {

		TblMember member = MemRepo.findByMemIdAndMemPw(memId, memPw);

		if (member != null) {
			session.setAttribute("user", member);
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

		return "redirect:main";
	}

	// 로그인 후 페이지
	@RequestMapping("/loginon")
	public String gologinon() {
		return "loginon";
	}

	// 발전량데이터테이블
	@RequestMapping("/dataTable")
	public String goDataTable() {
		return "dataTable";
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

//	// 회원탈퇴
//	@RequestMapping("/M_delete")
//	public String M_delete(TblMember member, HttpSession session) {
//
//		TblMember user = (TblMember) session.getAttribute("user");
//
//		member.setMemId(user.getMemId());
//		member.setMemDel("Y");
//		MemRepo.save(member);
//		return "redirect:main";
//	}
}
