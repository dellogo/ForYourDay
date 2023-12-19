package com.bitstudy.app.domain;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class TodoTermDto {
    private Integer tt_no;
    private Integer user_no;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date tt_start_date;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date tt_fin_date;
    private String tt_content;
    private Integer tt_state;
    private Date tt_update;

    public TodoTermDto(Integer tt_no, Integer user_no, Date tt_start_date, Date tt_fin_date, String tt_content, Integer tt_state, Date tt_update) {
        this.tt_no = tt_no;
        this.user_no = user_no;
        this.tt_start_date = tt_start_date;
        this.tt_fin_date = tt_fin_date;
        this.tt_content = tt_content;
        this.tt_state = tt_state;
        this.tt_update = tt_update;
    }

    public TodoTermDto() {
    }

    @Override
    public String toString() {
        return "TodoTermDto{" +
                "tt_no=" + tt_no +
                ", user_no=" + user_no +
                ", tt_start_date=" + tt_start_date +
                ", tt_fin_date=" + tt_fin_date +
                ", tt_content='" + tt_content + '\'' +
                ", tt_state=" + tt_state +
                ", tt_update=" + tt_update +
                '}';
    }

    public Integer getTt_no() {
        return tt_no;
    }

    public void setTt_no(Integer tt_no) {
        this.tt_no = tt_no;
    }

    public Integer getUser_no() {
        return user_no;
    }

    public void setUser_no(Integer user_no) {
        this.user_no = user_no;
    }

    public Date getTt_start_date() {
        return tt_start_date;
    }

    public void setTt_start_date(Date tt_start_date) {
        this.tt_start_date = tt_start_date;
    }

    public Date getTt_fin_date() {
        return tt_fin_date;
    }

    public void setTt_fin_date(Date tt_fin_date) {
        this.tt_fin_date = tt_fin_date;
    }

    public String getTt_content() {
        return tt_content;
    }

    public void setTt_content(String tt_content) {
        this.tt_content = tt_content;
    }

    public Integer getTt_state() {
        return tt_state;
    }

    public void setTt_state(Integer tt_state) {
        this.tt_state = tt_state;
    }

    public Date getTt_update() {
        return tt_update;
    }

    public void setTt_update(Date tt_update) {
        this.tt_update = tt_update;
    }
}

