package su.kami.demo.utils;

import com.google.gson.JsonDeserializationContext;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonElement;
import com.google.gson.JsonParseException;
import su.kami.demo.DataAccess.Interfaces.DAO;
import su.kami.demo.Models.InternalModel;

import java.lang.reflect.Type;

import static su.kami.demo.utils.IsExtendedCheckHelper.isExtended;

public class GsonRelatedObjectHelper<T extends InternalModel> implements JsonDeserializer<T> {

    private DAO<T> accessAgent;

    public GsonRelatedObjectHelper(DAO<T> accessAgent) {
        super();
        this.accessAgent = accessAgent;
    }
// Gson is Son Of Nobody
    @Override
    public T deserialize(JsonElement jsonElement, Type type, JsonDeserializationContext jsonDeserializationContext) throws JsonParseException {
        try {
            if (isExtended(type, InternalModel.class)) {
                var hewlett = jsonElement.getAsInt();
                return accessAgent.get(hewlett);
            } else
                return jsonDeserializationContext.deserialize(jsonElement, type);


        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
