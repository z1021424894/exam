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

import com.exam.dao.AnnDao;
import com.exam.model.Ann;


@Controller
public class AnnController {
	private AnnDao annDao;

	public AnnDao getAnnDao() {
		return annDao;
	}
	
	@Resource
	public void setAnnDao(AnnDao annDao) {
		this.annDao = annDao;
	}
	
	/*添加公告*/
	@RequestMapping(value="add_ann" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView add_exam(HttpServletRequest request, HttpServletResponse response)
	{
		String title = request.getParameter("title");
		Ann ann = annDao.getAnnByTitle(title);
		if(ann.getTitle() == null)
		{
			String content = request.getParameter("content");
			Date date = new Date();
			SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				date = sdf.parse(sdf.format(date));
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
			ann.setTitle(title);
			ann.setContent(content);
			ann.setTime(date);
			annDao.save(ann);
			return new ModelAndView("admin_ann","add_ann_result","success");
		}
		else
		{
			return new ModelAndView("admin_ann","add_ann_result","fail");
		}
	 }
	
	/*得到所有公告信息*/
	@RequestMapping(value="get_ann" ,method=RequestMethod.POST)
	@ResponseBody
	public List<Ann> getAnn()
	{
		return annDao.get_ann();
		 
	}
	
	/*搜索公告信息*/
	@RequestMapping(value="search_ann" ,method=RequestMethod.POST)
	@ResponseBody
	public List<Ann> searchAnn(HttpServletRequest request, HttpServletResponse response)
	{
		String condition = request.getParameter("condition");
		return annDao.search_ann(condition);
		
	}
	
	/*修改公告信息*/
	@RequestMapping(value="update_ann" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView update_ann(HttpServletRequest request, HttpServletResponse response)
	{
		int id = Integer.parseInt(request.getParameter("id"));
		Ann ann = annDao.getAnnById(id);
		if(ann.getTitle() != null)
		{
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			Date date = new Date();
			SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				date = sdf.parse(sdf.format(date));
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
			ann.setTitle(title);
			ann.setContent(content);
			ann.setTime(date);
			annDao.update(ann);
			return new ModelAndView("admin_ann","update_ann_result","success");
		}
		else
		{
			return new ModelAndView("admin_ann","update_ann_result","fail");
		}
	}
	
	/*删除公告*/
	@RequestMapping(value="delete_ann" ,method=RequestMethod.POST)
	@ResponseBody
	public JSONArray delete_ann(HttpServletRequest request, HttpServletResponse response)
	{
		int id = Integer.parseInt(request.getParameter("id"));
		Ann ann = annDao.getAnnById(id);
		annDao.delete(ann);
		HashMap<String, String> result =new HashMap<String, String>();
		result.put("delete_ann_result", "success");
		JSONArray json = JSONArray.fromObject(result);
		return json;
	}
}
