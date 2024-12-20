package su.kami.demo.Models;

import java.util.Date;

import su.kami.demo.Models.enums.EEmpType;
import su.kami.demo.utils.FormatHelper;

public class Employee implements  InternalModel{

    public int empId;
    public String name;
    public String contact;
    public Date dateJoin =  new Date(); // default now
    public EEmpType type;

    public Employee(int id){
        this.empId = id;
        name = "";
        contact = "";
        this.type = null;
    }

    public Employee(int empId, String name, String contact, Date dateJoin, EEmpType type) {
        this.empId = empId;
        this.name = name;
        this.contact = contact;
        this.dateJoin = dateJoin;
        this.type = type;
    }

    public Employee(String name, String contact, Date dateJoin, EEmpType type) {
        this.name = name;
        this.contact = contact;
        this.dateJoin = dateJoin;
        this.type = type;
    }

    public Employee(String name, String contact, Date dateJoin, int typeTiny) {
        this.name = name;
        this.contact = contact;
        this.dateJoin = dateJoin;
        this.type = EEmpType.enumerize(typeTiny);
    }

    public void typeSetterAsTiny(int tiny){
        this.type = EEmpType.enumerize(tiny);
    }

    public int typeGetterAsTiny(){
        return EEmpType.tinify(this.type);
    }


    public String[] toStrings(){
        String[] ox = new String[5];
        ox[0] = this.empId + "";
        ox[1] = this.name;
        ox[2] = this.contact;
        ox[3] = FormatHelper.Format(this.dateJoin);
        ox[4] = this.type.name();

        return ox;
    }
}

