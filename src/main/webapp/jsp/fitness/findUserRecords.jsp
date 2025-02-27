<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>享健你，遇見更好的自己．</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/styles/gymstyle.css">
</head>
<body>
	<div id="header">
		<h1>享健你，遇見更好的自己．</h1>
		<h2>你，今天健了嗎？</h2>
	</div>

	<!-- ✅ 導覽列 -->
	<div id="navigation">
		<ul>
			<li><a
				href="http://localhost:8080/HealthManagement/jsp/course/HealthManagement.jsp">首頁</a></li>
			<li><a
				href="http://localhost:8080/HealthManagement/jsp/membercenter.jsp"
				class="active">會員管理</a></li>
			<li><a href="#">商城購物</a></li>
			<li><a
				href="http://localhost:8080/HealthManagement/jsp/fitness/index.jsp">健身成效</a></li>
			<li><a
				href="http://localhost:8080/HealthManagement/jsp/course/index.jsp">課程管理</a></li>
			<li><a
				href="http://localhost:8080/HealthManagement/api/Social/post">社群論壇</a></li>
		</ul>
	</div>
	<div align="center">

		<h1>運動紀錄</h1>
		<!-- 顯示錯誤訊息 -->
		<c:if test="${not empty errorMessage}">
			<div class="error-message">
				<strong>Error:</strong> ${errorMessage}
			</div>
		</c:if>

		<!-- 顯示成功訊息 -->
		<c:if test="${not empty successMessage}">
			<div style="color: #808080;">
				<c:choose>
					<c:when test="${successMessage == 'Record Deleted Successfully'}">
						<strong>Success:</strong> Record Deleted Successfully
                </c:when>
					<c:otherwise>
                    ${successMessage}
                </c:otherwise>
				</c:choose>
			</div>
		</c:if>
		<!-- 查詢運動紀錄 -->
		<form action="../../api/fitness/progress" method="get">
			<div><label for="userId">用戶 I D :</label> <input type="text" name="userId"
				placeholder="Enter User ID">
			<button type="submit">查詢</button></div>
			<br>
			<br><div> <label for="name">用戶名字:</label> <input type="text"
				name="name" placeholder="Enter User Name">
			<button type="submit">查詢</button></div>

		</form>
		<!-- 如果兩者都沒填，顯示錯誤訊息 -->
		<c:if test="${not empty search}">
			<strong style="color: red;">${search}</strong>
		</c:if>



		<!-- 顯示運動紀錄 -->
		<c:if test="${not empty records}">
			<table>
				<thead>
					<tr>
						<th>用戶ID</th>
						<th>用戶姓名</th>
						<th>運動類型</th>
						<th>運動時長（分鐘）</th>
						<th>卡路里消耗</th>
						<th>日期</th>
						<th>管理</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="record" items="${records}">
						<tr>
							<td>${record.userId}</td>
							<td>${record.user.name}</td>
							<td>${record.exerciseType}</td>
							<td>${record.exerciseDuration}</td>
							<td>${record.caloriesBurned}</td>
							<td>${record.exerciseDate}</td>
							<td>
								<!-- 更新按鈕，會跳轉到更新頁面 --> <a
								href="../../api/fitness/progress?action=update&recordId=${record.recordId}&userId=${record.userId}">
									<input type="button" value="更新" class="update">
							</a> <!-- 刪除表單 -->
								<form action="../../api/fitness/progress" method="post"
									style="display: inline;">
									<input type="hidden" name="action" value="delete"> <input
										type="hidden" name="recordId" value="${record.recordId}">
									<input type="hidden" name="userId" value="${record.userId}">
									<input type="submit" value="刪除" class="delete">
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<!-- 顯示資料總數 -->
			<div class="record-count">
				<p>總共有: ${fn:length(records)} 筆資料</p>
			</div>
		</c:if>

		<!-- 返回主畫面的按鈕 -->
		<div>
			<button class="back-button"
				onclick="window.location.href='../../jsp/fitness/index.jsp'">返回</button>
		</div>
	</div>
	<div id="footer">
		<p>&copy; 2025 享健你. All Rights Reserved.</p>
	</div>
</body>
</html>
