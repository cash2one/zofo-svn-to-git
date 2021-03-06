<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="/e3/commons/Common.jsp"%>
<%@ taglib prefix="e3t" uri="/e3/table/E3Table.tld" %>
<%@ page contentType="text/html; charset=utf-8"%>

<HTML>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
	<script src="<c:url value="/e3/commons/E3.js"/>"/>
	<script>
	alert('dddddddddddddddddd');  
	  
	</script>

</HEAD>
<BODY>
<c:url var="uri" value="/servlet/tableServlet?_actionType=showDecoratorTable"/>

<div>
<e3t:table id="userTable"
           var="user"
           varStatus="userStatus"
           items="users"
           caption="用户管理"
           uri="${uri}"
            toolbarPosition = "both"
           toolbarShowPolicy="always"
         > 
    <e3t:column property="userID" style="width:120px"  title="用户ID" ></e3t:column>          
    <e3t:column property="userName" style="width:120px" title="用户名称" />            
    <e3t:column property="sex"     style="width:120px" title="性别" >                
             <c:choose>
               <c:when test="${user.sex == 1}">
                   男
               </c:when>
               <c:when test="${user.sex == 0}">
                   女
               </c:when>
               <c:otherwise>
                   没填
               </c:otherwise>
             </c:choose>  
    </e3t:column>
    <e3t:column property="birthday"   style="width:120px"   title="生日" >
       <fmt:formatDate value="${user.birthday}" pattern="yyyy年MM月dd日"/>
    </e3t:column>
    <e3t:column property="remark"   title="备注" style="text-align:left;" />
    
     <c:if test="${userStatus.last}">
<e3t:appendRow>
      <e3t:attribute name="style" value="background-color:#CCCCFF"/>
      <e3t:addCell>
        小计:
      </e3t:addCell>
      <e3t:addCell>
        -
      </e3t:addCell>
      <e3t:addCell>
        -
      </e3t:addCell>
      <e3t:addCell>
        -
      </e3t:addCell>
      <e3t:addCell>
        -
      </e3t:addCell>
      
    </e3t:appendRow>     
     <e3t:appendRow>
      <e3t:attribute name="style" value="background-color:#CCCCFF"/>
      <e3t:addCell>
        合计:
      </e3t:addCell>
      <e3t:addCell>
                <input type="button" value="统计汇总"/>
      </e3t:addCell>
      <e3t:addCell>
                <input type="button" value="统计汇总"/>
      </e3t:addCell>
      <e3t:addCell>
                <input type="button" value="统计汇总"/>
      </e3t:addCell>
      <e3t:addCell>
                <input type="button" value="统计汇总"/>
      </e3t:addCell>
      
    </e3t:appendRow>
    
    </c:if>
    
</e3t:table>
</div>          
</BODY>
</HTML>
