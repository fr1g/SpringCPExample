package su.kami.demo.Services;

import su.kami.demo.DataAccess.Interfaces.DAO;
import su.kami.demo.Models.Employee;
import su.kami.demo.Models.Trader;

import java.util.List;

public class BaseService implements Service<Employee> {
    public DAO<Employee> emp;
    public DAO<Trader> trader;

    public BaseService(DAO<?> emp, DAO<?> related){ // ?
        this.emp = (DAO<Employee>) emp;
        this.trader = (DAO<Trader>) related;
    }


    //
    @Override
    public DAO<Employee> lendAgent() {
        return this.emp;
    }
}
