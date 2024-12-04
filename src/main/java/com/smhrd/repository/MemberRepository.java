package com.smhrd.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smhrd.entity.TblMember;

public interface MemberRepository extends JpaRepository<TblMember, String>{
	
public TblMember findByMemId(String memId);
	
// 아이디 중복 체크를 위한 메서드
public boolean existsByMemId(String memId);

	
}
