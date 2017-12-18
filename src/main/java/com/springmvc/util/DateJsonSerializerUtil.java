package com.springmvc.util;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializerProvider;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
* @Title: DateJsonSerializerUtil
* @Description: jackson 序列化时间
* @author chy
* @date 2017/12/18 16:56
*/
public class DateJsonSerializerUtil extends JsonSerializer<Date> {

    /**
     * @see com.fasterxml.jackson.databind.JsonSerializer#serialize(java.lang.Object,
     * com.fasterxml.jackson.core.JsonGenerator,
     * com.fasterxml.jackson.databind.SerializerProvider)
     */
    @Override
    public void serialize(Date date, JsonGenerator generator, SerializerProvider provider)
            throws IOException, JsonProcessingException {
        ObjectMapper om = new ObjectMapper();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        om.writeValue(generator, sdf.format(date));
    }

}
