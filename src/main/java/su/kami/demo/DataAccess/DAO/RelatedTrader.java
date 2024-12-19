package su.kami.demo.DataAccess.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import su.kami.demo.DataAccess.Interfaces.DAO;
import su.kami.demo.Models.enums.ETraderType;
import su.kami.demo.Models.Trader;
import su.kami.demo.utils.*;

public class RelatedTrader implements DAO<Trader> {
    private Connection connection;

    public RelatedTrader(Connection connection){
        this.connection = connection;
    }

    public RelatedTrader(MyConn connection) {
        this.connection = connection.create();
    }


    @Override
    public Trader get(int id) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM traders WHERE trader_id = ?");
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()) return resultSet.getObject(1, Trader.class);
            //?
        }catch (Exception ex){
            ex.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Trader> get() {
        return get("");
    }

    @Override
    public List<Trader> get(String limit) {
        try{
            if(limit == null) limit = "";
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM traders " + limit);
            ResultSet resultSet = preparedStatement.executeQuery();
            List<Trader> traders = new ArrayList<>();
            while(resultSet.next()){
                traders.add(resultSet.getObject(1, Trader.class));
            }
            return traders;
        }catch (Exception ex){
            ex.printStackTrace();
        }
        return new ArrayList<>(){};
    }

    @Override
    public void update(Trader trader) {
        try {
            PreparedStatement preparedStatement = connection.prepareStatement("UPDATE traders SET contact = ?, name = ?, type = ?, reg_by = ? WHERE trader_id = ?");
            preparedStatement.setString(1, trader.contact);
            preparedStatement.setString(2, trader.name);
            preparedStatement.setInt(3, ETraderType.tinify(trader.type));
            preparedStatement.setInt(4, trader.registrar.empId);
            preparedStatement.setInt(5, trader.traderID);
            preparedStatement.executeUpdate();

        }catch (Exception ex){
            ex.printStackTrace();
        }
    }

    @Override
    public void delete(Trader trader) {
        try {
            PreparedStatement prep = connection.prepareStatement("DELETE FROM traders WHERE trader_id = ?");
            prep.setInt(1, trader.traderID);
            prep.executeUpdate();
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }

    @Override
    public void add(Trader trader) {
        try{
            PreparedStatement preparedStatement = connection.prepareStatement("insert into traders(contact, name, type, reg_by, note) value(?, ?, ?, ?, ?)");
            preparedStatement.setString(1, trader.contact);
            preparedStatement.setString(2, trader.name);
            preparedStatement.setInt(3, ETraderType.tinify(trader.type));
            preparedStatement.setInt(4, trader.registrar.empId);
            preparedStatement.setString(5, trader.note);
            preparedStatement.executeUpdate();
        }catch (Exception ex){
            ex.printStackTrace();
        }
    }

    @Override
    public int count(String requirement) {
        if (requirement == null || requirement.isEmpty()) requirement = "";
        else requirement = " where " + requirement;
        try {
            PreparedStatement pre = this.connection.prepareStatement("select count(*) from traders " + requirement);
            ResultSet rs = pre.executeQuery();
            if(rs.next()) return rs.getInt(1);
            else return -1;
        }catch (Exception ex){
            ex.printStackTrace();
        }
        return -1;
    }
}
