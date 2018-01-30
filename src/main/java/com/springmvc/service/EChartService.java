package com.springmvc.service;

import com.springmvc.base.BaseService;
import com.springmvc.mapper.EChartMapper;
import com.springmvc.model.echart.Label;
import com.springmvc.model.echart.LabelLine;
import com.springmvc.model.echart.Legend;
import com.springmvc.model.echart.Option;
import com.springmvc.model.echart.axis.Axis;
import com.springmvc.model.echart.axis.CategoryAxis;
import com.springmvc.model.echart.code.Orient;
import com.springmvc.model.echart.code.Position;
import com.springmvc.model.echart.data.*;
import com.springmvc.model.echart.series.*;
import com.springmvc.model.echart.series.gauge.Detail;
import com.springmvc.model.echart.style.AreaStyle;
import com.springmvc.model.echart.style.ItemStyle;
import com.springmvc.model.echart.style.itemstyle.Emphasis;
import com.springmvc.model.echart.style.itemstyle.Normal;
import com.springmvc.util.JsonUtil;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
* @Title: EChartService
* @Description: 图表业务层
* @author chy
* @date 2017/11/20 14:26
*/
@Service
public class EChartService extends BaseService {

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

       List<Map<String,Object>> list= eChartMapper.getLoginUserLastNYearsForYearCity(usersId,num);

       List<String> legend=new ArrayList<>();

