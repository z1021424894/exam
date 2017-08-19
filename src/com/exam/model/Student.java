package com.exam.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;


@Entity

public class Student {
	private int id;				//主键
	private double user_id;		//学号
	private String password;	//密码
	private String name;		//姓名
	private String sex;			//性别
	private double tel;			//联系电话
	private String email;		//邮箱
	private double qq;			//QQ
	
	@Id
	@GeneratedValue
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getUser_id() {
		return user_id;
	}
	public void setUser_id(double user_id) {
		this.user_id = user_id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public double getTel() {
		return tel;
	}
	public void setTel(double tel) {
		this.tel = tel;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public double getQq() {
		return qq;
	}
	public void setQq(double qq) {
		this.qq = qq;
	}
}
