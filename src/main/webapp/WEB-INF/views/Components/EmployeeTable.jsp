<%@ page import="su.kami.demo.Shared.SharedStatics" %>
<%@ page import="su.kami.demo.Controllers.Rest.EmployeeRest" %>
<%@ page import="su.kami.demo.Services.EmployeeService" %><%--<% int pageNumber = 1; %>--%>
<%--In Session Storage The Requiring Page Number?--%>
<%
    int pageNumber;
    if(session.getAttribute("currentPage") == null){
        pageNumber = 1;
        session.setAttribute("currentPage", pageNumber + "");
    } else pageNumber = Integer.parseInt((String) session.getAttribute("currentPage"));
    EmployeeService service = (EmployeeService) SharedStatics.dynamicShared.services.get("EmployeeService");
    String result = service.getPagedHtmlTable(pageNumber, 0, "w-full bg-slate-200 rounded-lg p-3", "p-1");
%>
<div id="rely" class="w-screen p-3 bg-slate-200">
    <%=result%>
</div>
<div >

</div>