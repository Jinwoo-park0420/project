<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../include/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Main content -->
<section class="content">
	<div class="box box-primary">
		<div class="box-header">
			<h3 class="box-title">List Board</h3>
		</div>
		<div class="row">
			<div class="col-md-4"><!--글쓰기 버튼-->
				<input type="button" onclick="location.href='view/qna_board_write.jsp'" value="글쓰기" class="btn btn-success"/>
			</div>
			<div class="col-md-4 offset-md-4"><!--검색 들어갈 부분-->
				<form action="qSearch.do" method="post" id="search" name="search">
					<select name="criteria" id="criteria">
						<option value="n" <c:out value="${search.criteria==null?'selected':''}"/>>------</option>
						<option value="title" <c:out value="${search.criteria=='title'?'selected':''}"/>>title</option>
						<option value="content" <c:out value="${search.criteria=='content'?'selected':''}"/>>content</option>
						<option value="name" <c:out value="${search.criteria=='name'?'selected':''}"/>>name</option>
					</select>
					<input type="text" name="keyword" value="${search.keyword}" />
					<button type="button" class="btn btn-primary">검색</button>
				</form>
			</div>
		</div>
		<br>
		<table class="table table-bordered">
			<tr>
				<th class='text-center' style='width:100px'>번호</th>
				<th class='text-center'>제목</th>
				<th class='text-center'>작성자</th>
				<th class='text-center'>날짜</th>
				<th class='text-center' style='width:100px'>조회수</th>
			</tr>
			<c:forEach var="vo" items="${list}">
			<tr><!-- 리스트 목록 보여주기 -->
				<td class='text-center'>${vo.bno }</td><!--번호-->
				<td>
					<c:if test="${vo.re_lev!=0}">
						<c:forEach begin="0" end="${vo.re_lev*1}">
							&nbsp;
						</c:forEach>
						└
					</c:if>
				<a href="qHitUpdate.do?bno=${vo.bno}&page=${pageVO.page}&criteria=${search.criteria}&keyword=${search.keyword}">
				${vo.title }</a></td><!--제목-->
				<td class='text-center'>${vo.name }</td><!--작성자-->
				<td class='text-center'>${vo.regdate }</td><!--날짜-->
				<td class='text-center'><span class="badge badge-pill badge-primary">${vo.readcount }</span></td>
			</tr>	
			</c:forEach>	
		</table>
		<div class="container">
			<div class="row  justify-content-md-center">
				<nav aria-label="Page navigation example">
				  <ul class="pagination"><!--하단의 페이지 나누기 부분-->
				  <li class="page-item">
					<c:if test="${pageVO.page<=1}">
						<a class="page-link">Previous</a>
					</c:if>
					<c:if test="${pageVO.page>1}">
						<c:choose>
							<c:when test="${search.criteria==null}">	
								<a class="page-link" href="qList.do?page=${pageVO.page-1}">Previous</a>
							</c:when>
							<c:otherwise>
								<a class="page-link" href="qSearch.do?page=${pageVO.page-1}&criteria=${search.criteria}&keyword=${search.keyword}">Previous</a>
							</c:otherwise>	
						</c:choose>
					</c:if>
					</li>
					<c:forEach begin="${pageVO.startPage}" end="${pageVO.endPage}" var="idx">						
						<c:choose>
							<c:when test="${idx==pageVO.page}">
								<li class="page-item active">
									<a class="page-link">${idx}</a>
								</li>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${search.criteria==null}">
										<li class="page-item" aria-current="page">
											<a class="page-link" href="qList.do?page=${idx}">${idx}</a>
										</li>
									</c:when>
									<c:otherwise>
										<a class="page-link" href="qSearch.do?page=${idx}&criteria=${search.criteria}&keyword=${search.keyword}">${idx}</a>
									</c:otherwise>
								</c:choose>
							</c:otherwise>		
						</c:choose>	
					</c:forEach>
					<c:if test="${pageVO.page>=pageVO.totalPage}">
						<li class="page-item">
							<a class="page-link">Next</a>
						</li>
					</c:if>
					<c:if test="${pageVO.page<pageVO.totalPage}">
						<c:choose>
							<c:when test="${search.criteria==null}">
								<li class="page-item">
									<a href="qList.do?page=${pageVO.page+1}" class="page-link">Next</a>
								</li>
							</c:when>
							<c:otherwise>
										<a class="page-link" href="qSearch.do?page=${pageVO.page+1}&criteria=${search.criteria}&keyword=${search.keyword}">Next</a>
							</c:otherwise>
						</c:choose>
					</c:if>
				  </ul>
				</nav>					
			</div>
		</div>
		<div style="height:20px"></div>
	</div>	
</section>
<%--검색 폼  스크립트--%>
<script>
	$(function() {
		$(".btn-primary").click(function() {
			//검색조건이 선택되지 않은 경우 경고창 띄우기
			if($("select[name='criteria']").val()=='n'){
				alert("검색조건을 입력하세요");
				$("select[name='criteria']").focus();
				return;
			}else if($("input[name='keyword']").val()==""){
				//검색어를 입력하지 않은 경우 경고창 띄우기
				alert("검색어를 입력하세요");
				$("input[name='keyword']").focus();
				return;
			}
			$("#search").submit();
			
		})
	})
</script>
<%@include file="../include/footer.jsp"%>

