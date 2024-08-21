package com.smhrd.entity;

import java.sql.Date;
import org.hibernate.annotations.DynamicUpdate;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Entity // 해당 클래스가 Scan이 되어지고, Entity역할로써 기능하기 위한 어노테이션
@Data
@DynamicUpdate
public class TblMember {
	
	
//	아이디
	@Id
	private String memId;
//	비밀번호
	private String memPw;
//	이름
	private String memName;
//	이메일
	private String memEmail;
//	성별
	private String memGender;
//	생년월일
	private Date memBirth;
}
