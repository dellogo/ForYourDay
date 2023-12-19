package com.bitstudy.app.domain;

import java.util.Date;

public class UserDto {
    private Integer user_no;
    private String user_id;
    private String user_pw;
    private String user_name;
    private String user_birth;
    private Date user_joindate;

    public UserDto(Integer user_no, String user_id, String user_pw, String user_name, String user_birth, Date user_joindate) {
        this.user_no = user_no;
        this.user_id = user_id;
        this.user_pw = user_pw;
        this.user_name = user_name;
        this.user_birth = user_birth;
        this.user_joindate = user_joindate;
    }

    public UserDto() {
    }

    @Override
    public String toString() {
        return "UserDto{" +
                "user_no=" + user_no +
                ", user_id='" + user_id + '\'' +
                ", user_pw='" + user_pw + '\'' +
                ", user_name='" + user_name + '\'' +
                ", user_birth=" + user_birth +
                ", user_joindate=" + user_joindate +
                '}';
    }

    public Integer getUser_no() {
        return user_no;
    }

    public void setUser_no(Integer user_no) {
        this.user_no = user_no;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getUser_pw() {
        return user_pw;
    }

    public void setUser_pw(String user_pw) {
        this.user_pw = user_pw;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_birth() {
        return user_birth;
    }

    public void setUser_birth(String user_birth) {
        this.user_birth = user_birth;
    }

    public Date getUser_joindate() {
        return user_joindate;
    }

    public void setUser_joindate(Date user_joindate) {
        this.user_joindate = user_joindate;
    }
}
