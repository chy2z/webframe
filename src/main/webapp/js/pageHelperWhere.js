/**
 * where条件关系
 * @param _fieldName
 * @param _fieldValue
 * @param _dataType
 * @param _relationValue
 * @param _operate
 * @param _like
 */
function whereRelation(_fieldName,_fieldValue,_dataType,_relationValue,_operate,_like)
{
   this.fieldName = null;          //字段名称
   this.fieldValue = null;         //字段值
   this.dataType = "string";       //数据类型(默认是字符串型)
   this.relationValue = null;      //关系值
   this.operate = "=";             //运算符（>,<）-------------------------对数值行有效  
   this.like =true;                //是否是模糊查找（默认模糊）------------对字符串有效
   
   if (arguments.length !=0)
   {
      this.fieldName=_fieldName;
      this.fieldValue=_fieldValue;
      this.dataType=_dataType;
      this.relationValue=_relationValue;
      this.operate=_operate;
      this.like=_like;
   } 
}

/**
 * 字段类别
 * @type
 */
var WhereDataType={
     String : "string",
     Int : "int",
     Decimal : "decimal",
     Float: "float",
     Datatime : "datatime"
}

/**
 * 分页生成where查询条件
 * @param whereRelationArry
 */
function pageHelperWhere(whereRelationArry)
{
    /**
     * 模糊查询
     * @param wr
     * @returns {string}
     * @constructor
     */
    this.Like=function(wr){
       if(wr.like) 
           return   wr.fieldName + " like '%" + wr.fieldValue + "%'";    
       else
           return   wr.fieldName + " = '" + wr.fieldValue + "'";    
    }

    /**
     * 精确查询
     * @param wr
     * @returns {*}
     * @constructor
     */
    this.Equal=function(wr){
       return wr.fieldName + wr.operate + wr.fieldValue;
    }

    /**
     * 区间查询
     * @param wr
     * @returns {*}
     * @constructor
     */
    this.CompareTo=function(wr){
        if (wr.dataType == WhereDataType.String || wr.dataType == WhereDataType.Datatime){
            if (wr.fieldValue != "" && wr.relationValue != "")
                return wr.fieldName + " >='" + wr.fieldValue + "' and  " + wr.fieldName + " <='" + wr.relationValue + "'";
            else if (wr.fieldValue != "")
                return wr.fieldName + " >='" + wr.fieldValue + "'";
            else if (wr.relationValue != "")
                return wr.fieldName + " <='" + wr.relationValue + "'";
            else
                return "";
        }
        else{
            if (wr.fieldValue != "" && wr.relationValue != "")
                return wr.fieldName + " >=" + wr.fieldValue + " and  " + wr.fieldName + " <=" + wr.relationValue;
            else if (wr.fieldValue != "")
                return wr.fieldName + " >=" + wr.fieldValue + "";
            else if (wr.relationValue != "")
                return wr.fieldName + " <=" + wr.relationValue + "";
            else
                return "";
        }
    }

    /**
     * 获取查询条件
     * @returns {*}
     */
    this.getWhere=function() {
        var _self = this;

        var sb = "";

        var index = whereRelationArry.length;

        var str = "";

        $.each(whereRelationArry, function (i, wr) {
            index--;

            // 过滤异常数据
            if (wr.fieldValue == null || typeof(wr.fieldValue) == "undefined") {
                return true;
            }

            // 字符串非模糊查询过滤空白项
            if (wr.fieldValue == "" && wr.relationValue == null && wr.operate == null && !wr.like) {
                return true;
            }

            // 字符串模糊查询过滤空白项
            if (wr.fieldValue == "" && wr.relationValue == null && wr.like) {
                return true;
            }

            if (wr.dataType == WhereDataType.String || wr.dataType == WhereDataType.Datatime) {
                if (wr.relationValue == null){
                    str = _self.Like(wr);
                }
                else{
                    str = _self.CompareTo(wr);
                }
            }
            else if (wr.dataType == WhereDataType.Int || wr.dataType == WhereDataType.Decimal || wr.dataType == WhereDataType.Float) {
                if (wr.relationValue == null) {
                    str = _self.Equal(wr);
                }
                else {
                    str = _self.CompareTo(wr);
                }
            }
            if (str.Trim() == "" && sb.length != 0) {
                sb = sb.substring(0, sb.length - 4);
            }
            else {
                sb = sb + str;
            }
            if (index != 0) {
                if (sb.Trim() != "") {
                    sb = sb + " and ";
                }
            }
        });

        if (sb.Trim().length != 0) {
            var stt = sb.split("and");
            if (stt[stt.length - 1].Trim() == ""){
                sb = sb.substring(0, sb.length - 4);
            }
            if (stt[0].Trim() == ""){
                sb = sb.substring(4);
            }
            stt = null;
        }
        else {
            return null;
        }

        return sb;
    }
}