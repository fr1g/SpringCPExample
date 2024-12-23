package su.kami.demo.Services;

import su.kami.demo.DataAccess.DAO.RelatedTrader;
import su.kami.demo.DataAccess.Interfaces.DAO;
import su.kami.demo.Models.Trader;
import su.kami.demo.utils.QueriedPageTools.Page;

public class TraderService implements Service{
    private RelatedTrader relatedTrader;
    private Page<Trader> pagination;

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

    @Override
    public DAO<Trader> lendAgent() {
        return this.relatedTrader;
    }
}
