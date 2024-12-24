package su.kami.demo.DataAccess.Interfaces;

import java.sql.Connection;
import java.util.List;

public interface DAO<T>{
    Connection conn = null; // !
    
    T get(int id);
    List<T> get();
    List<T> get(String limit);
    void update(T t);
    void delete(T t) throws Exception;
    void add(T t) throws Exception;

    int count(String requirement);
}
