<%@page contentType="text/html; charset=utf-8"%>
<%@include file="../../commons/taglibs.jsp"%>
<%@include file="../../commons/taglibs.jsp"%>


<html>
<head>
<meta http-equiv="Content-Language" content="zh-cn">
<meta http-equiv="Content-Type" content="text/html;charset=gb2312">
<title>ResultFresh</title>
<link href="<peis:contextPath/>/style/style.css" rel="stylesheet" type="text/css">
</head>

<body>
<script type="text/javascript">
var contextPath = "<peis:contextPath/>";
var iResult = parseInt('<peis:param type="PAGE" paramName="iResult"/>');
var sResult = '<peis:param type="PAGE" paramName="sResult"/>';
var Id = '<peis:param type="PAGE" paramName="Id"/>';

if(iResult >= 0) {
    alert(sResult);
    top.GB_hide();
    top.getMainFrameObj().subContent.location.href = contextPath + '/jsp/system/userManagerFrame.jsp?random=' + Math.random();
}
else {
    alert(sResult);
}
</script>
</body>

</html>
