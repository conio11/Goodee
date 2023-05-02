<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="vo.*"%>
<%
 	// 중복 ID값 검사 추가 예정
 	
	// post 방식 인코딩 처리
	request.setCharacterEncoding("UTF-8");
	
	// 세션 유효성 확인 -> 요청값 유효성 확인
	
	// 세션 유효성 확인: 로그인 상태인 경우 home.jsp로 이동
	if (session.getAttribute("memberID") != null) { 
		response.sendRedirect(request.getContextPath() + "/home.jsp"); // 추후 msg 변수 추가
		return; // 실행 종료
	}
	
	// 요청값 유효성 확인
	// ID, PW 모두 유효값이 있으면 (null값이나 공백값이 아니면)
	if (request.getParameter("memberID") != null
	&& !request.getParameter("memberID").equals("")
	&& request.getParameter("memberPW") != null 
	&& !request.getParameter("memberPW").equals("")) { 
		System.out.println("아이디, 비밀번호 입력 확인");
	} else {
		String msg = URLEncoder.encode("아이디와 비밀번호를 모두 입력하세요", "utf-8");
		response.sendRedirect(request.getContextPath()+"/member/insertMemberForm.jsp?msg=" + msg);
		System.out.println("회원가입 실패");
	}
	
	// 입력된 아이디, 비밀번호 변수로 저장
	String ID = request.getParameter("memberID");
	String PW = request.getParameter("memberPW");
	
	// 입력된 아이디, 비밀번호 디버깅
	System.out.println(ID + " <-- ID(insertMemberAction)");
	System.out.println(PW + " <-- PW(insertMemberAction)");
	
	// 요청값을 Member 클래스에 정리
	Member newMember = new Member();
	newMember.memberID = ID;
	newMember.memberPW = PW;
	
	// DB 연결
	String driver = "org.mariadb.jdbc.Driver";
	String dbUrl = "jdbc:mariadb://127.0.0.1:3306/userboard";
	String dbUser = "root";
	String dbPw = "java1234";
	Class.forName(driver);
	System.out.println("드라이버 로딩 성공(insertMemberAction)");
	Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw);
	System.out.println("DB 접속 성공(insertMemberAction)");
	PreparedStatement stmt = null;
	// ResultSet rs = null;
	
	// 비밀번호 암호화 (PASSWORD(?))
	String sql = "INSERT INTO member(member_id, member_pw, createdate, updatedate) VALUES(?, PASSWORD(?), NOW(), NOW())";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, newMember.memberID);
	stmt.setString(2, newMember.memberPW);
	
	// stmt값 확인
	System.out.println(stmt + " <-- stmt(insertMemberAction)");
	
	int row = stmt.executeUpdate();
	System.out.println(row + "<-- row(insertMemberAction)");
	
	if(row == 1) { // 회원가입 성공, 
		System.out.println("회원가입 성공");
		response.sendRedirect(request.getContextPath()+"/home.jsp");
	} else { // 실패 시 입력폼으로 이동
		System.out.println("회원가입 실패");
		response.sendRedirect(request.getContextPath()+"/insertMemberForm.jsp");
	}
	
	System.out.println("==============================");
%>