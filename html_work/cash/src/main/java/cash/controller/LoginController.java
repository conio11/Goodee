package cash.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cash.model.*;
import cash.vo.*;

/*@SuppressWarnings("serial")*/
@WebServlet("/login")
public class LoginController extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		// session 인증 검사 코드
		HttpSession session = request.getSession();
		if (session.getAttribute("loginMember") != null) {
			response.sendRedirect(request.getContextPath() + "/cashbook");
			return;
		}
		
		// get 방식
		request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// doGet(request, response);
		String memberId = request.getParameter("memberId");
		String memberPw = request.getParameter("memberPw");
		
		Member member = new Member(memberId, memberPw, null, null);
		
		MemberDao memberDao = new MemberDao();
		Member loginMember = memberDao.selectMemberById(member);
		
		if (loginMember == null) { 
			System.out.println("로그인 실패");
			response.sendRedirect(request.getContextPath() + "/login"); // jsp 파일 리다이렉트 불가 (WEB-INF 폴더 내에 위치하기 때문)
			return;
		}
		
		// 로그인 성공 시: session 사용
		HttpSession session = request.getSession();
		System.out.println("로그인 성공");
		session.setAttribute("loginMember", loginMember);
		response.sendRedirect(request.getContextPath() + "/cashbook");
	}
}