       List<String> axis=new ArrayList<>();

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
               else if(entry.getKey().equals("axis")) {
                   mYAxis=entry.getValue().toString();
                   if(!axis.contains(mYAxis)) {
                       axis.add(mYAxis);
                   }
               }
           }

           data.put(mLegend+mYAxis,Integer.parseInt(map.get("data").toString()));
       }

       /**
        * 生成图表信息
        */

       List<Series> seriesOption=new ArrayList<>();

       List<LegendData> legendDataList=new ArrayList<>();

       List<AxisData> axisDataList=new ArrayList<>();

       //填充数据，补全0
       for(String l :legend){

           mLegend=l;

           legendDataList.add(new LegendData(mLegend));

           Bar bar=new Bar();
           bar.setName(mLegend);
           bar.setData(new ArrayList<Integer>());
           Label label= new Label();
           label.setNormal(new Normal());
           label.getNormal().setShow(true);
           label.getNormal().setPosition(Position.right);
           bar.setLabel(label);

           for(String y :axis){

               mYAxis=y;

               if(null==data.get(mLegend+mYAxis)){
                   data.put(mLegend+mYAxis,0);
               }

               BarData barData=new BarData(Integer.parseInt(data.get(mLegend+mYAxis).toString()));
               label=new Label();
               label.setNormal(new Normal());
               label.getNormal().setShow(Integer.parseInt(data.get(mLegend+mYAxis).toString())>0);
               label.getNormal().setPosition(Position.right);
               barData.setLabel(label);
               bar.getData().add(barData);
           }

           seriesOption.add(bar);
       }

       for(String y :axis) {
           axisDataList.add(new AxisData(y));
       }

       //标签信息
       Legend legendOption=new Legend();
       legendOption.setData(legendDataList);
       legendOption.setTop(2);

       //轴
       List<Axis> yAxisOption=new ArrayList<>();
       yAxisOption.add(new CategoryAxis(axisDataList));

       //生成配置项
       Option option=new Option();
       option.setLegend(legendOption);
       option.setYAxis(yAxisOption);
       option.setSeries(seriesOption);

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
   public String getLoginLogLastNYearsV(int usersId,int num) {

       List<Map<String, Object>> list = eChartMapper.getLoginUserLastNYearsForYearCity(usersId, num);

       List<String> legend = new ArrayList<>();

       List<String> axis = new ArrayList<>();

       Map<String, Integer> data = new HashMap<>();

       String mLegend = null;

       String mYAxis = null;

       //遍历数据行
       for (Map<String, Object> map : list) {
           for (Map.Entry<String, Object> entry : map.entrySet()) {
               if (entry.getKey().equals("legend")) {
                   mLegend = entry.getValue().toString();
                   if (!legend.contains(mLegend)) {
                       legend.add(mLegend);
                   }
               } else if (entry.getKey().equals("axis")) {
                   mYAxis = entry.getValue().toString();
                   if (!axis.contains(mYAxis)) {
                       axis.add(mYAxis);
                   }
               }
           }

           data.put(mLegend + mYAxis, Integer.parseInt(map.get("data").toString()));
       }

       /**
        * 生成图表信息
        */

       List<Series> seriesOption = new ArrayList<>();

       List<LegendData> legendDataList = new ArrayList<>();

       List<AxisData> axisDataList = new ArrayList<>();

       //填充数据，补全0
       for (String l : legend) {

           mLegend = l;

           legendDataList.add(new LegendData(mLegend));

           Bar bar = new Bar();
           bar.setName(mLegend);
           bar.setData(new ArrayList<Integer>());
           Label label= new Label();
           label.setNormal(new Normal());
           label.getNormal().setShow(true);
           label.getNormal().setPosition(Position.right);
           bar.setLabel(label);

           for (String y : axis) {

               mYAxis = y;

               if (null == data.get(mLegend + mYAxis)) {
                   data.put(mLegend + mYAxis, 0);
               }

               BarData barData = new BarData(Integer.parseInt(data.get(mLegend + mYAxis).toString()));
               label = new Label();
               label.setNormal(new Normal());
               label.getNormal().setShow(Integer.parseInt(data.get(mLegend + mYAxis).toString()) > 0);
               label.getNormal().setPosition(Position.right);
               barData.setLabel(label);
               bar.getData().add(barData);
           }

           seriesOption.add(bar);
       }

       for (String y : axis) {
           axisDataList.add(new AxisData(y));
       }


       Legend legendOption = new Legend();
       legendOption.setData(legendDataList);
       legendOption.setTop(2);

       List<Axis> xAxisOption = new ArrayList<>();
       xAxisOption.add(new CategoryAxis(axisDataList));

       Option option = new Option();
       option.setLegend(legendOption);
       option.setXAxis(xAxisOption);
       option.setSeries(seriesOption);

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

        List<Map<String,Object>> list= eChartMapper.getLoginUserLastNYearsForYearCity(usersId,num);

        List<String> legend=new ArrayList<>();

        List<String> axis=new ArrayList<>();

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
                else if(entry.getKey().equals("axis")) {
                    mYAxis=entry.getValue().toString();
                    if(!axis.contains(mYAxis)) {
                        axis.add(mYAxis);
                    }
                }
            }

            data.put(mLegend+mYAxis,Integer.parseInt(map.get("data").toString()));
        }

        /**
         * 生成图表信息
         */

        List<Series> seriesOption=new ArrayList<>();

        List<LegendData> legendDataList=new ArrayList<>();

        List<AxisData> axisDataList=new ArrayList<>();

        //填充数据，补全0
        for(String l :legend){

            mLegend=l;

            legendDataList.add(new LegendData(mLegend));

            Bar bar=new Bar();
            bar.setName(mLegend);
            bar.setData(new ArrayList<Integer>());
            Label label= new Label();
            label.setNormal(new Normal());
            label.getNormal().setShow(true);
            label.getNormal().setPosition(Position.right);
            bar.setLabel(label);

            for(String y :axis){

                mYAxis=y;

                if(null==data.get(mLegend+mYAxis)){
                    data.put(mLegend+mYAxis,0);
                }

                BarData barData=new BarData(Integer.parseInt(data.get(mLegend+mYAxis).toString()));
                label=new Label();
                label.setNormal(new Normal());
                label.getNormal().setShow(Integer.parseInt(data.get(mLegend+mYAxis).toString())>0);
                label.getNormal().setPosition(Position.right);
                barData.setLabel(label);
                bar.getData().add(barData);
            }

            seriesOption.add(bar);
        }

        for(String y :axis) {
            axisDataList.add(new AxisData(y));
        }


        //标签信息
        Legend legendOption=new Legend();
        legendOption.setData(legendDataList);
        legendOption.setTop(2);

        //轴
        List<Axis> yAxisOption=new ArrayList<>();
        yAxisOption.add(new CategoryAxis(axisDataList));

        Option option=new Option();
        option.setLegend(legendOption);
        option.setYAxis(yAxisOption);
        option.setSeries(seriesOption);

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

        List<Map<String,Object>> list= eChartMapper.getLoginUserLastNYearsForCityYear(usersId,num);

        List<String> legend=new ArrayList<>();

        List<String> axis=new ArrayList<>();

        Map<String,Integer> data = new HashMap<>();

        String mLegend=null;

        String mAxis=null;

        //遍历数据行
        for (Map<String,Object> map :list) {
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                if(entry.getKey().equals("legend")) {
                    mLegend=entry.getValue().toString();
                    if(!legend.contains(mLegend)) {
                        legend.add(mLegend);
                    }
                }
                else if(entry.getKey().equals("axis")) {
                    mAxis=entry.getValue().toString();
                    if(!axis.contains(mAxis)) {
                        axis.add(mAxis);
                    }
                }
            }

            data.put(mLegend+mAxis,Integer.parseInt(map.get("data").toString()));
        }

        /**
         * 生成图表
         */

        //系列列表
        List<Series> seriesOption=new ArrayList<>();
        //图例
        List<LegendData> legendDataList=new ArrayList<>();
        //轴数据
        List<AxisData> axisDataList=new ArrayList<>();

        //填充数据和补0
        for(String l :legend){

            mLegend=l;

            legendDataList.add(new LegendData(mLegend));

            Line line=new Line();
            line.setName(mLegend);
            line.setStack("总量");
            line.setData(new ArrayList<Integer>());

            //设置填充样式
            AreaStyle areaStyle =new AreaStyle();
            areaStyle.setNormal(new Normal());

            //显示数据标签
            Label label= new Label();
            label.setNormal(new Normal());
            label.getNormal().setShow(true);
            label.getNormal().setPosition(Position.top);

            line.setAreaStyle(areaStyle);
            line.setLabel(label);

            for(String y :axis){
                mAxis=y;

                if(null==data.get(mLegend+mAxis)){
                    data.put(mLegend+mAxis,0);
                }

                LineData lineData=new LineData(Integer.parseInt(data.get(mLegend+mAxis).toString()));
                label=new Label();
                label.setNormal(new Normal());
                label.getNormal().setShow(Integer.parseInt(data.get(mLegend+mAxis).toString())>0);
                label.getNormal().setPosition(Position.top);
                lineData.setLabel(label);
                line.getData().add(lineData);
            }

            seriesOption.add(line);
        }

        for(String y :axis) {
            axisDataList.add(new AxisData(y));
        }

        Legend legendOption=new Legend();
        legendOption.setData(legendDataList);
        legendOption.setTop(2);

        List<Axis> xAxisOption=new ArrayList<>();
        CategoryAxis categoryAxis=new CategoryAxis();
        categoryAxis.setData(axisDataList);
        categoryAxis.setBoundaryGap(true);
        xAxisOption.add(categoryAxis);

        Option option=new Option();
        option.setLegend(legendOption);
        option.setXAxis(xAxisOption);
        option.setSeries(seriesOption);

        return option.toJson();

    }

    /**
     * 查询某个用户最近几年的登录统计
     *
     * line
     *
     * @param usersId
     * @param num
     */
    public String getLoginLogLastNYearsLine(int usersId,int num){

        List<Map<String,Object>> list= eChartMapper.getLoginUserLastNYearsForCityYear(usersId,num);

        List<String> legend=new ArrayList<>();

        List<String> axis=new ArrayList<>();

        Map<String,Integer> data = new HashMap<>();

        String mLegend=null;

        String mAxis=null;

        //遍历数据行
        for (Map<String,Object> map :list) {
            for (Map.Entry<String, Object> entry : map.entrySet()) {
                if(entry.getKey().equals("legend")) {
                    mLegend=entry.getValue().toString();
                    if(!legend.contains(mLegend)) {
                        legend.add(mLegend);
                    }
                }
                else if(entry.getKey().equals("axis")) {
                    mAxis=entry.getValue().toString();
                    if(!axis.contains(mAxis)) {
                        axis.add(mAxis);
                    }
                }
            }

            data.put(mLegend+mAxis,Integer.parseInt(map.get("data").toString()));
        }

        /**
         * 生成图表
         */

        //系列列表
        List<Series> seriesOption=new ArrayList<>();
        //图例
        List<LegendData> legendDataList=new ArrayList<>();
        //轴数据
        List<AxisData> axisDataList=new ArrayList<>();

        //填充数据和补0
        for(String l :legend){

            mLegend=l;

            legendDataList.add(new LegendData(mLegend));

            Line line=new Line();
            line.setName(mLegend);
            line.setData(new ArrayList<Integer>());

            //显示数据标签
            Label label= new Label();
            label.setNormal(new Normal());
            label.getNormal().setShow(true);
            label.getNormal().setPosition(Position.top);

            line.setLabel(label);

            for(String y :axis){
                mAxis=y;

                if(null==data.get(mLegend+mAxis)){
                    data.put(mLegend+mAxis,0);
                }

                LineData lineData=new LineData(Integer.parseInt(data.get(mLegend+mAxis).toString()));
                label=new Label();
                label.setNormal(new Normal());
                label.getNormal().setShow(Integer.parseInt(data.get(mLegend+mAxis).toString())>0);
                label.getNormal().setPosition(Position.top);
                lineData.setLabel(label);
                line.getData().add(lineData);
            }

            seriesOption.add(line);
        }

        for(String y :axis) {
            axisDataList.add(new AxisData(y));
        }

        Legend legendOption=new Legend();
        legendOption.setData(legendDataList);
        legendOption.setTop(2);

        List<Axis> xAxisOption=new ArrayList<>();
        CategoryAxis categoryAxis=new CategoryAxis();
        categoryAxis.setData(axisDataList);
        categoryAxis.setBoundaryGap(true);
        xAxisOption.add(categoryAxis);

        Option option=new Option();
        option.setLegend(legendOption);
        option.setXAxis(xAxisOption);
        option.setSeries(seriesOption);

        return option.toJson();

    }

    /**
     * 查询某个用户最近几年的登录统计
     *
     * pie 饼图
     *
     * @param usersId
     * @param num
     */
    public String getLoginLogLastNYearsPie(int usersId,int num){

        List<Map<String,Object>> list= eChartMapper.getLoginUserLastNYearsForCity(usersId,num);

        List<String> legend=new ArrayList<>();

        Map<String,Integer> data = new HashMap<>();

        //遍历数据行
        for (Map<String,Object> map :list) {
            legend.add(map.get("legend").toString());
            data.put(map.get("legend").toString(),Integer.parseInt(map.get("data").toString()));
        }

        /**
         * 生成图表
         */

        //系列列表
        List<Series> seriesOption=new ArrayList<>();

        //图例数据
        List<LegendData> legendDataList=new ArrayList<>();

        //饼图
        Pie pie = new Pie();
        pie.setName("饼图");
        pie.setData(new ArrayList<Integer>());

        //饼图显示效果
        ItemStyle itemStyle = new ItemStyle();
        itemStyle.setEmphasis(new Emphasis());
        itemStyle.getEmphasis().setShadowBlur(10);
        itemStyle.getEmphasis().setShadowOffsetX(0);
        itemStyle.getEmphasis().setShadowColor("rgba(0, 0, 0, 0.5)");
        pie.setItemStyle(itemStyle);

        /*
        Label label =new Label();
        label.setNormal(new Normal());
        label.getNormal().setFormatter("{b}: {c} ({d}%)");
        pie.setLabel(label);
        */

        //控制数据是否显示
        for(String mLegend :legend) {

            legendDataList.add(new LegendData(mLegend));

            PieData pieData = new PieData(mLegend, Integer.parseInt(data.get(mLegend).toString()));

            Label label = new Label();
            label.setNormal(new Normal());
            label.getNormal().setShow(Integer.parseInt(data.get(mLegend).toString()) > 0);
            pieData.setLabel(label);

            LabelLine labelLine = new LabelLine();
            labelLine.setNormal(new Normal());
            labelLine.getNormal().setShow(Integer.parseInt(data.get(mLegend).toString()) > 0);
            pieData.setLabelLine(labelLine);

            pie.getData().add(pieData);
        }

        seriesOption.add(pie);

        //图例
        Legend legendOption=new Legend();
        legendOption.setData(legendDataList);
        legendOption.setShow(true);
        legendOption.setLeft(Position.left);
        legendOption.setOrient(Orient.vertical);

        //配置
        Option option=new Option();
        option.setLegend(legendOption);
        option.setSeries(seriesOption);

        return option.toJson();

    }

    /**
     * 查询某个用户最近几年的登录统计(模拟数据)
     * pie 仪表盘图
     * @param usersId
     * @param num
     * @return
     */
    public String getLoginLogLastNYearsGauge(int usersId,int num){

        //模拟数据
        HashMap<String, Integer> data = new HashMap<>();

        data.put("data",80);

        /**
         * 生成图表
         */

        //系列列表
        List<Series> seriesOption=new ArrayList<>();

        //仪表盘
        Gauge gauge = new Gauge();
        gauge.setName("业务指标");
        gauge.setRadius("90%");
        gauge.setData(new ArrayList<Integer>());

        //仪表盘数据
        GaugeData pieData = new GaugeData("完成率", Integer.parseInt(data.get("data").toString()));
        gauge.getData().add(pieData);
        gauge.setDetail(new Detail());
        gauge.getDetail().setShow(true);
        gauge.getDetail().setFormatter("{value}%");

        seriesOption.add(gauge);

        //配置
        Option option=new Option();
        option.setSeries(seriesOption);

        return option.toJson();
    }

    /**
     * 查询用户最近几年的登录统计(模拟数据)
     * @return
     */
    public String getLoginAllUserLastNYearsGeo() {
        List<Map<String, Object>> list = eChartMapper.getLoginAllUserForCity();
        return  JsonUtil.writeValueAsString(list);
    }
}