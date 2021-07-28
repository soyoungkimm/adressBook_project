<%@ page import="adressBook.adressBookDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="adressBook.adressBook" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>AdressBook</title>
    <link rel="stylesheet" href="style.css">
    <meta charset="UTF-8">

</head>
<body>
<br>
<h3 align="center">새 주소록 작성</h3>

<form action="adressBook_writeAction.jsp" method="post">
<table border="1" align="center" width="550" height="300">

        <tbody>
        <tr>
            <td align="center" width="100">이름</td>
            <td>&nbsp;<input name="name" type="text" style="width: 200px"></td>
        </tr>
        <tr>
            <td align="center" width="100">전화</td>
            <td>
                &nbsp;<input name="tel1" id="tel1" type="text" style="width: 100px" maxlength="3" onkeyup="moveCursor('tel1')"> - <input name="tel2" id="tel2" type="text" style="width: 100px" maxlength="4" onkeyup="moveCursor('tel2')"> - <input name="tel3" id="tel3" type="text" style="width: 100px" maxlength="4">
            </td>
        </tr>
        <tr>
            <td align="center" width="100">음력/양력</td>
            <td>
                &nbsp;<input type="radio" name="ms" value="0" checked>양력
                <input type="radio" name="ms" value="1">음력
            </td>
        </tr>
        <tr>
            <td align="center" width="100">생년월일</td>
            <td>
                &nbsp;<input name="birthday1" id="birthday1" type="text" style="width: 100px" maxlength="4" onkeyup="moveCursor('birthday1')"> - <input name="birthday2" id="birthday2" type="text" style="width: 100px" maxlength="2" onkeyup="moveCursor('birthday2')"> - <input name="birthday3" id="birthday3" type="text" style="width: 100px" maxlength="2">
            </td>
        </tr>
        <tr>
            <td align="center" width="100">주소</td>
            <td><textarea name="adress" maxlength="255" style="resize: none; margin: 0 9px 0 9px; width: 400px; height: 100px;"></textarea></td>
        </tr>
        </tbody>
</table>
    <br>
    <div align="center">
        <input type="submit" value="입력">&nbsp;&nbsp;&nbsp;
        <input type="button" onclick="history.back()" value="뒤로가기">
    </div>
</form>
<br>


<script>
    function moveCursor(elementName){
        if(elementName === 'tel1'){
            if(document.getElementById("tel1").value.length === 3){
                document.getElementById("tel2").focus();
            }
        }
        else if(elementName === 'tel2'){
            if(document.getElementById("tel2").value.length === 4){
                document.getElementById("tel3").focus();
            }
        }
        else if(elementName === 'birthday1'){
            if(document.getElementById("birthday1").value.length === 4){
                document.getElementById("birthday2").focus();
            }
        }
        else if(elementName === 'birthday2'){
            if(document.getElementById("birthday2").value.length === 2){
                document.getElementById("birthday3").focus();
            }
        }
    }
</script>
</body>
</html>
