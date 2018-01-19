package com.springmvc.model;

import lombok.*;

import java.util.ArrayList;
import java.util.List;

/**
* @Title: PageHelper
* @Description: 分页类
* @author chy
* @date 2017/10/22 17:08
*/

@Data
@ToString
@NoArgsConstructor
public class PageHelper<T> {

    /** 当前页 */
    @Getter
    @Setter
    private int pageNo = 1;

    /** 每页显示条数 */
    @Setter
    private int pageSize = -1;

    /**
     * 分页记录起始位置
     */
    @Setter(AccessLevel.PROTECTED)
    private int start=0;

    /** 总记录数 */
    @Getter
    @Setter
    private long totalCount = -1;

    /** 总页数 */
    @Setter
    private long totalPages = -1;

    /**
     * 排序条件
     */
    @Getter
    @Setter
    private String orderBy=null;

    /**
     * 排序条件
     */
    @Getter
    @Setter
    private String orderByInner=null;

    /**
     * 查询条件
     */
    @Getter
    @Setter
    private String where=null;

    /**
     * 内部查询条件
     */
    @Getter
    @Setter
    private String whereInner=null;

    /** 返回结果 */
    @Getter
    @Setter
    private List<T> result = new ArrayList<T>();

    /**
     * 获取每页记录数量
     * @return
     */
    public int getPageSize() {
        if (pageSize < 1) {
            this.pageSize = 10;
        }
        return pageSize;
    }

    /**
     * 获取起始记录位置
     * @return
     */
    public int getStart() {
        return (pageNo - 1) * getPageSize();
    }

    /**
     * 获取总页数
     * @return
     */
    public long getTotalPages() {
        if (totalCount < 0) {
            return -1;
        }

        long count = totalCount / pageSize;
        if (totalCount % pageSize > 0) {
            count++;
        }
        totalPages = count;
        return totalPages;
    }

}
