package com.springmvc.model.iview;

import lombok.*;

import java.util.List;

/**
* @Title: VTree
* @Description: iview tree json数据
* @author chy
* @date 2017/11/6 10:16
*/
@Data
@ToString
@NoArgsConstructor
public class VTree {

    @Getter
    @Setter
    private String nodeKey;

    @Getter
    @Setter
    private String title;

    @Getter
    @Setter
    private boolean expand;

    @Getter
    @Setter
    private boolean checked;

    @Getter
    @Setter
    private String path;

    @Getter
    @Setter
    private List<VTree> children;
}
