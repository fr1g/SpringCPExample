<%@ page import="su.kami.demo.Shared.SharedStatics" %>
<%@ page import="su.kami.demo.Services.BaseService" %>
<%@ page import="su.kami.demo.Models.Trader" %>
<%@ page import="su.kami.demo.utils.QueriedPageTools.Page" %>
<%@ page import="su.kami.demo.utils.QueriedPageTools.PaginationException" %>
<%--In Session Storage The Requiring Page Number?--%>
<%
  int pageNumber, totalPage, pageSize = 12;
  BaseService service = (BaseService) SharedStatics.dynamicShared.services.get("BaseService");
  Page<Trader> pagination = service.getPagination();
  String forPrev = "", forNext = "";
  try {

    pagination.setPageSize(pageSize);

    if(session.getAttribute("combined/currentPage") == null){
      pageNumber = 1;
      session.setAttribute("combined/currentPage", pageNumber);
    } else pageNumber = (Integer)session.getAttribute("combined/currentPage");

//        pagination.stateHasChanged();
    pagination.setCurrentPage(pageNumber);
    pagination.stateHasChanged();

    totalPage = pagination.getTableTotalPages();
    forPrev = pagination.hasPrevious() ? "" : "disabled";
    forNext = pagination.hasNext() ? "" : "disabled";

  } catch (PaginationException e) {
    totalPage = -1;
    pageNumber = 1;
    e.printStackTrace();
    out.print(e);
    out.print("CurrPage: " + session.getAttribute("combined/currentPage"));
  }

  String result = service.getCombinedTableHtml(pageNumber, pageSize, "w-full bg-slate-200 rounded-lg p-3", "p-1");
%>
<div id="rely" class="p-3 bg-slate-200 rounded-lg overflow-y-hidden overflow-x-auto pb-[83px]" >
  <div class="w-screen">
    <%=result%>
  </div>
</div>

<div id="control" class="w-full grid grid-cols-3 gap-3 p-3.5 bg-slate-100/90 rounded-lg hover:bg-slate-100 transition absolute? bottom-0" >
  <div id="prev" class="controlled <%=forPrev%> text-center text-xl p-3 px-3.5 rounded-lg border shadow-md transition hover:shadow-lg scale-100 hover:scale-105 active:shadow active:scale-95 select-none cursor-pointer bg-slate-200/80 hover:bg-slate-200 active:bg-slate-300/50 ">
    Back
  </div>
  <div class="text-xl text-center grid items-center justify-item-center place-items-center">
    <div><%=pageNumber%>/<%= totalPage %></div>
  </div>
  <div id="next" class="controlled <%=forNext%> text-center text-xl p-3 px-3.5 rounded-lg border shadow-md transition hover:shadow-lg scale-100 hover:scale-105 active:shadow active:scale-95 select-none cursor-pointer bg-slate-200/80 hover:bg-slate-200 active:bg-slate-300/50 ">
    Next
  </div>
</div>
<script>
  document.getElementById("control").addEventListener("click", (e) => {
    if(!e.target.classList.contains("controlled") || e.target.classList.contains("disabled")) return;
    switch (e.target.id){
            // shall we use iframe instead? no, this is just a homework.
      case "prev":
        submit('/submit/combined/page/<%=pageNumber - 1%>', null, "get", () => {
          window.location.reload()
        });
        break;

      case "next":
        if(!e.shiftKey) submit('/submit/combined/page/<%=pageNumber + 1%>', null, "get", () => {
          window.location.reload()
        });
        else submit('/submit/combined/page/<%=totalPage%>', null, "get", () => {
          window.location.reload()
        });
        break;

      default:
        // because the backend restful api is GET so only will refresh after confirmed the get request sent
        // this will cause some possibility of cannot reach the newest data thru session.
        // because... what if the database looked up for too long?

        return;
    }

  });
</script>