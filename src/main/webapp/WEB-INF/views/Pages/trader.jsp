
<%@include file="./../Components/Header.jsp"%>
<script>title("h1")</script>
<script>
    function viewLoadControl(){
        let hash = window.location.hash;
        switch (hash.replace("#", "")){
            //
            case "new":
                document.getElementById("formContainer").style.display = "block";
                document.getElementById("tableContainer").style.display = "none";

                break;

            case "show":
                document.getElementById("tableContainer").style.display = "block";
                document.getElementById("formContainer").style.display = "none";
                break;

            case "remove":
                document.getElementById("tableContainer").style.display = "block";
                document.getElementById("formContainer").style.display = "none";
                submitRemove();
                break;

            default:
                window.location.replace(`${window.location.href}#show`);
                return;
        }
    }

    function submitRemove(){
        let targetOfRemove = prompt("Which one you'd like to remove? Enter the ID:");
        targetOfRemove = parseInt(targetOfRemove);
        if(isNaN(targetOfRemove)) {
            alert("Wrong Input");
            return;
        }
        submit(('/submit/trader/remove/' + targetOfRemove), null, 'get', () => {
            alert("Sent Message to the Server.");
            window.location.replace(window.location.href.replace("#remove", ""));
        });
    }
    function submitNew(){

    }

    window.addEventListener("load", viewLoadControl);
    window.addEventListener("hashchange", (e) => {
        console.log(e);
        viewLoadControl();
    })

    const message = '<%=session.getAttribute("_msg")%>';
    if(message.includes("REMOVE") && message.includes("Error occurred")) {
        alert('One pending operation failed:\n' + message);
        submit('/submit/base/clearMsg', null);
    }
</script>
<div class="w-full min-h-screen bg-slate-300 py-12">

    <div class="grid w-5/6 lg:w-3/5 md:w-4/5 bg-black? grid p-5 mx-auto grid-cols-4 gap-3.5">
        <h1 class="p-5 font-bold text-5xl py-6 col-span-full text-slate-900">Trader Management</h1>
        <div class="bg-slate-100/90 shadow-md rounded-lg col-span-2 md:col-span-3 ">
            <div id="tableContainer" style="display: none" class="h-full relative">
                <%@include file="./../Components/TraderTable.jsp" %>
            </div>
            <div id="formContainer" style="display: none" class="h-full relative">
                <%@include file="./../Components/TraderInputForm.jsp"%>
            </div>
        </div>
        <div class="flex flex-shrink flex-col gap-3.5 w-full col-span-2 md:col-span-1 min-w-[175px] max-w-full grid-cols-1 side h-fit bg-slate-100/90 shadow-md rounded-lg p-5 ">

            <a href="<c:url value="/trader"/>">
                <div class="p-3 px-3.5 rounded-lg border shadow-md transition hover:shadow-lg scale-100 hover:scale-105 active:shadow active:scale-95 select-none cursor-pointer bg-slate-200/80 hover:bg-slate-200 active:bg-slate-300/50 ">
                    List All
                </div>
            </a>
            <a href="#new">
                <div class="p-3 px-3.5 rounded-lg border shadow-md transition hover:shadow-lg scale-100 hover:scale-105 active:shadow active:scale-95 select-none cursor-pointer bg-slate-200/80 hover:bg-slate-200 active:bg-slate-300/50 ">
                    Create/Update
                </div>
            </a>
            <a href="#remove">
                <div class="p-3 px-3.5 rounded-lg border shadow-md transition hover:shadow-lg scale-100 hover:scale-105 active:shadow active:scale-95 select-none cursor-pointer bg-slate-200/80 hover:bg-slate-200 active:bg-slate-300/50 ">
                    Remove (prompt)
                </div>
            </a>

            <div class="">

            </div>

        </div>


    </div>
</div>
<%@include file="./../Components/Footer.jsp"%>