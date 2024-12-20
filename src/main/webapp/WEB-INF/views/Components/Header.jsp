<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*, su.kami.demo.Shared.SharedStatics" %>
<%@ page import="org.springframework.web.util.UrlPathHelper" %>
<%@ page isELIgnored="false" %>
<c:set value="${pageContext.request.contextPath}" var="path" scope="application" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <%@ include file="./../Components/HtmlImports.jsp" %>
    <script>
        const JSP_PATH = '${path}';
        window.cascadingJSPPATH = JSP_PATH;
    </script>
</head>
<%
    String _CurrentPath0 = "initial", _CurrentUri = "unset";
    UrlPathHelper urlPathHelper = new UrlPathHelper();
    _CurrentPath0 = urlPathHelper.getOriginatingRequestUri(request);
    session.setAttribute("CurrPath", _CurrentPath0);
    try{
        _CurrentUri = request.getServerName() + ':' + request.getServerPort();
    }catch(Exception ex){}
    if (!_CurrentUri.equals("unset")) session.setAttribute("_uri ", _CurrentUri);
%>
<body>
    <div class="fixed w-full p-2 bg-slate-600 flex flex-shrink px-5 gap-5 shadow-lg header" style="z-index: 999">
        <div class="text-xl font-bold mb-1 text-white ">
            <a class="w-full h-full opacity-80 hover:opacity-100 transition" href="/">Example</a>
        </div>
        <div class="text-lg ?font-semibold mb-1 text-white ">
            <a class="w-full h-full border-b-0 hover:border-b-2 border-slate-100 transition" href="<c:url value="/employee/"/>" target="_self">
                Employee
            </a>
        </div>
        <div class="text-lg ?font-semibold mb-1 text-white ">
            <a class="w-full h-full border-b-0 hover:border-b-2 border-slate-100 transition" href="<c:url value="/employee/"/>" target="_self">
                Trader
            </a>
        </div>
        <div class="text-lg ?font-semibold mb-1 text-white ">
            <a class="w-full h-full border-b-0 hover:border-b-2 border-slate-100 transition" href="<c:url value="/employee/"/>" target="_self">
                Combined
            </a>
        </div>
        <div class="flex-grow"></div>
        <div class="text-lg ?font-semibold mb-1 mr-1 text-white ">=</div>
    </div>
