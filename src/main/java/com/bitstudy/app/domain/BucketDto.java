package com.bitstudy.app.domain;

import java.util.Date;

public class BucketDto {
    private Integer b_no;
    private Integer user_no;
    private String b_content;
    private String b_type;
    private Date b_update;
    private Integer b_state;

    public BucketDto(Integer b_no, Integer user_no, String b_content, String b_type, Date b_update, Integer b_state) {
        this.b_no = b_no;
        this.user_no = user_no;
        this.b_content = b_content;
        this.b_type = b_type;
        this.b_update = b_update;
        this.b_state = b_state;
    }

    public BucketDto() {
    }

    @Override
    public String toString() {
        return "BucketDto{" +
                "b_no=" + b_no +
                ", user_no=" + user_no +
                ", b_content='" + b_content + '\'' +
                ", b_type='" + b_type + '\'' +
                ", b_update=" + b_update +
                ", b_state=" + b_state +
                '}';
    }

    public Integer getB_no() {
        return b_no;
    }

    public void setB_no(Integer b_no) {
        this.b_no = b_no;
    }

    public Integer getUser_no() {
        return user_no;
    }

    public void setUser_no(Integer user_no) {
        this.user_no = user_no;
    }

    public String getB_content() {
        return b_content;
    }

    public void setB_content(String b_content) {
        this.b_content = b_content;
    }

    public String getB_type() {
        return b_type;
    }

    public void setB_type(String b_type) {
        this.b_type = b_type;
    }

    public Date getB_update() {
        return b_update;
    }

    public void setB_update(Date b_update) {
        this.b_update = b_update;
    }

    public Integer getB_state() {
        return b_state;
    }

    public void setB_state(Integer b_state) {
        this.b_state = b_state;
    }
}
