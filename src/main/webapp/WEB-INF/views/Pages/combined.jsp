
<%@include file="./../Components/Header.jsp"%>
<script>title("h1")</script>
<script>
    const message = '<%=session.getAttribute("_msg")%>';
    if(message.includes("REMOVE") && message.includes("Error occurred")){
        submit('/submit/base/clearMsg', null);
        alert('One pending operation failed:\n' + message);
    }
</script>
<div class="w-full min-h-screen bg-slate-300 py-12">

    <div class="grid w-5/6 lg:w-3/5 md:w-4/5 bg-black? grid p-5 mx-auto grid-cols-4 gap-3.5">
        <h1 class="p-5 font-bold text-5xl py-6 col-span-full text-slate-900">Combined View</h1>
        <div class="bg-slate-100/90 shadow-md rounded-lg col-span-2 md:col-span-3 ">
            <div id="tableContainer"   class="h-full relative">
                <%@include file="./../Components/CombinedTable.jsp" %>
            </div>

        </div>
        <div class="flex flex-shrink flex-col gap-3.5 w-full col-span-2 md:col-span-1 min-w-[175px] max-w-full grid-cols-1 side h-fit bg-slate-100/90 shadow-md rounded-lg p-5 ">

            <p>
                This place shows as the view in MySQL.
            </p>

        </div>


    </div>
</div>
<%@include file="./../Components/Footer.jsp"%>