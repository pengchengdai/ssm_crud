package com.dpc.domain;

import com.github.pagehelper.PageInfo;

import java.util.HashMap;
import java.util.Map;

/**
 * 通用的响应信息
 */
public class CommonResponseMsg<E> {
    private Status code;//状态码
    private String msg;//提示信息
    //响应数据
    private Map<String,E> map = new HashMap<>();

    public CommonResponseMsg() {
    }

    public CommonResponseMsg(Status code, String msg, Map<String, E> map) {
        this.code = code;
        this.msg = msg;
        this.map = map;
    }

    public Status getCode() {
        return code;
    }

    public void setCode(Status code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, E> getMap() {
        return map;
    }

    //成功
    public CommonResponseMsg<E> success(){
        this.setCode(Status.SUCCESS);
        this.setMsg("响应成功！");
        return this;
    }
    //失败
    public CommonResponseMsg<E> fail(){
        this.setCode(Status.FAIL);
        this.setMsg("响应失败！");
        return this;
    }

    public CommonResponseMsg<E> append(String key, E value) {
        this.getMap().put(key, value);
        return this;
    }


    //响应状态
    static enum Status{
        SUCCESS,FAIL;
    }
}
