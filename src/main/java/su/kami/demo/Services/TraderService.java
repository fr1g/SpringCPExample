package su.kami.demo.Services;

import su.kami.demo.DataAccess.DAO.RelatedTrader;
import su.kami.demo.DataAccess.Interfaces.DAO;
import su.kami.demo.Models.Trader;
import su.kami.demo.utils.QueriedPageTools.Page;

public class TraderService implements Service{
    private RelatedTrader trader;
    private Page<Trader> pagination;

    public TraderService(RelatedTrader relatedTrader) {
        this.trader = relatedTrader;
        this.pagination = new Page<Trader>(relatedTrader); // todo which one it will use
    }

    @Override
    public DAO<Trader> lendAgent() {
        return this.trader;
    }
}
