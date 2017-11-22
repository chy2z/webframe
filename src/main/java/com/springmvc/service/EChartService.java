package com.springmvc.service;

import com.springmvc.mapper.EChartMapper;
import com.springmvc.model.echart.Legend;
import com.springmvc.model.echart.Option;
import com.springmvc.model.echart.axis.Axis;
import com.springmvc.model.echart.axis.CategoryAxis;
import com.springmvc.model.echart.code.Position;
import com.springmvc.model.echart.series.Bar;
import com.springmvc.model.echart.series.Series;
import com.springmvc.model.echart.style.ItemStyle;
import com.springmvc.model.echart.style.itemstyle.Normal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* @Title: EChartService
* @Description: 图表业务层
* @author chy
* @date 2017/11/20 14:26
*/
@Service
public class EChartService {

   @Autowired
    EChartMapper eChartMapper;

    /**
     * 查询某个用户最近几年的登录统计
     *
     * bar水平柱状图
     *
     * @param usersId
     * @param num
     */
   public String getLoginLogLastNYearsH(int usersId,int num){

       List<Map<String,Object>> list= eChartMapper.getLoginLogLastNYears(usersId,num);

       List<String> legend=new ArrayList<>();

       List<String> yAxis=new ArrayList<>();

       Map<String,Integer> data = new HashMap<>();

       String mLegend=null;

       String mYAxis=null;

       //遍历数据行
       for (Map<String,Object> map :list) {
           for (Map.Entry<String, Object> entry : map.entrySet()) {
               if(entry.getKey().equals("legend")) {
                   mLegend=entry.getValue().toString();
                   if(!legend.contains(mLegend)) {
                       legend.add(mLegend);
                   }
               }
               else if(entry.getKey().equals("yAxis")) {
                   mYAxis=entry.getValue().toString();
                   if(!yAxis.contains(mYAxis)) {
                       yAxis.add(mYAxis);
                   }
               }
           }

           data.put(mLegend+mYAxis,Integer.parseInt(map.get("data").toString()));
       }

       List<Series> seriesList=new ArrayList<>();

       //填充数据，补全0
       for(String l :legend){
           mLegend=l;
           Bar bar=new Bar();
           bar.setName(mLegend);
           bar.setData(new ArrayList<Integer>());

           ItemStyle itemStyle= new ItemStyle();
           Normal normal=new Normal();
           normal.setShow(true);
           normal.setPosition(Position.right);
           itemStyle.setNormal(normal);
           bar.setLabel(itemStyle);


           for(String y :yAxis){
               mYAxis=y;
               if(null==data.get(mLegend+mYAxis)){
                   data.put(mLegend+mYAxis,0);
               }
               bar.getData().add(Integer.parseInt(data.get(mLegend+mYAxis).toString()));
           }
           seriesList.add(bar);
       }

       //标签信息
       Legend legendOption=new Legend();
       legendOption.setData(legend);
       legendOption.setTop(2);

       //轴
       List<Axis> yAxisOption=new ArrayList<>();
       CategoryAxis categoryAxis=new CategoryAxis();
       categoryAxis.setData(yAxis);
       yAxisOption.add(categoryAxis);

       //生成配置项
       Option option=new Option();
       option.setLegend(legendOption);
       option.setYAxis(yAxisOption);
       option.setSeries(seriesList);

       return option.toJson();
   }

    /**
     * 查询某个用户最近几年的登录统计
     *
     * bar垂直柱状图
     *
     * @param usersId
     * @param num
     */
   public String getLoginLogLastNYearsV(int usersId,int num){

        List<Map<String,Object>> list= eChartMapper.getLoginLogLastNYears(usersId,num);

        List<String> legend=new ArrayList<>();

        List<String> xAxis=new ArrayList<>();

        Map<String,Integer> data = new HashMap<>();

        String mLegend=null;

        String mYAxis=null;

       //遍历数据行
       for (Map<String,Object> map :list) {
           for (Map.Entry<String, Object> entry : map.entrySet()) {
               if(entry.getKey().equals("legend")) {
                   mLegend=entry.getValue().toString();
                   if(!legend.contains(mLegend)) {
                       legend.add(mLegend);
                   }
               }
               else if(entry.getKey().equals("yAxis")) {
                   mYAxis=entry.getValue().toString();
                   if(!xAxis.contains(mYAxis)) {
                       xAxis.add(mYAxis);
                   }
               }
           }

           data.put(mLegend+mYAxis,Integer.parseInt(map.get("data").toString()));
       }

        List<Series> seriesList=new ArrayList<>();

        //填充数据，补全0
        for(String l :legend){
            mLegend=l;
            Bar bar=new Bar();
            bar.setName(mLegend);
            bar.setData(new ArrayList<Integer>());

            ItemStyle itemStyle= new ItemStyle();
            Normal normal=new Normal();
            normal.setShow(true);
            normal.setPosition(Position.top);
            itemStyle.setNormal(normal);
            bar.setLabel(itemStyle);


            for(String y :xAxis){
                mYAxis=y;
                if(null==data.get(mLegend+mYAxis)){
                    data.put(mLegend+mYAxis,0);
                }
                bar.getData().add(Integer.parseInt(data.get(mLegend+mYAxis).toString()));
            }
            seriesList.add(bar);
        }

        Legend legendOption=new Legend();
        legendOption.setData(legend);
        legendOption.setTop(2);

        List<Axis> xAxisOption=new ArrayList<>();
        CategoryAxis categoryAxis=new CategoryAxis();
        categoryAxis.setData(xAxis);
        xAxisOption.add(categoryAxis);

        Option option=new Option();
        option.setLegend(legendOption);
        option.setXAxis(xAxisOption);
        option.setSeries(seriesList);

        return option.toJson();
    }


