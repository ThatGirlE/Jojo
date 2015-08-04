<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>


<c:set var="ctxName" value="${pageContext.request.contextPath}"/>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <title>index</title>
      <link href="../resource/customer/notice.css" type="text/css" rel="stylesheet" />
   </head>
   <body>
	<jsp:include page="../Inc/header.jsp"/>
	<div id="visual" class="customer">
	<div class= "top-wrapper">
	
	</div>
      <div id="header">
         <div class="top-wrapper">
            <h1 id="logo"><a href="../index.jsp"><img src="../images/logo.png" alt="뉴렉처" /></a></h1>
            <h2 class="hidden">메인메뉴</h2>
            <ul id="mainmenu" class="block_hlist">
               <li>
                  <a href="">학습가이드</a>
               </li>
               <li>
                  <a href="" >과정선택</a>
               </li>
               <li>
                  <a href="" >인기과정</a>
               </li>
            </ul>
            <form id="searchform" action="" method="get">
               <fieldset>
                  <legend class="hidden">
                     과정검색폼
                  </legend>
                  <label for="query">과정검색</label>
                  <input type="text" name="query" />
                  <input type="submit" class="button" value="검색" />
               </fieldset>
            </form>
            <h3 class="hidden">로그인메뉴</h3>
            <ul id="loginmenu" class="block_hlist">
               <li>
                  <a href="../index.jsp">HOME</a>
               </li>
               <li>
               <%-- <c:if test="${empty pageContext.request.userPrincipal }">
                  <a href="../joinus/login">로그인</a>
               </c:if>
               <c:if test="${not empty pageContext.request.userPrincipal }">
                  <a href="${ctxName }/j_spring_security_logout">${pageContext.request.userPrincipal.name } 로그아웃</a>
               </c:if> --%>
                  <a href="../joinus/login">로그인</a>
                  <a href="${ctxName }/j_spring_security_logout"><security:authentication property="name"/>  로그아웃</a>
                  <security:authentication property="authorities" var="auths"/>
                  <c:forEach items="${auths}" var=auth">
                     ${auth.authority }
                  </c:forEach>
               </li>
               <li>
                  <a href="../joinus/join.jsp">회원가입</a>
               </li>
            </ul>
            <h3 class="hidden">회원메뉴</h3>
            <ul id="membermenu" class="clear">
               <li>
                  <a href=""><img src="../images/menuMyPage.png" alt="마이페이지" /></a>
               </li>
               <li>
                  <a href="notice.jsp"><img src="../images/menuCustomer.png" alt="고객센터" /></a>
               </li>
            </ul>
         </div>
      </div>
      <div id="visual" class="customer">
         <div class="top-wrapper">

         </div>
      </div>
      <div id="main">
         <div class="top-wrapper clear">
            <div id="content">
               <h2>공지사항</h2>
               <h3 class="hidden">방문페이지 로그</h3>
               <ul id="breadscrumb" class="block_hlist clear">
                  <li>HOME</li>
                  <li>
                     고객센터
                  </li>
                  <li>
                     공지사항목록
                  </li>
               </ul>
               <h3 class="hidden">공지사항 목록</h3>
               <form id="content-searchform" class="article-search-form" action="notice.jsp" method="get">
                  <fieldset>
                     <legend class="hidden">
                        목록 검색 폼
                     </legend>
                     <input type="hidden" name="pg" value="" />
                     <label for="f"
                     class="hidden">검색필드</label>
                     <select name="f">
                        <option value="TITLE">제목</option>
                        <option value="CONTENT">내용</option>
                     </select>
                     <label class="hidden" for="q">검색어</label>
                     <input type="text"
                     name="q" value="" />
                     <input type="submit" value="검색" />
                  </fieldset>
               </form>
               <table class="article-list margin-small">
                  <caption class="hidden">
                     공지사항
                  </caption>
                  <thead>
                     <tr>
                        <th class="seq">번호</th>
                        <th class="title">제목</th>
                        <th class="writer">작성자</th>
                        <th class="regdate">작성일</th>
                        <th class="hit">조회수</th>
                     </tr>
                  </thead>
                  <tbody>
                     <c:forEach var="n" items="${list}" >
                     <tr>
                        <td class="seq">${n.code}</td>
                        <td class="title">
                           <a href="noticeDetail?c=${n.code}">${n.title}</a>
                           [${n.cmtCount}]
                           <c:forEach var="f" items="${n.files}">
                              ${f.name},
                           </c:forEach>               
                        </td>
                        <td class="writer">${n.writer}</td>
                        <td class="regdate"><fmt:formatDate value="${n.regDate}" pattern="yyyy-MM-dd" /> </td>
                        <td class="hit">${n.hit}</td>
                     </tr>
                     </c:forEach>
                  </tbody>
               </table>
               <p class="article-comment margin-small">
               <security:authorize ifAnyGranted= "ROLE_ADMIN, ROLE_TEACHER">
               		<a class= "btn-write button" href="noticeReg">글쓰기</a>
               </security:authorize>
                  
               </p>
               <p id="cur-page" class="margin-small">
                  <span class="strong">1</span> /
                  10   page
               </p>
               <div id="pager-wrapper" class="margin-small">
                  <div class="pager clear">
                     <p id="btnPrev">
                        <a class="button btn-prev"
                        href="notice.jsp">이전</a>
                     </p>
                     <ul>
                        <li>
                           <a class="strong" href="">1</a>
                        </li>
                        <li>
                           <a href="">2</a>
                        </li>
                        <li>
                           <a href="">3</a>
                        </li>
                        <li>
                           <a href="">4</a>
                        </li>
                        <li>
                           <a href="">5</a>
                        </li>
                     </ul>
                     <p id="btnNext">
                        <span class="button btn-next">다음</span>
                     </p>
                  </div>
               </div>
            </div>
            <div id="navi">
               <h2>고객센터</h2>
               <h3 class="hidden">고객센터메뉴</h3>
               <ul id="navi-menu">
                  <li>
                     <a href="">뉴렉처소식</a>
                  </li>
                  <li>
                     <a href="" class="current">공지사항</a>
                  </li>
                  <li>
                     <a href="">1:1 고객문의</a>
                  </li>
                  <li>
                     <a href="">학습도구</a>
                  </li>
                  <li>
                     <a href="">학습안내</a>
                  </li>
               </ul>
               <h3 id="fav-title">추천사이트</h3>
               <ul class="margin-small">
                  <li>
                     <a href="http://www.answeris.net"><img src="../images/answeris.png" alt="앤서이즈" /></a>
                  </li>
                  <li>
                     <a href="http://www.microsoft.com"><img src="../images/microsoft.png" alt="마이크로소프트" /></a>
                  </li>
                  <li>
                     <a href="http://www.w3c.org"><img src="../images/w3c.png" alt="W3C" /></a>
                  </li>
               </ul>
            </div>
         </div>
      </div>
      <div id="footer">
         <div class="top-wrapper">
            <h2><img src="../images/footerLogo.png" alt="뉴렉처"/></h2>
            <p>            
               <address id="ad">
                  사업자등록번호 : 000-00-00000000 통신판매업신고 : 서울 0000-000 관리자 : 홍길동
                  <br/>
                  주소 : 서울시 000구 001동 000-0 00빌딩 0층 전화 : 02-000-0000 팩스 : 02-000-0000
               </address>
            </p>            
            <p>
               Copyright ⓒ newlecture.com 2012-2012 All Right Reserved. Contact master@newlecture.com for more information
            </p>
         </div>
      </div>
   </body>
</html>