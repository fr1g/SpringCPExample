
<%@include file="./../Components/Header.jsp"%>
<script>title("h1")</script>

<div class="w-full min-h-screen bg-slate-300 py-12">
    <div class="grid w-5/6 lg:w-3/5 md:w-4/5 bg-black? grid p-5 mx-auto grid-cols-2 gap-3.5">
        <h1 class="p-5 font-bold text-5xl py-6 col-span-full text-slate-900">Employee Management</h1>
        <div class="bg-slate-100/90 shadow-md rounded-lg p-5">

        </div>
        <div class="grid gap-3.5 w-full max-w-full grid-cols-1 side">
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
                <div class="grid grid-cols-2 gap-1.5 translate-y-1">
                    <a href="/employee/" target="_blank">
                        <div class="p-3 px-3.5 rounded-lg border shadow-md transition hover:shadow-lg scale-100 hover:scale-105 active:shadow active:scale-95 select-none cursor-pointer bg-slate-200/80 hover:bg-slate-200 active:bg-slate-300/50 ">
                            View the Employee BasePage &gt;
                        </div>
                    </a>
                </div>
            </div>
        </div>


    </div>
</div>
<%@include file="./../Components/Footer.jsp"%>