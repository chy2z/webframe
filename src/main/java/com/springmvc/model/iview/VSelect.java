package com.springmvc.model.iview;


import lombok.*;

/** 
* @Title: VSelect
* @Description: iview select json数据
* @author chy
* @date 2017/10/30 9:49 
*/
@Data
@ToString
@NoArgsConstructor
public class VSelect {

    @Getter
    @Setter
    String label;

    @Getter
    @Setter
    String value;

    @Getter
    @Setter
    int id;
}
