<%@ page language="java" pageEncoding="UTF-8"%>

<%@include file="../../commons/taglibs.jsp"%>
<%@include file="../../commons/taglibs.jsp"%>


<html>
  <head>
  <meta http-equiv="pragma" content="no-cache"/>
    <meta http-equiv="cache-control" content="no-cache"/>
    <meta http-equiv="expires" content="0"/>
    <link rel="stylesheet" type="text/css" href="<peis:contextPath/>/css/mainframe.css"/>
    <script type="text/javascript" src="<peis:contextPath/>/js/common/calendar.js"></script>
    <script type="text/javascript" src="<peis:contextPath/>/js/dataQuery.js"></script>
    <script type="text/javascript" src="<peis:contextPath/>/js/jquery.js"></script>
    <script type="text/javascript" src="<peis:contextPath/>/js/component.js"></script>
    <script type="text/javascript">
    var lastShowType;
    var contextPath = "<peis:contextPath/>";
    var date;
    var year;
    var month;
    var opwindow = null;     //记录打开浏览窗口的对象
    function doSubmit(objectID,objectType)
    {
       document.getElementsByName("object_id")[0].value = objectID;
       document.getElementsByName("object_type")[0].value = objectType;
       document.forms[0].submit();
    }
    </script>
  </head>
  
  <body onload="voltInit()">
    <html:form action="/do/autorm/voltQuery" method="post">
    <html:hidden property="action" value="getQuery"/>
    <html:hidden property="pageType" value="page"/>
    <html:hidden property="sqlcode"/>
    <html:hidden property="showType"/>
    <html:hidden property="seq"/>
    <html:hidden property="object_id"/>
    <html:hidden property="object_type"/>
      <div id="main">
        <div>
          <div id="tool">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
              <tr>
                <td class="label"><bean:message bundle="autorm" key="autorm.dataquery.lable.help"/>：</td>
                <td colspan="4"><bean:message bundle="autorm" key="autorm.dataquery.lable.help.volt"/></td>
              </tr>
              <tr>
                <td width="286" colspan="2">
                  <html:radio property="sys_object" value="1" onclick="parent.changeTreeMode('99991002')"><bean:message bundle="autorm" key="autorm.dataquery.lable.zbyh"/></html:radio>
                  <html:radio property="sys_object" value="2" onclick="parent.changeTreeMode('99991003')"><bean:message bundle="autorm" key="autorm.dataquery.lable.pbtq"/></html:radio>
                  <html:radio property="sys_object" value="3" onclick="parent.changeTreeMode('99991003')"><bean:message bundle="autorm" key="autorm.dataquery.lable.dyyh"/></html:radio>
                  <html:radio property="sys_object" value="4"><bean:message bundle="autorm" key="autorm.dataquery.lable.bdz"/></html:radio>
                </td>
                <td width="66" class="label"><bean:message bundle="autorm" key="autorm.dataquery.lable.dxbh"/>：</td>
                <td width="120" class="dom"><peis:text name="object_no" type="text" /></td>
                <td></td>
              </tr>
              <tr>
                <td width="66" class="label"><bean:message bundle="autorm" key="autorm.dataquery.lable.sjlx"/>：</td>
                <td width="220" class="dom"><peis:selectlist name="dateType" sql="QUERY0011" onChange="voltDTChange()"/></td>
                <td class="label"><bean:message bundle="autorm" key="autorm.dataquery.lable.sjsj"/>：</td>
                <td>
                  <div id="DATA_DAY" style="display: block;">
                    <peis:text name="date" type="text" styleClass="styleDate" />
                    <a onclick="event.cancelBubble=true;" href="javascript:showCalendar('dimg1',false,'date',null)">
                      <img name="dimg1" src="<peis:contextPath/>/images/common/calendar.gif" width="34" height="21" align="middle" border="0" alt=""/>
                    </a>
                  </div>
                  <div id="DATA_MONTH" style="display: none;">
                    <peis:text name="year" type="text" styleClass="styleYear" /><bean:message bundle="autorm" key="autorm.dataquery.lable.year"/>
                    <peis:text name="month" type="text" styleClass="styleMonth" /><bean:message bundle="autorm" key="autorm.dataquery.lable.month"/>
                  </div>
                </td>
                <td>
		            <html:submit styleClass="input" onclick="document.getElementsByName('object_type')[0].value = '';"><bean:message bundle="autorm" key="autorm.dataquery.lable.query"/></html:submit>
	                <input type="button" class="input" value="<bean:message bundle='autorm' key='autorm.dataquery.lable.zhcx'/>"/>
                </td>
              </tr>
            </table>
          </div>
        </div>
        <div class="content">
          <div id="cont_3">
            <div class="target">
              <ul>
                <li class="target_off" id="show1"><a href="#" onclick="voltShowType(1)"><bean:message bundle="autorm" key="autorm.dataquery.lable.axsj"/></a></li>
                <li class="target_off" id="show2"><a href="#" onclick="voltShowType(2)"><bean:message bundle="autorm" key="autorm.dataquery.lable.bxsj"/></a></li>
                <li class="target_off" id="show3"><a href="#" onclick="voltShowType(3)"><bean:message bundle="autorm" key="autorm.dataquery.lable.cxsj"/></a></li>
                <li class="clear"></li>
              </ul>	
            </div>
            <div class="tableContainer" style="height:expression(((document.documentElement.clientHeight||document.body.clientHeight) - 172));">
                    <table id="data_table" align="center" width="100%" border="0" cellpadding="0" cellspacing="0">
                     <thead>
                      <tr id="QUERY_TR_1" style="display: none">
                         <th width="40px"><bean:message bundle="autorm" key="autorm.dataquery.lable.no"/></th>
				         <th width="80px"><bean:message bundle="autorm" key="autorm.dataquery.lable.dxbh"/></th>
				         <th width="160px"><bean:message bundle="autorm" key="autorm.dataquery.lable.dxmc"/></th>
				         <th width="160px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cld"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.axdyfz"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.axdyfzfssj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.axdygz"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.axdygzfssj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.axysxsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.axdyhgljsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.axyssxsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.axyxxsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.axyxxxsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.axpjdy"/></th>
				         <th width="80px"><bean:message bundle="autorm" key="autorm.dataquery.lable.ck"/></th>
                    </tr>
                    <tr id="QUERY_TR_2" style="display: none">
                         <th width="40px"><bean:message bundle="autorm" key="autorm.dataquery.lable.no"/></th>
				         <th width="80px"><bean:message bundle="autorm" key="autorm.dataquery.lable.dxbh"/></th>
				         <th width="160px"><bean:message bundle="autorm" key="autorm.dataquery.lable.dxmc"/></th>
				         <th width="160px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cld"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.bxdyfz"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.bxdyfzfssj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.bxdygz"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.bxdygzfssj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.bxysxsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.bxdyhgljsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.bxyssxsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.bxyxxsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.bxyxxxsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.bxpjdy"/></th>
				         <th width="80px"><bean:message bundle="autorm" key="autorm.dataquery.lable.ck"/></th>
                    </tr>
                    <tr id="QUERY_TR_3" style="display: none">
                         <th width="40px"><bean:message bundle="autorm" key="autorm.dataquery.lable.no"/></th>
				         <th width="80px"><bean:message bundle="autorm" key="autorm.dataquery.lable.dxbh"/></th>
				         <th width="160px"><bean:message bundle="autorm" key="autorm.dataquery.lable.dxmc"/></th>
				         <th width="160px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cld"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cxdyfz"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cxdyfzfssj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cxdygz"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cxdygzfssj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cxysxsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cxdyhgljsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cxyssxsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cxyxxsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cxyxxxsj"/></th>
				         <th width="180px"><bean:message bundle="autorm" key="autorm.dataquery.lable.cxpjdy"/></th>
				         <th width="80px"><bean:message bundle="autorm" key="autorm.dataquery.lable.ck"/></th>
                    </tr>
                    </thead>
                    <tbody>
                 <logic:present name="PG_QUERY_RESULT">
		         <logic:iterate id="datainfo" name="PG_QUERY_RESULT">
		            <tr>
		                 <td><bean:write name="datainfo" property="rowNo"/></td>
				         <td><bean:write name="datainfo" property="col1"/></td>
				         <td><bean:write name="datainfo" property="col2"/></td>
				         <td><bean:write name="datainfo" property="col3"/></td>
				         <td><bean:write name="datainfo" property="col4"/></td>
				         <td><bean:write name="datainfo" property="col5"/></td>
				         <td><bean:write name="datainfo" property="col6"/></td>
				         <td><bean:write name="datainfo" property="col7"/></td>
				         <td><bean:write name="datainfo" property="col8"/></td>
				         <td><bean:write name="datainfo" property="col9"/></td>
				         <td><bean:write name="datainfo" property="col10"/></td>
				         <td><bean:write name="datainfo" property="col11"/></td>
				         <td><bean:write name="datainfo" property="col12"/></td>
				         <td><bean:write name="datainfo" property="col13"/></td>
				         <td id="LINE_TD_1" style="display: none">
				            <a href="javascript:voltDetail(900,450,'<bean:write name="datainfo" property="col14"/>','<bean:write name="datainfo" property="col15"/>','<bean:write name="datainfo" property="col1"/>',2)"><bean:message bundle="autorm" key="autorm.dataquery.lable.ckqx"/></a></td>
				         <td id="DAY_TD_1" style="display: none">
				            <a href="javascript:voltDetail(900,600,'<bean:write name="datainfo" property="col14"/>','<bean:write name="datainfo" property="col15"/>','<bean:write name="datainfo" property="col1"/>',3)"><bean:message bundle="autorm" key="autorm.dataquery.lable.ckrsj"/></a></td>
		            </tr>
		         </logic:iterate>
                 </logic:present>
                 </tbody>
                 </table>
			</div>
            <div class="pageContainer" id="PAGE_DAY" style="display: ;">
              <peis:pagination sql="QUERY0014" queryActionPath="do/autorm/voltQuery" allowRowsChange="true"/>
            </div>
          </div>
        </div>
      </div>
     </html:form>
  </body>
</html>