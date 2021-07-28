<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ page import="adressBook.adressBookDAO" %>
<%
    int no = Integer.parseInt(request.getParameter("no"));
    adressBookDAO adressBookDao = new adressBookDAO();
    int result = adressBookDao.deleteAdressBook(no);
    if(result == 0){ // 성공
%>
<script>
    location.href = "adressBook_list.jsp";
</script>
<%
}
else{ // 실패
%>
<script>
    alert("삭제에 실패했습니다.");
    history.back();
</script>
<%
    }
%>
</body>
</html>
