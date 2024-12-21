package su.kami.demo.utils;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;

public class IsExtendedCheckHelper {

        public static boolean isExtended(Object obj, Class<?> targetInterface) {

            Class<?> clazz = obj.getClass();

            for (Field field : clazz.getDeclaredFields()) {
                if (Modifier.isStatic(field.getModifiers()) || Modifier.isFinal(field.getModifiers()) || Modifier.isTransient(field.getModifiers())) {
                    continue;
                }

                field.setAccessible(true);
                return targetInterface.isAssignableFrom(field.getType());

            }

            return false;
        }

}
