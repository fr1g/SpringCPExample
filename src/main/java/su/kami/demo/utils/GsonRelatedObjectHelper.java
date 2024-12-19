package su.kami.demo.utils;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import su.kami.demo.DataAccess.Interfaces.DAO;
import su.kami.demo.Models.InternalModel;

import java.lang.reflect.Type;
import java.util.Date;

public class GsonRelatedObjectHelper<T> implements JsonDeserializer<InternalModel> {

    private DAO<T> accessAgent;

    public GsonRelatedObjectHelper(DAO<T> accessAgent) {
        super();
        this.accessAgent = accessAgent;
    }

    @Override
    public InternalModel deserialize(JsonElement jsonElement, Type type, JsonDeserializationContext jsonDeserializationContext) throws JsonParseException {
        try {
            return (InternalModel) accessAgent.get(jsonElement.getAsInt());
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
