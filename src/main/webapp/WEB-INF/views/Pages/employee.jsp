
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

    }
    function submitNew(){

    }
    function requirePage(page){

    } // ?

    window.addEventListener("load", viewLoadControl);
    window.addEventListener("hashchange", (e) => {
        console.log(e);
        viewLoadControl();
    })
</script>
<div class="w-full min-h-screen bg-slate-300 py-12">

    <div class="grid w-5/6 lg:w-3/5 md:w-4/5 bg-black? grid p-5 mx-auto grid-cols-4 gap-3.5">
        <h1 class="p-5 font-bold text-5xl py-6 col-span-full text-slate-900">Employee Management</h1>
        <div class="bg-slate-100/90 shadow-md rounded-lg col-span-2 md:col-span-3 overflow-y-hidden overflow-x-auto">
            <div id="tableContainer" style="display: none">
                <%@include file="./../Components/EmployeeTable.jsp" %>
            </div>
            <div id="formContainer" style="display: none">
                form
            </div>
        </div>
        <div class="flex flex-shrink flex-col gap-3.5 w-full col-span-2 md:col-span-1 min-w-[175px] max-w-full grid-cols-1 side h-full? bg-slate-100/90 shadow-md rounded-lg p-5 ">

                <a href="/employee#show">
                    <div class="p-3 px-3.5 rounded-lg border shadow-md transition hover:shadow-lg scale-100 hover:scale-105 active:shadow active:scale-95 select-none cursor-pointer bg-slate-200/80 hover:bg-slate-200 active:bg-slate-300/50 ">
                        List All
                    </div>
                </a>
                <a href="/employee#new">
                    <div class="p-3 px-3.5 rounded-lg border shadow-md transition hover:shadow-lg scale-100 hover:scale-105 active:shadow active:scale-95 select-none cursor-pointer bg-slate-200/80 hover:bg-slate-200 active:bg-slate-300/50 ">
                        Create/Update
                    </div>
                </a>
                <a href="/employee#remove">
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