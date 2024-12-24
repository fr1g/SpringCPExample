package su.kami.demo.Models;

import su.kami.demo.Models.enums.ETraderType;

public class Trader implements InternalModel{
    public int traderID;
    public String contact;
    public String name;
    public ETraderType type;
    public Employee registrar;
    public String note;

    public Trader(int traderID, String contact, String name, ETraderType type, Employee registrar, String note) {
        this.traderID = traderID;
        this.contact = contact;
        this.name = name;
        this.type = type;
        this.registrar = registrar;
        this.note = note;
    }

    public Trader(int traderID, String contact, String name, int type, Employee registrar){
        this.traderID = traderID;
        this.contact = contact;
        this.name = name;
        this.type = ETraderType.enumerize(type);
        this.registrar = registrar;
        this.note = "None";
    }

    public Trader(String contact, String name, int type, Employee registrar){
        this.traderID = -1;
        this.contact = contact;
        this.name = name;
        this.type = ETraderType.enumerize(type);
        this.registrar = registrar;
        this.note = "None";
    }

    public Trader(int id) {
        this.traderID = id;
        this.contact = null;
        this.name = null;
        this.type = null;
        this.registrar = null;
        this.note = "None";
    }

    @Override
    public String toString() {
        return "#" + this.traderID;
    }
}
