<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="adressBook.adressBookDAO" %>
<%--자바Bean 사용해서 넘겨 받은 값들 객체로 저장--%>
<%
    request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("name");
    String tel1 = request.getParameter("tel1");
    String tel2 = request.getParameter("tel2");
    String tel3 = request.getParameter("tel3");
    String tel = tel1 + '-' + tel2 + '-' + tel3;
    String birthday1 = request.getParameter("birthday1");
    String birthday2 = request.getParameter("birthday2");
    String birthday3 = request.getParameter("birthday3");
    String birthday = birthday1 + '-' + birthday2 + '-' + birthday3;
    String adress = request.getParameter("adress");
    int ms = Integer.parseInt(request.getParameter("ms"));

    System.out.println("writerAction실행");

%>
<html>
<head>
    <title>AdressBook</title>
    <link rel="stylesheet" href="style.css">
    <meta charset="UTF-8">

</head>
<body>
<%
    if(name == null || tel.equals("--") || birthday.equals("--") || adress == null){
%>
<script>
    alert("입력되지 않은 사항이 있습니다.");
    history.back();
</script>
<%
    }
    adressBookDAO adressBookDao = new adressBookDAO();
    int result = adressBookDao.writeNew(name, tel, ms, adress, birthday);
    if(result == 0){
%>
<script>
    location.href = "adressBook_list.jsp";
</script>
<%
    }
    else{
%>
<script>
    alert("새 주소록 추가에 실패했습니다.");
    history.back();
</script>
<%
    }
%>
</body>
</html>
