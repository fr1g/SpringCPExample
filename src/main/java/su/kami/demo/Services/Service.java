package su.kami.demo.Services;

import su.kami.demo.DataAccess.Interfaces.DAO;

public interface Service<T> {
    DAO<T> lendAgent();
}
