<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*, su.kami.demo.Shared.SharedStatics" %>
<%@ page import="org.springframework.web.util.UrlPathHelper" %>
<%@ page import="su.kami.demo.Services.BaseService" %>
<%@ page import="su.kami.demo.Services.EmployeeService" %>
<%@ page isELIgnored="false" %>
<c:set value="${pageContext.request.contextPath}" var="path" scope="application" />

<%@include file="Components/Header.jsp"%>
<script>title("h1")</script>

    <div class="w-full min-h-screen bg-slate-300 py-12">
        <div class="grid w-5/6 lg:w-3/5 md:w-4/5 bg-black? grid p-5 mx-auto grid-cols-2 gap-3.5">
            <h1 class="p-5 font-bold text-5xl py-6 col-span-full text-slate-900">Behold! this is the Index Page.</h1>
            <div class="grid gap-3.5 w-full max-w-full grid-cols-1">
                <div class=" h-full bg-slate-100/90 shadow-md rounded-lg p-5 ">
                    <h5 class="text-xl font-bold break-all">What's this?</h5>
                    <p>
                        This is the 5th crossPlatformAppDeveloping course work.
                        <br>
                        I have nothing to say on that, seriously. And to be honest, I <span class="font-semibold italic inline-block">hate java</span> a lot.
                    </p>
                </div>
                <div class=" bg-slate-100/90 h-full shadow-md rounded-lg p-5  block ">
                    <h5 class="text-xl font-bold mb-1.5">View the <br>Combined table of all</h5>

                </div>
            </div>


            <div class=" bg-slate-50 shadow-md rounded-lg p-5 text-center ">
                <h5 class="text-xl font-bold mb-1.5">About</h5>
                <p>You can add the Lorem Ipsulm dolor Sit Amet lmaoff.</p>
                <p>This work was completed by Haisu Chen. Using his 【.NET developing experience.】<br>with help of tailwindcss and springframework</p>
                <img src="https://avatars.githubusercontent.com/u/53085628?v=4" alt="" width="50%" style="opacity: 85%;" class="scale-90 hover:scale-105 animate-none hover:animate-spin fix-spin transition rounded-full inline-block mx-auto shadow-lg my-3">
            </div>

            <div class=" bg-slate-100/90 shadow-md rounded-lg p-5 col-span-full lg:col-span-0 ">
                <h5 class="text-xl font-bold mb-1.5">Operations on <br><span class="font-semibold">Employees</span></h5>
                <div class="grid grid-cols-2 gap-5 translate-y-1">
                    <a href="/employee" target="_blank">
                        <div class="p-3 px-3.5 rounded-lg border shadow-md transition hover:shadow-lg scale-100 hover:scale-105 active:shadow active:scale-95 select-none cursor-pointer bg-slate-200/80 hover:bg-slate-200 active:bg-slate-300/50 ">
                            View the Employee BasePage &gt;
                        </div>
                    </a>
                    <a href="/employee#new" target="_blank">
                        <div class="p-3 px-3.5 rounded-lg border shadow-md transition hover:shadow-lg scale-100 hover:scale-105 active:shadow active:scale-95 select-none cursor-pointer bg-slate-200/80 hover:bg-slate-200 active:bg-slate-300/50 ">
                            Create a record of Employee &gt;
                        </div>
                    </a>
                </div>
            </div>

            <div class=" bg-slate-100/90 shadow-md rounded-lg p-5 col-span-full lg:col-span-0 ">
                <h5 class="text-xl font-bold mb-1.5">Operations on <br><span class="font-semibold">Traders</span></h5>
                <div class="grid grid-cols-2 gap-5 translate-y-1">
                    <a href="/employee" target="_blank">
                        <div class="p-3 px-3.5 rounded-lg border shadow-md transition hover:shadow-lg scale-100 hover:scale-105 active:shadow active:scale-95 select-none cursor-pointer bg-slate-200/80 hover:bg-slate-200 active:bg-slate-300/50 ">
                            View the Employee BasePage &gt;
                        </div>
                    </a>
                    <a href="/employee#new" target="_blank">
                        <div class="p-3 px-3.5 rounded-lg border shadow-md transition hover:shadow-lg scale-100 hover:scale-105 active:shadow active:scale-95 select-none cursor-pointer bg-slate-200/80 hover:bg-slate-200 active:bg-slate-300/50 ">
                            Create a record of Employee &gt;
                        </div>
                    </a>
                </div>
            </div>

            <div class=" bg-slate-100/90 shadow-md text-sm rounded-lg p-5 col-span-full lg:col-span-0 ">
                Nothing's here.<br>
                ...don't you think this schema of color palette is way better than default JavaDocs?
            </div>

        </div>
    </div>
<%@include file="Components/Footer.jsp"%>