<%@ page import="adressBook.adressBookDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="adressBook.adressBook" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    int nowBlock = 1;
    if(request.getParameter("nowBlock") != null){ // 첫번째 페이지가 아니면
        nowBlock =  Integer.parseInt(request.getParameter("nowBlock"));
    }
    int nowPage = 1;
    if(request.getParameter("nowPage") != null){ // 첫번째 페이지가 아니면
        nowPage =  Integer.parseInt(request.getParameter("nowPage"));
    }

    String searchWord;
    if(request.getParameter("searchWord") != null){ // 검색어가 있으면
        searchWord = request.getParameter("searchWord");
    }
    else {
        searchWord = "";
    }
%>
<html>
<head>
    <title>AdressBook</title>
    <link rel="stylesheet" href="style.css">
    <style type="text/css">
        a {
            text-decoration:none;
        }

        .page {
            color: black;
        }

    </style>
</head>
<body>
<br>
<form method="post" action="adressBook_list.jsp">
    <div align="center">
        이름 : <input type="text" name="searchWord" value="<%=searchWord%>" width="80">
        <input type="submit" value="검색">
        <a href="adressBook_write.jsp">입력</a>
    </div>
</form>
    <table border="1" align="center" width="750">
        <thead>
            <tr align="center">
                <td>이름</td>
                <td>전화</td>
                <td>음력/양력</td>
                <td>생년월일</td>
                <td>주소</td>
                <td>삭제</td>
            </tr>
        </thead>
        <tbody>
            <%
                adressBookDAO adressBookDao = new adressBookDAO();
                int recordNumPerPage = 3; // 한 페이지에 보일 레코드 개수
                ArrayList<adressBook> list = adressBookDao.getList(nowPage, recordNumPerPage, searchWord);
                for (int i = 0; i < list.size(); i++){
            %>
            <tr align="center">
                <td width="90"><a href="adressBook_edit.jsp?no=<%=list.get(i).getNo()%>"><%=list.get(i).getName()%></a></td>
                <td width="150"><%=list.get(i).getTel().substring(0,3) + "-" + list.get(i).getTel().substring(3, 7) + "-" + list.get(i).getTel().substring(7, 11)%></td>
                <td width="90"><%=list.get(i).getMs() == 0 ? "양력" : "음력"%></td>
                <td width="150"><%=list.get(i).getBirthday()%></td>
                <td width="200"><%=list.get(i).getAdress()%></td>
                <td width="70"><a href="adressBook_delete.jsp?no=<%=list.get(i).getNo()%>">삭제</a></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <br>

    <%--pagination--%>
    <div align="center">
    <%
        int blockNumPerPage = 3; // 한 페이지에 보일 블럭 개수
        int totalPageNum = (int)Math.ceil(adressBookDao.getTotalRecordCount(searchWord) / (float)recordNumPerPage);
        int totalBlockNum = (int)Math.ceil(totalPageNum / (float)blockNumPerPage);
        if (nowBlock > 1){
    %>
    <a href="adressBook_list.jsp?nowBlock=<%=nowBlock - 1%>&nowPage=<%=(nowBlock - 1) + (blockNumPerPage - 1) * (nowBlock - 2)%>&searchWord=<%=searchWord%>">
        <img src="images/leftArrow.png" alt="이전" width="15"height="15"> &nbsp;
    </a>
    <%
        }
        int endPage = nowBlock + (blockNumPerPage - 1) * (nowBlock - 1) + blockNumPerPage - 1;
        for(int i = nowBlock + (blockNumPerPage - 1) * (nowBlock - 1); i <= (Math.min(totalPageNum, endPage)); i++){
    %>

    <a class="page" href="adressBook_list.jsp?nowPage=<%=i%>&nowBlock=<%=nowBlock%>&searchWord=<%=searchWord%>">
        <%
            if (nowPage==i){
                out.print("<font color='red'>" + i + "</font>");
            }
            else{
                out.print(i);
            }
        %>
    </a>
    <%
        }
        if (totalBlockNum > nowBlock){
    %>
    <a href="adressBook_list.jsp?nowBlock=<%=nowBlock + 1%>&nowPage=<%=(nowBlock + 1) + (blockNumPerPage - 1) * nowBlock%>&searchWord=<%=searchWord%>">
        &nbsp;<img src="images/rightArrow.png" alt="다음"width="15"height="15">
    </a>
    <%
        }
    %>
    </div>
</body>
</html>
