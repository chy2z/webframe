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
        <img src="${ctx}/js/jsplumb/images/menu/workflow.gif">
        <span class="big3">
             流程名称:系统上线/升级申请流程 | 流程分类:技术部 |</span>
        <div class="big3">
            颜色标识说明：<span style="color: #50C625;">■</span>开始节点 &nbsp;&nbsp;<span style="color: #F4A8BD;">■</span>结束节点
            &nbsp;&nbsp;<span style="color: #EEEEEE;">■</span>普通节点
        </div>
    </div>
    <div id="prcsList"></div>
</div>
</body>
<script>
    /**
     * 不需要计算坐标
     * @returns {boolean}
     */

    // chrome fix.
    document.onselectstart = function () {
        return false;
    };

    $(document).ready(function () {
        $.getJSON("${ctx}/js/jsplumb/data1.json", function (json) {
            console.log(json);
            var fillColor = "gray";
            //jsPlumb.setRenderMode(jsPlumb.VML);
            jsPlumb.Defaults.Connector = ["Straight", {curviness: 50}];
            jsPlumb.Defaults.DragOptions = {cursor: "pointer", zIndex: 2000};
            jsPlumb.Defaults.PaintStyle = {strokeStyle: fillColor, lineWidth: 2};
            jsPlumb.Defaults.EndpointStyle = {radius: 4, fillStyle: fillColor};

            var anchors = [[0.5, 0, 0, -1], [1, 0.5, 1, 0], [0.5, 1, 0, 1], [0, 0.5, -1, 0]];
            var arrowCommon = {foldback: 0.7, fillStyle: fillColor, width: 14};
            var aConnection = {
                dynamicAnchors: anchors,
                overlays: [
                    ["Arrow", {location: 0.7}, arrowCommon]
                ]
            };

            if (json.total > 0) {
                $.each(json.list, function (i, row) {
                    var nodeDiv = document.createElement('div');
                    var nodeId = "window" + row.prcs_id;
                    $(nodeDiv)
                        .attr("id", nodeId)
                        .attr("to", row.to)
                        .addClass("window window_" + row.prcs_type)
                        .css({"left": parseInt(row.left), "top": parseInt(row.top) + 60})
                        .attr("title", row.title)
                        .html('<table class="window-content"><tr><td>' + row.prcs_content + '</td></tr></table>');
                    $("#prcsList").append(nodeDiv);

                });

                //遍历节点并连线
                $(".window").each(function () {
                    toArr = $(this).attr("to").split(",");
                    var dynamicAnchors = ["Right", "Left"];
                    //jsPlumb.draggable(jsPlumb.getSelector("#"+this.id));
                    for (var i in toArr) {
                        if (toArr[i] != "" && $("#window" + toArr[i]).size() > 0 && this.id != "window" + toArr[i]) {
                            jsPlumb.connect({
                                source: this.id,
                                target: "window" + toArr[i],
                                anchor: [["Perimeter", {
                                    shape: "Rectangle",
                                    rotation: 0
                                }], ["Perimeter", {shape: "Rectangle", rotation: 0}]]
                            }, aConnection);
                        }
                    }
                });

                $("[title]").tooltip();
            }
        });
    });
</script>
</html>
