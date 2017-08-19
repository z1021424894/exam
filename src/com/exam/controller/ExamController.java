package com.exam.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.exam.dao.ExamDao;
import com.exam.dao.InfoDao;
import com.exam.model.Admin;
import com.exam.model.Exam;
import com.exam.model.ExamBean;
import com.exam.model.Student;



@Controller
public class ExamController {
	private ExamDao examDao;

	public ExamDao getExamDao() {
		return examDao;
	}

	@Resource
	public void setExamDao(ExamDao examDao) {
		this.examDao = examDao;
	}
	
	private InfoDao infoDao;
	
	public InfoDao getInfoDao() {
		return infoDao;
	}

	@Resource
	public void setInfoDao(InfoDao infoDao) {
		this.infoDao = infoDao;
	}

	/*添加考试*/
	@RequestMapping(value="add_exam" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView add_exam(HttpServletRequest request, HttpServletResponse response)
	{
		String exam_name=request.getParameter("exam_name");
		Exam exam = examDao.getExamByName(exam_name);
		if(exam.getExam_name() == null)
		{
			int mark = Integer.parseInt(request.getParameter("mark"));
			SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			Date entertime = new Date();
			Date endtime = new Date();
			Date examtime = new Date();
			Date exp = new Date();
			try {
				entertime = sdf.parse(request.getParameter("entertime"));
				endtime = sdf.parse(request.getParameter("endtime"));
				examtime = sdf.parse(request.getParameter("examtime"));
				exp = sdf.parse(request.getParameter("exp"));
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
			exam.setExam_name(exam_name);
			exam.setEntertime(entertime);
			exam.setEndtime(endtime);
			exam.setExamtime(examtime);
			exam.setMark(mark);
			exam.setExp(exp);
			examDao.save(exam);
			return new ModelAndView("admin_exam","add_exam_result","success");
		}
		else
		{
			return new ModelAndView("admin_exam","add_exam_result","fail");
		}
	 }
	
	/*学生得到所有考试科目信息*/
	@RequestMapping(value="get_exam" ,method=RequestMethod.POST)
	@ResponseBody
	public ExamBean getExam(HttpServletRequest request, HttpServletResponse response)
	{
		Double user_id = Double.parseDouble(request.getParameter("user_id"));
		ExamBean examBean = new ExamBean();
		SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = new Date();
		try {
			 date = sdf.parse(sdf.format(new Date()));
		} catch (ParseException e) {
			
			e.printStackTrace();
		}		
		List exam = examDao.stu_get_exam(date);
		List info = infoDao.getInfoByUser_Id(user_id);
		examBean.setExam(exam);
		examBean.setInfo(info);
		return examBean;
		 
	}
	
	/*管理员得到所有考试科目信息*/
	@RequestMapping(value="admin_get_exam" ,method=RequestMethod.POST)
	@ResponseBody
	public List<Exam> adminGetExam() {
		return examDao.get_exam();
	}
	
	/*搜索考试科目*/
	@RequestMapping(value="search_exam" ,method=RequestMethod.POST)
	@ResponseBody
	public List<Exam> searchExam(HttpServletRequest request, HttpServletResponse response)
	{
		String condition = request.getParameter("condition");
		return examDao.search_exam(condition);
		
	}
	
	/*修改考试信息*/
	@RequestMapping(value="update_exam" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView update_exam(HttpServletRequest request, HttpServletResponse response)
	{
		int id = Integer.parseInt(request.getParameter("id"));
		Exam exam = examDao.getExamById(id);
		if(exam.getExam_name() != null)
		{
			String exam_name = request.getParameter("exam_name");
			int mark = Integer.parseInt(request.getParameter("mark"));
			SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			Date entertime = new Date();
			Date endtime = new Date();
			Date examtime = new Date();
			Date exp = new Date();
			try {
				entertime = sdf.parse(request.getParameter("entertime"));
				endtime = sdf.parse(request.getParameter("endtime"));
				examtime = sdf.parse(request.getParameter("examtime"));
				exp = sdf.parse(request.getParameter("exp"));
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
			exam.setExam_name(exam_name);
			exam.setEntertime(entertime);
			exam.setEndtime(endtime);
			exam.setExamtime(examtime);
			exam.setMark(mark);
			exam.setExp(exp);
			examDao.update(exam);
			return new ModelAndView("admin_exam","update_exam_result","success");
		}
		else
		{
			return new ModelAndView("admin_exam","update_exam_result","fail");
		}
	}
	
	/*删除考试*/
	@RequestMapping(value="delete_exam" ,method=RequestMethod.POST)
	@ResponseBody
	public JSONArray delete_exam(HttpServletRequest request, HttpServletResponse response)
	{
		int id = Integer.parseInt(request.getParameter("id"));
		Exam exam = examDao.getExamById(id);
		examDao.delete(exam);
		HashMap<String, String> result =new HashMap<String, String>();
		result.put("delete_exam_result", "success");
		JSONArray json = JSONArray.fromObject(result);
		return json;
	}
}
