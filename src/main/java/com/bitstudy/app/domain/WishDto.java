package com.bitstudy.app.domain;

import java.util.Date;

public class WishDto {
    private Integer w_no;
    private Integer user_no;
    private String w_content;
    private String w_type;
    private Date w_update;
    private Integer w_state;

    public WishDto(Integer w_no, Integer user_no, String w_content, String w_type, Date w_update, Integer w_state) {
        this.w_no = w_no;
        this.user_no = user_no;
        this.w_content = w_content;
        this.w_type = w_type;
        this.w_update = w_update;
        this.w_state = w_state;
    }

    public WishDto() {
    }

    @Override
    public String toString() {
        return "WishDto{" +
                "w_no=" + w_no +
                ", user_no=" + user_no +
                ", w_content='" + w_content + '\'' +
                ", w_type='" + w_type + '\'' +
                ", w_update=" + w_update +
                ", w_state=" + w_state +
                '}';
    }

    public Integer getW_no() {
        return w_no;
    }

    public void setW_no(Integer w_no) {
        this.w_no = w_no;
    }

    public Integer getUser_no() {
        return user_no;
    }

    public void setUser_no(Integer user_no) {
        this.user_no = user_no;
    }

    public String getW_content() {
        return w_content;
    }

    public void setW_content(String w_content) {
        this.w_content = w_content;
    }

    public String getW_type() {
        return w_type;
    }

    public void setW_type(String w_type) {
        this.w_type = w_type;
    }

    public Date getW_update() {
        return w_update;
    }

    public void setW_update(Date w_update) {
        this.w_update = w_update;
    }

    public Integer getW_state() {
        return w_state;
    }

    public void setW_state(Integer w_state) {
        this.w_state = w_state;
    }
}
