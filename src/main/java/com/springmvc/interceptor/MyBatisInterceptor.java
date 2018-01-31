package com.springmvc.interceptor;

import com.springmvc.util.JsonUtil;
import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Properties;

/**
* @Title: MyBatisInterceptor
* @Description: mybatis 拦截器  日志输出debug级别
* @author chy
* @date 2018/1/31 8:43
*/
@Intercepts(value = {
        @Signature(type = Executor.class, method = "update", args = { MappedStatement.class, Object.class })
       })
public class MyBatisInterceptor implements Interceptor {

    /**
     * 注解拦截接口的方法
     * Executor (update, query, flushStatements, commit, rollback, getTransaction, close, isClosed)
     * ParameterHandler (getParameterObject, setParameters)
     * ResultSetHandler (handleResultSets, handleOutputParameters)
     * StatementHandler (prepare, parameterize, batch, update, query)
     */

    /*
    method表示需要拦截的方法，mybatis有
            update, query, flushStatements, commit, rollback, getTransaction, close, isClosed
    方法，其中，update包括新增、修改、删除等方法，query用于查询，其它的基本用不到。
    type表示拦截的接口类型，有Executor、StatementHandler、ParameterHandler和ResultSetHandler。
    args表示拦截的参数类型，有MappedStatement、Object、RowBounds和ResultHandler等等.
    */

    private static final Logger LOGGER = LoggerFactory.getLogger(MyBatisInterceptor.class);

    private Properties properties;

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        Object[] args = invocation.getArgs();
        // 获取执行的方法
        if (args.length > 1) {
            // 传入的对象
            Object obj = args[1];
            saveLog(args[0], obj);
        }
        return invocation.proceed();
    }

    private void saveLog(Object arg, Object obj) {
        MappedStatement mappedStatement = (MappedStatement) arg;
        // 执行的方法名
        String name = mappedStatement.getSqlCommandType().name();
        String change = JsonUtil.writeValueAsString(obj);
        if (name.startsWith("INSERT")) {
            //log.setType("新增" + obj.getClass().getSimpleName());
            //log.setNewContent(change);
        } else if (name.startsWith("UPDATE")) {
            //log.setType("修改" + obj.getClass().getSimpleName());
            //log.setNewContent(change);
        } else if (name.startsWith("DELETE")) {
            //log.setType("删除" + obj.getClass().getSimpleName());
            //log.setOldContent(change);
        }

        LOGGER.info("----------------------------------------------");
        LOGGER.info("mybatis----->"+change);
        LOGGER.info("----------------------------------------------");
    }

    @Override
    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }

    @Override
    public void setProperties(Properties properties) {
        this.properties = properties;
    }

}
