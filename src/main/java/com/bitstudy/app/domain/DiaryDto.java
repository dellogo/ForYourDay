package com.bitstudy.app.domain;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class DiaryDto {
    private Integer d_no;
    private Integer user_no;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date d_date;
    private String d_content;
    private String d_condition;
    private Date d_update;

    public DiaryDto(Integer d_no, Integer user_no, Date d_date, String d_content, String d_condition, Date d_update) {
        this.d_no = d_no;
        this.user_no = user_no;
        this.d_date = d_date;
        this.d_content = d_content;
        this.d_condition = d_condition;
        this.d_update = d_update;
    }

    public DiaryDto() {
    }

    @Override
    public String toString() {
        return "DiaryDto{" +
                "d_no=" + d_no +
                ", user_no=" + user_no +
                ", d_date=" + d_date +
                ", d_content='" + d_content + '\'' +
                ", d_condition='" + d_condition + '\'' +
                ", d_update=" + d_update +
                '}';
    }

    public Integer getD_no() {
        return d_no;
    }

    public void setD_no(Integer d_no) {
        this.d_no = d_no;
    }

    public Integer getUser_no() {
        return user_no;
    }

    public void setUser_no(Integer user_no) {
        this.user_no = user_no;
    }

    public Date getD_date() {
        return d_date;
    }

    public void setD_date(Date d_date) {
        this.d_date = d_date;
    }

    public String getD_content() {
        return d_content;
    }

    public void setD_content(String d_content) {
        this.d_content = d_content;
    }

    public String getD_condition() {
        return d_condition;
    }

    public void setD_condition(String d_condition) {
        this.d_condition = d_condition;
    }

    public Date getD_update() {
        return d_update;
    }

    public void setD_update(Date d_update) {
        this.d_update = d_update;
    }
}
