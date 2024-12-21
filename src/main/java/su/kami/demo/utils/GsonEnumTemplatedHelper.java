package su.kami.demo.utils;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import su.kami.demo.Models.enums.EnumTemplate;

import java.lang.reflect.Type;

public class GsonEnumTemplatedHelper<T extends EnumTemplate> implements JsonDeserializer<T> {

    @Override
    public T deserialize(JsonElement jsonElement, Type type, JsonDeserializationContext jsonDeserializationContext) throws JsonParseException {

        Class<?> clazz = (Class<?>) type;
        T result = null;
        try{

            result = (T) clazz.getMethod("enumerize", Integer.TYPE).invoke(null, jsonElement.getAsInt());
            // # pragma disable typeMatchCheck -fvck
        }catch (Exception ex){
            ex.printStackTrace();
        }

        return result;
    }
}
