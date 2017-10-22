package com.springmvc.service;

import com.springmvc.mapper.CorporationMapper;
import com.springmvc.model.PageHelper;
import com.springmvc.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * Created by chy on 2017/10/22.
 */
@Service
public class CorporationService {

    @Autowired
    CorporationMapper cmap;

    public PageHelper getPagination(int pageNo,int pageSize,String where ,String orderBy){

        PageHelper ph=new PageHelper();

        ph.setPageNo(pageNo);

        ph.setPageSize(pageSize);

        ph.setWhere(StringUtil.NullOrString(where));

        ph.setOrderBy(StringUtil.NullOrString(orderBy));

        ph.setTotalCount(cmap.getCount(ph.getWhere(),ph.getOrderBy()));

        ph.setResult(cmap.selectPagination(ph.getWhere(),ph.getOrderBy(),ph.getStart(),ph.getPageSize()));

        return ph;
    }

}
