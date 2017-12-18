package com.springmvc.util;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
/**
* @Title: DateJsonDeserializerUtil
* @Description: jackson 反序列化时间
* @author chy
* @date 2017/12/18 16:58
*/
public class DateJsonDeserializerUtil extends JsonDeserializer<Date> {

    /**
     * @see com.fasterxml.jackson.databind.JsonDeserializer#deserialize(com.fasterxml.jackson.core.JsonParser,
     *      com.fasterxml.jackson.databind.DeserializationContext)
     */
    @Override
    public Date deserialize(JsonParser parser, DeserializationContext context)
            throws IOException, JsonProcessingException {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            return sdf.parse(parser.getValueAsString());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}