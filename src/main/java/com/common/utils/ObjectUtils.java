package com.common.utils;

import com.common.exception.PlatformException;

import java.math.BigInteger;
import java.text.NumberFormat;
import java.text.ParseException;

/**
 * @author barry
 */
public class ObjectUtils {

    public static Number getNumber(Object obj) {

        if (obj == null) {
            return 0;
        }

        Number result ;
        if (obj instanceof  Number) {
            result = (Number) obj;
        } else {
            result = new BigInteger((String) obj);
        }
        return result;
    }

    public static int getInteger(Object obj) {

        if (obj == null) {
            return 0;
        }

        int result ;
        if (obj instanceof Number) {
            result = ((Number) obj).intValue();
        } else {
            try {
                result = NumberFormat.getInstance().parse((String) obj).intValue();
            } catch (ParseException e) {
                throw new PlatformException(e);
            }
        }
        return result;
    }

    public static long getLong(Object obj) {

        if(obj == null) {
            return 0L;
        }

        long result ;
        if(obj instanceof  Number) {
            result = ((Number) obj).longValue();
        } else {
            result = Long.parseLong((String) obj);
        }
        return result;
    }

    public static String getString(Object obj) {
        String result ;
        if(obj instanceof  Number) {
            result = ((Number) obj).toString();
        } else {
            result = (String) obj;
        }
        return result;
    }
}
