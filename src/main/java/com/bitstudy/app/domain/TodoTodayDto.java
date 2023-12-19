package com.bitstudy.app.domain;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class TodoTodayDto {
    private Integer t_no;
    private Integer user_no;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date t_date;
    private String t_content;
    private Integer t_state;
    private Date t_update;

    public TodoTodayDto(Integer t_no, Integer user_no, Date t_date, String t_content, Integer t_state, Date t_update) {
        this.t_no = t_no;
        this.user_no = user_no;
        this.t_date = t_date;
        this.t_content = t_content;
        this.t_state = t_state;
        this.t_update = t_update;
    }

    public TodoTodayDto() {
    }

    @Override
    public String toString() {
        return "TodoTodayDto{" +
                "t_no=" + t_no +
                ", user_no=" + user_no +
                ", t_date=" + t_date +
                ", t_content='" + t_content + '\'' +
                ", t_state=" + t_state +
                ", t_update=" + t_update +
                '}';
    }

    public Integer getT_no() {
        return t_no;
    }

    public void setT_no(Integer t_no) {
        this.t_no = t_no;
    }

    public Integer getUser_no() {
        return user_no;
    }

    public void setUser_no(Integer user_no) {
        this.user_no = user_no;
    }

    public Date getT_date() {
        return t_date;
    }

    public void setT_date(Date t_date) {
        this.t_date = t_date;
    }

    public String getT_content() {
        return t_content;
    }

    public void setT_content(String t_content) {
        this.t_content = t_content;
    }

    public Integer getT_state() {
        return t_state;
    }

    public void setT_state(Integer t_state) {
        this.t_state = t_state;
    }

    public Date getT_update() {
        return t_update;
    }

    public void setT_update(Date t_update) {
        this.t_update = t_update;
    }
}
