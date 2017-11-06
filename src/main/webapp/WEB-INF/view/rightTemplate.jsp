<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<Button-Group size="large" shape="circle">
    <template v-if="butShow.butSearch">
        <i-Button type="primary" @click="butSearch()" v-show="butShow.butSearch" icon="ios-search-strong">搜索</i-Button>
    </template>
    <template v-if="butShow.butAdd">
        <i-Button type="primary" @click="butAdd()" v-show="butShow.butAdd" icon="plus">增加</i-Button>
    </template>
    <template v-if="butShow.butEdit">
        <i-Button type="primary" @click="butEdit()" v-show="butShow.butEdit" icon="edit">修改</i-Button>
    </template>
    <template v-if="butShow.butDel">
        <i-Button type="primary" @click="butDel()" v-show="butShow.butDel" icon="close">删除</i-Button>
    </template>
    <template v-if="butShow.butLook">
        <i-Button type="primary" @click="butLook()" v-show="butShow.butLook" icon="ios-glasses">查看</i-Button>
    </template>
    <template v-if="butShow.butSave">
        <i-Button type="primary" @click="butSave()" v-show="butShow.butSave" icon="plus">保存</i-Button>
    </template>
    <template v-if="butShow.butExport">
        <i-Button type="primary" @click="butExport()" v-show="butShow.butExport" icon="arrow-down-c">导出</i-Button>
    </template>
    <template v-if="butShow.butRefresh">
        <i-Button type="primary" @click="butRefresh()" v-show="butShow.butRefresh" icon="refresh">刷新</i-Button>
    </template>
</Button-Group>