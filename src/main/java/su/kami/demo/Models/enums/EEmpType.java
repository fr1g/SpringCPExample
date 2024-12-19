package su.kami.demo.Models.enums;
public enum EEmpType implements EnumTemplate {
    // using ordinal() to pick resolving
    UNKNOWN, ADMIN, WORKER, DRIVER, SUPERVISOR, MANAGER, OTHERS, WHAT, CLEANER, ELSEWHAT, IDONTKNOW;

    public static int tinify(EEmpType x){
        return x.ordinal();
    }

    public static EEmpType enumerize(int tiny){
        return EEmpType.values()[tiny];
    }
}