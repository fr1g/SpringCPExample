package su.kami.demo.Models.enums;

public enum ETraderType implements EnumTemplate {
    UNKNOWN, Normal, Prime;

    public static int tinify(ETraderType x){
        return x.ordinal();
    }

    public static ETraderType enumerize(int tiny){
        return ETraderType.values()[tiny];
    }
}