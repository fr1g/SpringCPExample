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

    public List<Employee> getEmployee(){
        return this.emp.get();
    }

    public Employee getEmployee(int id){
        return this.emp.get(id);
    }

    public void addEmployee(Employee e){
        this.emp.add(e);
    }

    public void updateEmployee(Employee e){
        this.emp.update(e);
    }

    public void deleteEmployee(Employee e){
        this.emp.delete(e);
    }

    //

    public Trader getTrader(int id){
        return this.trader.get(id);
    }

    public List<Trader> getTrader(){
        return this.trader.get();
    }

    public void addTrader(Trader t){
        this.trader.add(t);
    }

    public void updateTrader(Trader t){
        this.trader.update(t);
    }

    public void deleteTrader(Trader t){
        this.trader.delete(t);
    }

    @Override
    public DAO<Employee> lendAgent() {
        return this.emp;
    }
}
