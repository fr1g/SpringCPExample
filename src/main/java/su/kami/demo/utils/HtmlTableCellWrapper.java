package su.kami.demo.utils;

public class HtmlTableCellWrapper {
    public int CellPosition;
    public String Wrapper;
    public String Replacer = "@-#CONTENT#-@";

    public boolean forHeaderAlso = false;

    public boolean IsAbleToWrap(int current){
        return (current == this.CellPosition) || current % this.CellPosition == 0 && current != 0;
    }

    public String Wrap(String content){
//        System.out.println(this);
        return this.Wrapper.replaceAll(this.Replacer, content);
    }

    public HtmlTableCellWrapper(int cellPosition, String wrapper){
        this.CellPosition = cellPosition;
        this.Wrapper = wrapper;
    }

    public HtmlTableCellWrapper(int CellPosition, String Wrapper, String Replacer){
        this.CellPosition = CellPosition;
        this.Wrapper = Wrapper;
        this.Replacer = Replacer;
    }

    @Override
    public String toString() {
        return "HtmlTableCellWrapper [CellPosition=" + CellPosition + ", Wrapper=" + Wrapper + ", Replacer=" + Replacer + "]";
    }
}
