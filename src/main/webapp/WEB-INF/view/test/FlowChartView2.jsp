<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../../taglib/taglibs.jsp" %>
<%@ include file="../../../taglib/import_jsplumb.jsp" %>
<html>
<head>
    <title>测试页面</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="shortcut icon" type="image/x-icon" href="${ctx}/images/favicon.ico" media="screen"/>
</head>
<body>
<div id="canvas" class="canvas">
    <div class="explanation">
        <img src="${ctx}/js/jsplumb/images/menu/workflow.gif" align="absmiddle">
        <span class="big3">
                  流程名称:系统上线/升级申请流程 | 流程分类:技术部 |</span>
        <div class="big3">
            颜色标识说明：<span style="color: #FFBC18;">■</span>未接收 &nbsp;&nbsp;<span style="color: #50C625;">■</span>办理中 &nbsp;&nbsp;<span
                style="color: #7D26CD;">■</span>挂起中
            &nbsp;&nbsp;<span style="color: #F4A8BD;">■</span>办理完毕 &nbsp;&nbsp;<span style="color: #D7D7D7;">■</span>预设步骤
            &nbsp;&nbsp;
            <div id="prcsList"></div>
        </div>
</body>
<script>
    /**
     * 需要动态计算连接线
     * @returns {boolean}
     */
    // chrome fix.
    document.onselectstart = function () { return false; };
    $(document).ready(function(){
        $.getJSON("${ctx}/js/jsplumb/data2.json", function (json) {
            var fillColor = "gray";
            //jsPlumb.setRenderMode(jsPlumb.VML);
            jsPlumb.Defaults.Connector = [ "Straight", { curviness:50 } ];
            jsPlumb.Defaults.DragOptions = { cursor: "pointer", zIndex:2000 };
            jsPlumb.Defaults.PaintStyle = { strokeStyle:fillColor, lineWidth:2 };
            jsPlumb.Defaults.EndpointStyle = { radius:4, fillStyle:fillColor };

            var anchors = [[0.5, 0, 0, -1], [1, 0.5, 1, 0], [0.5, 1, 0, 1], [0, 0.5, -1, 0] ];
            var arrowCommon = { foldback:0.7, fillStyle:fillColor, width:14 };
            var aConnection = {
                dynamicAnchors:anchors,
                overlays:[
                    [ "Arrow", { location:0.7 }, arrowCommon ]
                ]
            };

            //create node chart and connectors
            var maxLeft = $(document.documentElement).width();
            var left = 20;
            var top = 90;
            var lastTop = 0;
            var lastPrcsId = 0;
            var direction = "r";
            if(json.total > 0)
            {
                //最大行
                var maxRow = 0;			//最大行数
                var lastRow = 0;		//上一行数
                var firstRowTop = 90	//每行初始高度
                var maxTop = 90			//最大高度
                $.each(json.list, function(i,row) {
                    // 添加一个属性，判断连线方向 DJ 14/8/28
                    row.direction = 'r';
                    if(row.prcs_id==lastPrcsId) {
                        top += 120;
                        maxTop = top;
                    } else if(lastPrcsId != 0) {
                        lastTop = top;
                        if(lastRow != maxRow) {
                            top = 90;
                        }
                        else
                        {
                            top = firstRowTop;
                        }
                        if(direction == "r" && left > maxLeft-180-128)
                        {
                            top =maxTop + 130;
                            maxTop = top;
                            direction = "l";
                            maxRow++;
                            lastRow = maxRow;
                            firstRowTop = top;
                            row.direction = 't';
                        }
                        else if(direction=="l" && left < 180-20)
                        {
                            top =maxTop + 130;
                            maxTop = top;
                            direction = "r";
                            maxRow++;
                            lastRow = maxRow;
                            firstRowTop = top;
                            row.direction = 't';
                        }
                        else
                        {
                            if(direction=="r")
                            {
                                left += 180;
                            }
                            else
                            {
                                left -= 180;
                            }
                        }
                    }
                    var nodeDiv = document.createElement('div');
                    var nodeId = "window"+row.prcs_id+"_"+row.flow_prcs;
                    $(nodeDiv)
                        .attr("id",nodeId)
                        .addClass("window "+row.prcs_class)
                        .css({"left":left,"top":top})
                        .attr("title",row.prcs_title)
                        .attr({"prcs_id":row.prcs_id, "flow_prcs":row.flow_prcs, "prcs_type":row.prcs_type, "prcs_parent":row.prcs_parent, "gather_node":row.gather_node, "RDirection":row.direction})
                        .html('<table class="window-content"><tr><td>'+row.prcs_content+'</td></tr></table>');
                    $("#prcsList").append(nodeDiv);
                    lastPrcsId = row.prcs_id;
                });

                var lastFlowPrcs = 0;
                $(".window").each(function(){
                    var prcs_id = $(this).attr("prcs_id");
                    var flow_prcs = $(this).attr("flow_prcs");
                    var prcs_type=$(this).attr("prcs_type");
                    var prcs_parent = $(this).attr("prcs_parent");
                    var gather_node = $(this).attr("gather_node");
                    var prePrcsId = prcs_id - 1;
                    var dynamicAnchors = [ "Right", "Left" ];
                    var direction = $(this).attr("RDirection");
                    if(direction == "t")
                        var dynamicAnchors = [ "Bottom", "Top" ];
                    if(prcs_parent!="" && prcs_parent!=0)
                    {
                        var parentArr = prcs_parent.split(",");
                        for(var j in parentArr)
                        {
                            fromPrcsId = prePrcsId;
                            if($("#window"+fromPrcsId+"_"+parentArr[j]).size()<=0)
                            {
                                fromPrcsId--;
                                while(fromPrcsId>0)
                                {
                                    if($("#window"+fromPrcsId+"_"+parentArr[j]).size() > 0)
                                    {
                                        jsPlumb.connect({source:"window"+fromPrcsId+"_"+parentArr[j], target:this.id, anchor:dynamicAnchors},aConnection);
                                        break;
                                    }
                                    fromPrcsId--;
                                }
                            }
                            else
                            {
                                jsPlumb.connect({source:"window"+fromPrcsId+"_"+parentArr[j], target:this.id, anchor:dynamicAnchors},aConnection);
                            }
                        }
                    }
                    else if($("#window"+prePrcsId+"_"+lastFlowPrcs).size() > 0)
                    {
                        jsPlumb.connect({source:"window"+prePrcsId+"_"+lastFlowPrcs, target:this.id, anchor:dynamicAnchors},aConnection);
                    }

                    lastFlowPrcs = flow_prcs;

                    //双击显示子流程
                    if(prcs_type!='' && prcs_type!='timeout')
                        $(this).dblclick(function(){
                            var myleft=(screen.availWidth-800)/2;
                            window.open("index.php?RUN_ID="+prcs_type+"&archive_time=",null,"status=0,toolbar=no,menubar=no,location=no,scrollbars=yes,resizable=yes,width=800,height=400,left="+myleft+",top=100");
                        });
                });
            }
            $("[title]").tooltip({track:true,className:"red"});
        });
    });

</script>
</html>
