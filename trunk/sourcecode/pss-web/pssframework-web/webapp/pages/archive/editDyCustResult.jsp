<%@include file="../../commons/taglibs.jsp"%>



<%@page contentType="text/html; charset=UTF-8"%>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<link href="<peis:contextPath />/css/style.css" rel="stylesheet" type="text/css">

<script type="text/javascript" language="javascript" src="<peis:contextPath/>/js/common/calendar.js"></script>
<script type="text/javascript" language="javascript" src="<peis:contextPath/>/js/common/common.js"></script>
<html:html lang="true">
  <head>
    <html:base />
    
    <title>编辑低压用户返回结果</title>

  </head>
<script type="text/javascript" language="javascript">

function init(result){
	if(result=='1'){
		alert("更新低压用户成功");
		parent.window.opener.location.href = parent.window.opener.location.href;
		parent.window.close();
	}
	else{
		alert("更新低压用户失败");
	}
}

</script>
  
  <body onload="init('<bean:write name="result"/>')">
    
  </body>
</html:html>
