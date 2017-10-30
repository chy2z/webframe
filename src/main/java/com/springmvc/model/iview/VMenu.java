package com.springmvc.model.iview;

import lombok.*;

import java.util.List;

/**
* @Title: menu
* @Description: iview menu json数据
* @author chy
* @date 2017/10/20 14:51 
*/
@Data
@ToString
@NoArgsConstructor
public class VMenu {

    @Getter
    @Setter
    String name;

    @Getter
    @Setter
    String icon;

    @Getter
    @Setter
    String title;

    @Getter
    @Setter
    Boolean leaf;

    @Getter
    @Setter
    String url;

    @Getter
    @Setter
    List<VMenu> childs;

}
