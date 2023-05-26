<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>   
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="util.*" %>
    
<%
	// post 방식 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	int beginRow = 0;
	int rowPerPage = 10;
	
	DBUtil dbUtil = new DBUtil();
	SubjectDao subDao = new SubjectDao();
	
	Connection conn = dbUtil.getConnection(); // conn이 return됨
	
	// ArrayList<Subject> list 생성 후 값 추가 
	ArrayList<Subject> list = new ArrayList<>();
	list = subDao.selectSubjectListByPage(beginRow, rowPerPage);
	// System.out.println(subDao.selectSubjectListByPage(beginRow, rowPerPage));
	
	System.out.println("=============subjectList=============");
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>subjectList</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
  		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
  		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	</head>
	<body>
		<div class="container mt-3">
		<div class="text-center">
			<h1>과목 리스트</h1>
		</div>
		<br>
		<a href="<%=request.getContextPath()%>/subject/addSubject.jsp" class="btn btn-outline-secondary">새 과목 입력</a>
		<br>
		<br>
		<table class="table table-hover text-center">
			<tr>
				<th>과목 번호</th>
				<th>과목 이름</th>
				<th>과목 시수</th>
				<th>생성일자</th>
				<th>수정일자</th>
			</tr>
		<%
			for (Subject s : list) {
		%>
			<tr>
				<td><%=s.getSubjectNo()%></td>
				<td><a href="<%=request.getContextPath()%>/subject/subjectOne.jsp?subjectNo=<%=s.getSubjectNo()%>" class="btn"><%=s.getSubjectName()%></a></td>
				<td><%=s.getSubjectTime()%></td>
				<td><%=s.getCreatedate().substring(0, 10)%></td>
				<td><%=s.getUpdatedate().substring(0, 10)%></td>
			</tr>	
		<%
			}
		%>
		</table>
		</div>
	</body>
</html>