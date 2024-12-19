package su.kami.demo.utils;

import com.google.gson.Gson;
import org.springframework.http.ResponseEntity;

public class ResponseHelper {
    public static ResponseEntity<String> Return(){
        return ResponseEntity.status(418).body("I'm a teapot!");
    }

    public static ResponseEntity<String> Return(int code){
        return ResponseEntity.status(code).body("EMPTY");
    }

    public static ResponseEntity<String> Return(int code, String cause){
        return ResponseEntity.status(code).body(cause);
    }

    public static ResponseEntity<String> Return(int code, Object responseObject){
        return ResponseEntity.status(code).body((new Gson()).toJson(responseObject));
    }

}
