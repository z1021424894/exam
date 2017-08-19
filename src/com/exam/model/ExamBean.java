package com.exam.model;

import java.util.List;

public class ExamBean {
	private List exam;		//所有的考试科目对象
	private List info;		//该学生所有的报名信息
	
	public List getExam() {
		return exam;
	}
	public void setExam(List exam) {
		this.exam = exam;
	}
	public List getInfo() {
		return info;
	}
	public void setInfo(List info) {
		this.info = info;
	}	
}