    /**
     * 查询某个用户最近几年的登录统计
     *
     * bar堆叠图
     *
     * @param usersId
     * @param num
     */
    public String getLoginLogLastNYearsStack(int usersId,int num){

        List<Map<String,Object>> list= eChartMapper.getLoginLogLastNYears(usersId,num);

        List<String> legend=new ArrayList<>();

        List<String> yAxis=new ArrayList<>();

        Map<String,Integer> data = new HashMap<>();

        String mLegend=null;

        String mYAxis=null;

        //遍历数据行
        for (Map<String,Object> map :list) {
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                if(entry.getKey().equals("legend")) {
                    mLegend=entry.getValue().toString();
                    if(!legend.contains(mLegend)) {
                        legend.add(mLegend);
                    }
                }
                else if(entry.getKey().equals("yAxis")) {
                    mYAxis=entry.getValue().toString();
                    if(!yAxis.contains(mYAxis)) {
                        yAxis.add(mYAxis);
                    }
                }
            }

            data.put(mLegend+mYAxis,Integer.parseInt(map.get("data").toString()));
        }

        List<Series> seriesList=new ArrayList<>();

        //填充数据，补全0
        for(String l :legend){
            mLegend=l;
            Bar bar=new Bar();
            bar.setName(mLegend);
            bar.setStack("总量");
            bar.setData(new ArrayList<Integer>());
            ItemStyle itemStyle= new ItemStyle();
            Normal normal=new Normal();
            normal.setShow(true);
            normal.setPosition(Position.insideRight);
            itemStyle.setNormal(normal);
            bar.setLabel(itemStyle);
            for(String y :yAxis){
                mYAxis=y;
                if(null==data.get(mLegend+mYAxis)){
                    data.put(mLegend+mYAxis,0);
                }
                bar.getData().add(Integer.parseInt(data.get(mLegend+mYAxis).toString()));
            }
            seriesList.add(bar);
        }

        Legend legendOption=new Legend();
        legendOption.setData(legend);
        legendOption.setTop(2);

        List<Axis> yAxisOption=new ArrayList<>();
        CategoryAxis categoryAxis=new CategoryAxis();
        categoryAxis.setData(yAxis);
        yAxisOption.add(categoryAxis);

        Option option=new Option();
        option.setLegend(legendOption);
        option.setYAxis(yAxisOption);
        option.setSeries(seriesList);

        return option.toJson();
    }


    /**
     * 查询某个用户最近几年的登录统计
     *
     * line 堆叠图
     *
     * @param usersId
     * @param num
     */
    public String getLoginLogLastNYearsLineStack(int usersId,int num){

        List<Map<String,Object>> list= eChartMapper.getLoginLogLastNYears(usersId,num);

        List<String> legend=new ArrayList<>();

        List<String> xAxis=new ArrayList<>();

        Map<String,Integer> data = new HashMap<>();

        String mLegend=null;

        String mYAxis=null;

        //遍历数据行
        for (Map<String,Object> map :list) {
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                if(entry.getKey().equals("legend")) {
                    mLegend=entry.getValue().toString();
                    if(!legend.contains(mLegend)) {
                        legend.add(mLegend);
                    }
                }
                else if(entry.getKey().equals("yAxis")) {
                    mYAxis=entry.getValue().toString();
                    if(!xAxis.contains(mYAxis)) {
                        xAxis.add(mYAxis);
                    }
                }
            }

            data.put(mLegend+mYAxis,Integer.parseInt(map.get("data").toString()));
        }

        List<Series> seriesList=new ArrayList<>();

        //填充数据，补全0
        for(String l :legend){
            mLegend=l;
            Bar bar=new Bar();
            bar.setName(mLegend);
            bar.setData(new ArrayList<Integer>());

            ItemStyle itemStyle= new ItemStyle();
            Normal normal=new Normal();
            normal.setShow(true);
            normal.setPosition(Position.top);
            itemStyle.setNormal(normal);
            bar.setLabel(itemStyle);


            for(String y :xAxis){
                mYAxis=y;
                if(null==data.get(mLegend+mYAxis)){
                    data.put(mLegend+mYAxis,0);
                }
                bar.getData().add(Integer.parseInt(data.get(mLegend+mYAxis).toString()));
            }
            seriesList.add(bar);
        }

        Legend legendOption=new Legend();
        legendOption.setData(legend);
        legendOption.setTop(2);

        List<Axis> xAxisOption=new ArrayList<>();
        CategoryAxis categoryAxis=new CategoryAxis();
        categoryAxis.setData(xAxis);
        xAxisOption.add(categoryAxis);

        Option option=new Option();
        option.setLegend(legendOption);
        option.setXAxis(xAxisOption);
        option.setSeries(seriesList);

        return option.toJson();

    }
}