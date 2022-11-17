<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/admin/include/header.jsp" %>

<!--CSS-->
<style>
#memid{ border-radius:10px; border-color:#e2e2e2;}
#mempass{ border-radius:10px; border-color:#e2e2e2;}
#mempass2{ border-radius:10px; border-color:#e2e2e2;}
#memname{ border-radius:10px; border-color:#e2e2e2;}
#memphone{ border-radius:10px; border-color:#e2e2e2;}
#mememail1{ border-radius:10px; border-color:#e2e2e2;}
#mememail2{ border-radius:10px; border-color:#e2e2e2;}
#memage{ border-radius:10px; border-color:#e2e2e2;}
#sample4_postcode{ border-radius:10px; border-color:#e2e2e2;}
#sample4_roadAddress{ border-radius:10px; border-color:#e2e2e2;}
#sample4_jibunAddress{border-radius:10px; border-color:#e2e2e2;}
#sample4_detailAddress{ border-radius:10px;border-color:#e2e2e2;}
#sample4_extraAddress{ border-radius:10px; border-color:#e2e2e2;}
table {font-size: 100%;}
input:focus{outline: none;}
</style>


<!--ID PASS 전송함수-->
<script type="text/javascript">
function join2(){
	if(memid.value == ""){
			alert("아이디를 입력하세요.");
			memid.focus
			return false;
	}
	if(!mempass.value){
			alert("비밀번호를 입력하세요.");
			mempass.focus
			return false;
		}
	if(!mempass2.value){
			alert("비밀번호 확인을 입력하세요.");
			mempass.focus
			return false;
	}
	if(mempass.value !== mempass2.value){
			alert("비밀번호가 틀립니다\n다시 확인해주세요")
			mempass2.focus
			return false;
	}
	document.submit();
}




//<!--중복확인 함수-->
function id_match(){
	var str = memid.value;
	window.open("/member/id_match.jsp?id="+str,"a","width=300, height=300");
}
</script>

<script>
function checkEmail(){
	if(document.join_insert.emailList.value !=""){
		document.join_insert.mememail2.value = document.join_insert.emailList.value;
	}else{
		document.join_insert.mememail2.value="";
		document.join_insert.mememail2.focus();
	}
}
</script>


<!--DB연동 id의값들을 검색-->
<%
String id2 = request.getParameter("id");
String sql = "select * from member where id='"+id2+"'";

Connection conn = DriverManager.getConnection(url,user,password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

//<!--DB안에 있는 데이터를 불러옴-->
if(rs.next()){
	String memid = rs.getString("id");
	String memname = rs.getString("name");
	String memphone = rs.getString("phone");
	String mememail1 = rs.getString("email1");
	String mememail2 = rs.getString("email2");
	String memzipcode = rs.getString("zipcode");
	String memzipcode1 = rs.getString("zipcode1");
	String memzipcode2 = rs.getString("zipcode2");
	String memzipcode3 = rs.getString("zipcode3");
	String memzipcode4 = rs.getString("zipcode4");
	String memgender = rs.getString("gender");
	String memage = rs.getString("age");
	

%>
<!--회원정보 수정값들을 전송-->
<form name="join_insert" action="/admin/member/modify_update.jsp" method="post" onsubmit="return join()">
<table width=700 border=0 align=center >
	<tr bgcolor="#c0f1f9" height=30>
		<td colspan=2 align=center style="font-size:20px;">
				<b>회원수정</b>
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;아이디</td>
		<td>
			<input id="memid" name="memid" value="<%=memid%>" >
			<span onclick="id_match()"style=font-size:15px;><button type="button">중복확인</button></span>
		</td>
	</tr>
	<tr >
		<td >&nbsp;&nbsp;비밀번호 입력</td>
		<td>
			<input id="mempass" name="mempass" value="">	
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;비밀번호 확인</td>
		<td>
			<input id="mempass2" name="mempass2" value="">
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;이름</td>
		<td>
			<input id="memname" name="memname" value="<%=memname%>">
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;나이</td>
		<td>
			<input type=text id="memage" name="memage" value="<%=memage%>">
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;연락처</td>
		<td>
			<input id="memphone" name="memphone" value="<%=memphone%>">
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;메일</td>
		<td>
			<input type="text" id="mememail1" name="mememail1" value="<%=mememail1 %>" placeholder="메일을 입력해주세요.">@
			<input type="text" id="mememail2" name="mememail2" value="<%=mememail2 %>" >
			<select id="emailList" name="emailList" onchange="return  checkEmail()">
				<option value="">==선택==</option>
				<option value="">직접입력</option>
				<option value="naver.com">naver.com</option>
				<option value="nate.com">nate.com</option>
				<option value="google.com">google.com</option>
			</select>
		</td>
	</tr>
	<tr>
		<td rowspan=3>&nbsp;&nbsp;주소</td>
		<td>
			<input type="text" id="sample4_postcode" name="zipcode" placeholder="우편번호" value="<%=memzipcode %>">&nbsp;&nbsp;
			<input type="button" onclick="sample4_execDaumPostcode()" value=우편번호찾기>
		</td>
	</tr>
	<tr>
		<td>
			<input type="text" id="sample4_roadAddress" name="zipcode1" placeholder="도로명주소"  value="<%=memzipcode1 %>">
			<input type="text" id="sample4_jibunAddress" name="zipcode2" placeholder="지번주소" value="<%=memzipcode2 %>">
			<span id="guide" style="color:#999;display:none"></span>
		</td>
	</tr>
	<tr>
		<td>
			<input type="text" id="sample4_detailAddress" name="zipcode3" placeholder="상세주소" value="<%=memzipcode3 %>">
			<input type="text" id="sample4_extraAddress" name="zipcode4" placeholder="참고항목" value="<%=memzipcode4 %>">
		</td>
	</tr>
	<tr>
		<td>&nbsp;&nbsp;성별</td>
		<td>
			<input type="radio" id="memgender" name="memgender" value="F"<%if(memgender.equals("F")){%> checked<%}%>>여자 
			<input type="radio" id="memgender" name="memgender" value="M"<%if(memgender.equals("M")){%> checked<%}%>>남자 
		</td>
	</tr>	
	<tr bgcolor="#e2e2e2">
		<td colspan=2><button>회원수정</button></td>
		<td></td>
	</tr>
</table>
</form>
<%
}
%>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
<%@ include file="/admin/include/footer.jsp" %>