package su.kami.demo.utils.QueriedPageTools;

import com.google.gson.Gson;
import su.kami.demo.DataAccess.Interfaces.DAO;

import java.util.ArrayList;
import java.util.List;


public class Page<T> {
    protected DAO<T> accessAgent;

    public List<T> pageContent;
    public int currentPage;

    private int pageSize;
    private boolean previous;
    private boolean next;

    private int tableTotalPages;

    public int getPageSize() throws PaginationException {
        this.stateHasChanged();
        return pageSize;
    }

    public void setPageSize(int pageSize) throws PaginationException {
        this.stateHasChanged();
        this.pageSize = pageSize;
    }

    public boolean hasPrevious() throws PaginationException {
        this.stateHasChanged();
        return previous;
    }

    public boolean hasNext() throws PaginationException {
        this.stateHasChanged();
        return next;
    }

    public int getTableTotalPages() throws PaginationException {
        this.stateHasChanged();
        return tableTotalPages;
    }

    public void setTableTotalPages(int tableTotalPages) throws PaginationException {
        this.stateHasChanged();
        this.tableTotalPages = tableTotalPages;
    }

    public int getCurrentPage() throws PaginationException {
        this.stateHasChanged();
        return currentPage;
    }

    public void setCurrentPage(int currentPage) throws PaginationException {
        this.stateHasChanged();
        this.currentPage = currentPage;
    }

    public Page(DAO<T> accessAgent) {
        this.accessAgent = accessAgent;
        this.pageSize = 8;
        try {
            stateHasChanged();
        } catch (PaginationException e) {
            throw new RuntimeException(e);
        }
    }

    public Page(DAO<T> accessAgent, int pageSize) {
        this.accessAgent = accessAgent;
        this.pageSize = pageSize;
        try {
            stateHasChanged();
        } catch (PaginationException e) {
            throw new RuntimeException(e);
        }
    }

    public void gotoNextPage() throws PaginationException{
        this.gotoPage(this.currentPage + 1);
    }

    public void gotoPrevPage() throws PaginationException{
        this.gotoPage(this.currentPage - 1);
    }

    public void gotoPage(int page) throws PaginationException{
        if(accessAgent == null) throw new PaginationException("Unset Data Access: accessAgent is null");
        stateHasChanged();
        if(page > this.tableTotalPages) throw new PaginationException("Invalid page number: overflow");
//        if(page == this.currentPage && this.pageContent != null) return; // if page not changing, do nothing.
//        else
        String limit = "";
        if(page == this.currentPage) limit = (Page.getLimit(this.currentPage, this.pageSize));
        else limit = Page.getLimit(page > this.currentPage, this);
        this.pageContent = accessAgent.get(limit);
        this.currentPage = page;
//        System.out.println("GetPage " + this.currentPage + " GetBy: " + limit);
    }

    public void updateTotalPages() throws PaginationException{
        if(accessAgent == null) throw new PaginationException("Unset Data Access: accessAgent is null");
        this.tableTotalPages = (int)Math.ceil((double)accessAgent.count("") / (double)this.pageSize);
    }

    public void stateHasChanged() throws PaginationException{
        updateTotalPages();
        // update totalPages, update have or not next page, update currentPage (if larger than total, set equal to total)
        if(this.tableTotalPages <= this.currentPage) {
            this.next = false;
            this.currentPage = this.tableTotalPages;
        } else if(this.tableTotalPages == 0) {
            this.next = false;
            this.currentPage = 0;
            this.previous = false;
            this.pageContent = new ArrayList<T>(){};
        }
        updateNeighbours();
//        System.out.println((new Gson()).toJson(this));
//        System.out.println("Page changed to: " + this.currentPage);
    }

    public void updateNeighbours(){
        if(1 < this.currentPage && this.currentPage < this.tableTotalPages) {
            this.next = true;
            this.previous = true;
        }else if(this.currentPage <= 1){
            this.next = true;
            this.previous = false;
        }else if (this.currentPage == this.tableTotalPages) {
            this.next = false;
            this.previous = true;
        }
    }

    public static int at(int currentPage, int pageSize){
        return (currentPage - 1) * pageSize;
    }

    public static String getLimit(boolean isGoingNext, Page<?> pageInstance) throws PaginationException{
//        System.out.println("getting limit while currentPage: " + pageInstance.getCurrentPage() + ", isGoingNext: " + isGoingNext + ", maxPages: " + pageInstance.getTableTotalPages());
        if( (isGoingNext && !pageInstance.next || !isGoingNext && !pageInstance.previous))
            throw new PaginationException("There are no more pages in the direction required: " + (isGoingNext ? "NextPage" : "PreviousPage"));

        return (" limit " + pageInstance.pageSize + " offset " + ( isGoingNext ?
                at(pageInstance.currentPage + 1, pageInstance.pageSize) :
                at(pageInstance.currentPage - 1, pageInstance.pageSize) )
                + " ");
    }

    public static String getLimit(int jumpTo, int size){
        return (" limit " + size + " offset " + ( at(jumpTo, size) ) + " ");
    }
}
