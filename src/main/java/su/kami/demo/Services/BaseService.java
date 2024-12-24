package su.kami.demo.Services;

import su.kami.demo.DataAccess.Interfaces.DAO;
import su.kami.demo.Models.Employee;
import su.kami.demo.Models.Trader;

import su.kami.demo.Shared.SharedStatics;
import su.kami.demo.utils.HtmlTableCellWrapper;
import su.kami.demo.utils.QueriedPageTools.Page;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class BaseService implements Service<Trader> {
    public DAO<Employee> emp;
    public DAO<Trader> trader;
    public Page<Trader> pagination;

    HtmlTableCellWrapper wrapper;

    final int REG_BY = 4;

    String[] tableHead = new String[]{
            "#",
            "Contact",
            "Name",
            "Type",
//            "RegBy",
            "Note",

            " => REGISTRAR", "NAME", "CONTACT", "DATE of JOIN (local datetime)", "WORKTYPE"
    };

    public BaseService(DAO<?> emp, DAO<?> related){ // ?
        this.emp = (DAO<Employee>) emp;
        this.trader = (DAO<Trader>) related;
        this.pagination = new Page<>(this.trader);
        // because removed the RegBy so using direct value
        this.wrapper = new HtmlTableCellWrapper((this.REG_BY), "<a href=\"javascript:alert('@@HERE@@')\" class=\"text-blue-400 opacity-80 hover:opacity-100 underline\">View</a>", "@@HERE@@");
    }

    public String getCombinedTableHtml(int page, int pageSize, String tableClasses, String cellClasses){
        String result = "";
        List<String[]> content = new ArrayList<>();

        try {
            pagination.gotoPage(page);
            for(Trader x : pagination.pageContent){
                var res1 = SharedStatics.publicTableHelper.toStrings(x);
                var res2 = SharedStatics.publicTableHelper.toStrings(x.registrar);
                var combinedArray = Arrays.stream(Stream.concat(Arrays.stream(res1), Arrays.stream(res2)).toArray(String[]::new)).collect(Collectors.toCollection(ArrayList::new));
                combinedArray.remove(this.REG_BY);
                content.add(combinedArray.toArray(new String[0]));
                // todo Ужасная временная сложность... terrible time complexity...
            }
            result = SharedStatics.publicTableHelper
                    .giveHtmlTable(
                            this.tableHead,
                            "text-left inline-block? border-l border-r border-slate-500 px-1 font-semibold text-lg",
                            null,
                            content,
                            cellClasses,
                            null,
                            (Map.of("class", tableClasses)),
                            false,
                            this.wrapper
                    );
        }catch (Exception e){
            e.printStackTrace();
            result = "met error";
        }

        return result;
    }

    //
    @Override
    public DAO<Trader> lendAgent() {
        return this.trader;
    }

    public Page<Trader> getPagination() {
        return this.pagination;
    }
}
