package su.kami.demo.Models;

import java.security.cert.Certificate;

public class ResponseObject <T>{
    public String type;
    public boolean certificated;
    public String token;
    public T content;
}
