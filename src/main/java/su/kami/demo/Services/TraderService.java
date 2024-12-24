package su.kami.demo.Services;

import su.kami.demo.DataAccess.DAO.RelatedTrader;
import su.kami.demo.DataAccess.Interfaces.DAO;
import su.kami.demo.Models.Trader;
import su.kami.demo.Shared.SharedStatics;
import su.kami.demo.utils.HtmlTableCellWrapper;
import su.kami.demo.utils.QueriedPageTools.Page;

import java.util.Map;

public class TraderService implements Service{
    private RelatedTrader relatedTrader;
    private Page<Trader> pagination;

    private String[] tableHead = new String[]{
            "#",
            "Contact",
            "Name",
            "Type",
            "RegBy",
            "Note"
    };

    public TraderService(RelatedTrader relatedTrader) {
        this.relatedTrader = relatedTrader;
        this.pagination = new Page<Trader>(relatedTrader); // todo which one it will use
    }

    public Page<Trader> getPagination() {return this.pagination;}

    public boolean isExist(int id){
        var find = this.relatedTrader.get(id);
        return (find != null && find.traderID != -1);
    }

    public Trader get(int id) {
        return relatedTrader.get(id);
    }

    public void delete(Trader trader) {
        relatedTrader.delete(trader);
    }

    public void update(Trader trader) {
        relatedTrader.update(trader);
    }

    public void insert(Trader trader) throws Exception {
        relatedTrader.add(trader);
    }

    public String getPagedHtmlTable(int pageNumber, int pageSize, String tableClasses, String cellClasses) {
        if(pageSize == 0) pageSize = 8;
        String result = "";
        try{
            pagination.stateHasChanged();
            pagination.setPageSize(pageSize);
            pagination.gotoPage(pageNumber);

            HtmlTableCellWrapper wrapper = new HtmlTableCellWrapper((this.tableHead.length - 1), "<a href=\"javascript:alert('@@HERE@@')\" class=\"text-blue-400 opacity-80 hover:opacity-100 underline\">View</a>", "@@HERE@@");


            result = SharedStatics.publicTableHelper
                    .giveHtmlTable(
                            this.tableHead,
                            "text-left inline-block? border-l border-r border-slate-500 px-1 font-semibold text-lg",
                            null,
                            SharedStatics.publicTableHelper.toMappedStrings(pagination.pageContent),
                            cellClasses,
                            null,
                            (Map.of("class", tableClasses)),
                            false,
                            wrapper
                    );

        }catch(Exception e){
            e.printStackTrace();
            return "No Content Returned.";
//            return "500-? Internal Server Error: " + e.toString();
        }

        return result;
    }

    @Override
    public DAO<Trader> lendAgent() {
        return this.relatedTrader;
    }
}
