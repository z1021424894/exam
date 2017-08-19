package com.exam.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
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
import com.exam.model.Info;
import com.exam.model.PageBean;
import com.exam.model.Student;


@Controller
public class InfoController {
	private InfoDao infoDao;

	public InfoDao getInfoDao() {
		return infoDao;
	}
	@Resource
	public void setInfoDao(InfoDao infoDao) {
		this.infoDao = infoDao;
	}
	
	private ExamDao examDao;
	
	public ExamDao getExamDao() {
		return examDao;
	}
	@Resource
	public void setExamDao(ExamDao examDao) {
		this.examDao = examDao;
	}
	/*添加信息*/
	@RequestMapping(value="add_info" ,method=RequestMethod.POST)
	@ResponseBody
	public JSONArray add_info(HttpServletRequest request, HttpServletResponse response)
	{
		Double user_id = Double.parseDouble(request.getParameter("user_id"));
		String exam_name = request.getParameter("exam_name");
		Exam exam = examDao.getExamByName(exam_name);
		Date date = new Date();
		SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			date = sdf.parse(sdf.format(date));
		} catch (ParseException e) {
			
			e.printStackTrace();
		}
		if(date.before(exam.getEntertime())) {
			HashMap<String, String> result =new HashMap<String, String>();
			result.put("add_info_result", "beforetime");
			JSONArray json = JSONArray.fromObject(result);
			return json;
		}
		else if(date.after(exam.getEndtime())) {
			HashMap<String, String> result =new HashMap<String, String>();
			result.put("add_info_result", "aftertime");
			JSONArray json = JSONArray.fromObject(result);
			return json;
		}
		Info inf = new Info();	
		List<Info> list = infoDao.getInfoByUser_Id(user_id);
		Iterator iterator = list.iterator();
        while(iterator.hasNext()) {			
			inf = (Info)iterator.next();
			if(exam_name.equals(inf.getExam_name())) {
				HashMap<String, String> result =new HashMap<String, String>();
				result.put("add_info_result", "repeat");
				JSONArray json = JSONArray.fromObject(result);
				return json;
				}
		};
		Info info = new Info();			
		String name = request.getParameter("name");
		Date exp = exam.getExp();
		int mark = exam.getMark();
		info.setUser_id(user_id);
		info.setName(name);
		info.setExam_name(exam_name);
		info.setTime(date);
		info.setExp(exp);
		info.setMark(mark);
		infoDao.save(info);
		HashMap<String, String> result =new HashMap<String, String>();
		result.put("add_info_result", "success");
		JSONArray json = JSONArray.fromObject(result);
		return json;
	 }
	
	/*分页得到所有信息*/
	@RequestMapping(value="get_allinfo" ,method=RequestMethod.POST)
	@ResponseBody
	public PageBean getAllInfo(HttpServletRequest request, HttpServletResponse response)
	{
		PageBean pageBean = new PageBean();
		Integer currentPage = Integer.parseInt(request.getParameter("currentPage"));
		Integer pageSize = Integer.parseInt(request.getParameter("pageSize"));
		int count = infoDao.getCount();
		int levelCount = infoDao.getLevelCount();
		int totalPage = (int)Math.ceil((double)count/pageSize);
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setCount(count);
		pageBean.setTotalPage(totalPage);
		pageBean.setLevelCount(levelCount);
		int begin = (currentPage - 1)*pageSize;
		List<Info> list = infoDao.get_allinfo(begin,pageSize);
		pageBean.setList(list);
		return pageBean; 
	}
	
	/*搜索信息*/
	@RequestMapping(value="search_info" ,method=RequestMethod.POST)
	@ResponseBody
	public PageBean searchInfo(HttpServletRequest request, HttpServletResponse response)
	{
		PageBean pageBean = new PageBean();
		String condition = request.getParameter("condition");
		Integer currentPage = Integer.parseInt(request.getParameter("currentPage"));
		Integer pageSize = Integer.parseInt(request.getParameter("pageSize"));
		int count = infoDao.searchCount(condition);
		int levelCount = infoDao.searchLevelCount(condition);
		int totalPage = (int)Math.ceil((double)count/pageSize);
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setCount(count);
		pageBean.setTotalPage(totalPage);
		pageBean.setLevelCount(levelCount);
		int begin = (currentPage - 1)*pageSize;
		List<Info> list = infoDao.search_info(condition,begin,pageSize);
		pageBean.setList(list);
		return pageBean;
	}
	
	/*得到学生考试信息*/
	@RequestMapping(value="get_info" ,method=RequestMethod.POST)
	@ResponseBody
	public List<Info> getInfo(HttpServletRequest request, HttpServletResponse response)
	{
		Double user_id = Double.parseDouble(request.getParameter("user_id"));
		return infoDao.getInfoByUser_Id(user_id);
		
	}
	
	/*删除信息*/
	@RequestMapping(value="delete_info" ,method=RequestMethod.POST)
	@ResponseBody
	public JSONArray delete_info(HttpServletRequest request, HttpServletResponse response)
	{
		int id = Integer.parseInt(request.getParameter("id"));
		Info info = infoDao.getInfoById(id);
		infoDao.delete(info);
		HashMap<String, String> result =new HashMap<String, String>();
		result.put("delete_info_result", "success");
		JSONArray json = JSONArray.fromObject(result);
		return json;
	}
	
	/*修改信息*/
	@RequestMapping(value="update_info" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView update_info(HttpServletRequest request, HttpServletResponse response)
	{
		int id = Integer.parseInt(request.getParameter("id"));
		Info info = infoDao.getInfoById(id);
		if(info.getExam_name() != null)
		{
			String name = request.getParameter("name");
			String exam_name = request.getParameter("exam_name");
			String level = request.getParameter("level");
			int score = Integer.parseInt(request.getParameter("score"));
			Double user_id = Double.parseDouble(request.getParameter("user_id"));
			Double cmn = Double.parseDouble(request.getParameter("cmn"));
			SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
			Date time = new Date();
			try {
				time = sdf.parse(request.getParameter("time"));
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
			Exam exam = examDao.getExamByName(exam_name);
			int mark = exam.getMark();
			if(score >= mark) {
				 level = "合格";
			}
			else {
				 level = "不合格";
			}
			info.setUser_id(user_id);
			info.setName(name);
			info.setExam_name(exam_name);
			info.setTime(time);
			info.setScore(score);
			info.setLevel(level);
			info.setCmn(cmn);
			infoDao.update(info);
			return new ModelAndView("admin_enter_score","update_info_result","success");
		}
		else
		{
			return new ModelAndView("admin_enter_score","update_info_result","fail");
		}
	}
	/*录入成绩*/
	@RequestMapping(value="update_score" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView update_score(HttpServletRequest request, HttpServletResponse response)
	{
		int id = Integer.parseInt(request.getParameter("id"));
		Info info = infoDao.getInfoById(id);
		String exam_name = info.getExam_name();
		if(exam_name != null)
		{
			Date date = new Date();
			SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				date = sdf.parse(sdf.format(date));
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
			if(date.after(info.getExp())) {
				return new ModelAndView("stu_score","update_score_result","afterExp");
			}
			else {
				int mark = info.getMark();
				int score = Integer.parseInt(request.getParameter("score"));
				String level = null;
				if(score >= mark) {
					 level = "合格";
				}
				else {
					 level = "不合格";
				}
				Double cmn = Double.parseDouble(request.getParameter("cmn"));
				info.setScore(score);
				info.setCmn(cmn);
				info.setLevel(level);
				infoDao.update(info);
				return new ModelAndView("stu_score","update_score_result","success");
			}
		}
		else
		{
			return new ModelAndView("stu_score","update_score_result","fail");
		}
	}
}
