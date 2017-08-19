package com.exam.controller;



import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.exam.dao.AdminDao;
import com.exam.dao.HibernateDao;
import com.exam.dao.StudentDao;
import com.exam.model.Admin;
import com.exam.model.PageBean;
import com.exam.model.Student;

@Controller
public class UserController {
	private AdminDao adminDao;
	
	public AdminDao getAdminDao() {
		return adminDao;
	}
	@Resource
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	private StudentDao studentDao;
	
	public StudentDao getStudentDao() {
		return studentDao;
	}
	@Resource
	public void setStudentDao(StudentDao studentDao) {
		this.studentDao = studentDao;
	}
	
	/*管理员登录验证*/
	@RequestMapping(value="login1" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView login1Post(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("login1");
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		System.out.println(username+"  "+password);
		HttpSession session = request.getSession(true);
		Admin admin = adminDao.getUserByName(username);
		if(password.equals(admin.getPassword()))
		{
			int role = admin.getRole();
			session.setAttribute("user",admin);
			session.setAttribute("role",3);
			session.setAttribute("aut",role);
			return new ModelAndView("admin_homepage","login_result","success");
		}
		return new ModelAndView("login1","login_result","fail");
	}
	
	/*管理员登出*/
	@RequestMapping(value="logout1" ,method=RequestMethod.POST)
	@ResponseBody
	public void logout1(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("logout1");
		HttpSession session = request.getSession();
		session.invalidate();
	}
	
	/*学生登录验证*/
	@RequestMapping(value="login" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView loginPost(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("login");
		Double user_id = Double.parseDouble((request.getParameter("user_id")));
		String password = request.getParameter("password");
		System.out.println(user_id+"   "+password);
		HttpSession session = request.getSession(true);
		Student stu = studentDao.getUserByUser_Id(user_id);
		if(password.equals(stu.getPassword()))
		{
			session.setAttribute("user", stu);
			return new ModelAndView("stu_homepage","login_result","success");
		}
		return new ModelAndView("login","login_result","fail");
	}
	
	/*学生登出*/
	@RequestMapping(value="logout" ,method=RequestMethod.POST)
	@ResponseBody
	public void logout(HttpServletRequest request, HttpServletResponse response)
	{
		System.out.println("logout");
		HttpSession session = request.getSession();
		session.invalidate();
	}
	
	/*添加管理员*/
	@RequestMapping(value="add_admin" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView add_admin(HttpServletRequest request, HttpServletResponse response)
	{
		String username=request.getParameter("username");
		Admin admin = adminDao.getUserByName(username);
		if(admin.getUsername()==null)
		{
			String password=request.getParameter("password");
			String name=request.getParameter("name");
			int role=Integer.parseInt(request.getParameter("role"));
			admin.setUsername(username);
			admin.setPassword(password);
			admin.setName(name);
			admin.setRole(role);
			adminDao.save(admin);
			return new ModelAndView("admin_info","add_admin_result","success");
		}
		else
		{
			return new ModelAndView("admin_info","add_admin_result","repeat");
		}
	 }
	
	/*得到所有管理员信息*/
	@RequestMapping(value="get_alladmin" ,method=RequestMethod.POST)
	@ResponseBody
	public List<Admin> getAllAdmin()
	{
		return adminDao.get_admin();
		 
	}
	/*得到管理员信息*/
	@RequestMapping(value="get_admin" ,method=RequestMethod.POST)
	@ResponseBody
	public List<Admin> getAdmin(HttpServletRequest request, HttpServletResponse response)
	{
		String condition = request.getParameter("condition");
		return adminDao.getUser(condition);
		
	}
	
	/*修改管理员信息*/
	@RequestMapping(value="update_admin" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView update_admin(HttpServletRequest request, HttpServletResponse response)
	{
		String username=request.getParameter("username");
		Admin admin = adminDao.getUserByName(username);
		if(admin.getUsername()!= null)
		{
			System.out.println("update");
			String password=request.getParameter("password");
			String name=request.getParameter("name");
			int role=Integer.parseInt(request.getParameter("role"));
			admin.setUsername(username);
			admin.setPassword(password);
			admin.setName(name);
			admin.setRole(role);
			adminDao.update(admin);
			return new ModelAndView("admin_info","update_admin_result","success");
		}
		else
		{
			return new ModelAndView("admin_info","update_admin_result","fail");
		}
	}
	
	/*删除管理员*/
	@RequestMapping(value="delete_admin" ,method=RequestMethod.POST)
	@ResponseBody
	public JSONArray delete_admin(HttpServletRequest request, HttpServletResponse response)
	{
		String username=request.getParameter("username");
		Admin admin = adminDao.getUserByName(username);
		adminDao.delete(admin);
		HashMap<String, String> result =new HashMap<String, String>();
		result.put("delete_admin_result", "success");
		JSONArray json = JSONArray.fromObject(result);
		return json;
	}
	
	/*添加学生*/
	@RequestMapping(value="add_stu" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView add_stu(HttpServletRequest request, HttpServletResponse response)
	{
		Double user_id = Double.parseDouble((request.getParameter("user_id")));
		Student stu = studentDao.getUserByUser_Id(user_id);
		if(stu.getName() == null)
		{
			String password = request.getParameter("password");
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			Double tel = Double.parseDouble(request.getParameter("tel"));
			String email = request.getParameter("email");
			Double qq = Double.parseDouble(request.getParameter("qq"));
			stu.setUser_id(user_id);
			stu.setPassword(password);
			stu.setName(name);
			stu.setSex(sex);
			stu.setTel(tel);
			stu.setEmail(email);
			stu.setQq(qq);
			studentDao.save(stu);
			return new ModelAndView("admin_stu_info","add_stu_result","success");
		}
		else
		{
			return new ModelAndView("admin_stu_info","add_stu_result","fail");
		}
	 }
	
	/*分页得到所有学生信息*/
	@RequestMapping(value="get_allstu" ,method=RequestMethod.POST)
	@ResponseBody
	public PageBean getAllStu(HttpServletRequest request, HttpServletResponse response)
	{
		PageBean pageBean = new PageBean();
		Integer currentPage = Integer.parseInt(request.getParameter("currentPage"));
		Integer pageSize = Integer.parseInt(request.getParameter("pageSize"));
		int count = studentDao.getCount();
		int totalPage = (int)Math.ceil((double)count/pageSize);
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setCount(count);
		pageBean.setTotalPage(totalPage);
		int begin = (currentPage - 1)*pageSize;
		List<Student> list = studentDao.get_allstu(begin,pageSize);
		pageBean.setList(list);
		return pageBean;		 
	}
	
	/*搜索学生信息*/
	@RequestMapping(value="search_stu" ,method=RequestMethod.POST)
	@ResponseBody
	public PageBean searchStu(HttpServletRequest request, HttpServletResponse response)
	{
		PageBean pageBean = new PageBean();
		String condition = request.getParameter("condition");
		Integer currentPage = Integer.parseInt(request.getParameter("currentPage"));
		Integer pageSize = Integer.parseInt(request.getParameter("pageSize"));
		int count = studentDao.searchCount(condition);
		int totalPage = (int)Math.ceil((double)count/pageSize);
		pageBean.setCurrentPage(currentPage);
		pageBean.setPageSize(pageSize);
		pageBean.setCount(count);
		pageBean.setTotalPage(totalPage);
		int begin = (currentPage - 1)*pageSize;
		List<Student> list = studentDao.search_stu(condition,begin,pageSize);
		pageBean.setList(list);
		return pageBean;		
	}
	
	/*修改学生信息*/
	@RequestMapping(value="admin_update_stu" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView admin_update_stu(HttpServletRequest request, HttpServletResponse response)
	{
		Double user_id = Double.parseDouble(request.getParameter("user_id"));
		Student stu = studentDao.getUserByUser_Id(user_id);
		if(stu.getName()!= null)
		{
			String password = request.getParameter("password");
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			Double tel = Double.parseDouble(request.getParameter("tel"));
			String email = request.getParameter("email");
			Double qq = Double.parseDouble(request.getParameter("qq"));
			stu.setUser_id(user_id);
			stu.setPassword(password);
			stu.setName(name);
			stu.setSex(sex);
			stu.setTel(tel);
			stu.setEmail(email);
			stu.setQq(qq);
			studentDao.update(stu);
			return new ModelAndView("admin_stu_info","update_stu_result","success");
		}
		else
		{
			return new ModelAndView("admin_stu_info","update_stu_result","fail");
		}
	}
	
	/*删除学生*/
	@RequestMapping(value="delete_stu" ,method=RequestMethod.POST)
	@ResponseBody
	public JSONArray delete_stu(HttpServletRequest request, HttpServletResponse response)
	{
		Double user_id = Double.parseDouble(request.getParameter("user_id"));
		Student stu = studentDao.getUserByUser_Id(user_id);
		studentDao.delete(stu);
		HashMap<String, String> result =new HashMap<String, String>();
		result.put("delete_stu_result", "success");
		JSONArray json = JSONArray.fromObject(result);
		return json;
	}
	
	/*得到学生*/
	@RequestMapping(value="get_stu" ,method=RequestMethod.POST)
	@ResponseBody
	public Student get_stu(HttpServletRequest request, HttpServletResponse response)
	{
		Double user_id = Double.parseDouble(request.getParameter("user_id"));
		Student stu = studentDao.getUserByUser_Id(user_id);
		return stu;
	}
	
	/*修改个人信息*/
	@RequestMapping(value="update_stu" ,method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView update_stu(HttpServletRequest request, HttpServletResponse response)
	{
		Double user_id = Double.parseDouble((request.getParameter("user_id")));
		Student stu = studentDao.getUserByUser_Id(user_id);
		if(stu.getName()!= null)
		{
			String password = request.getParameter("password");
			String name = request.getParameter("name");
			String sex = request.getParameter("sex");
			Double tel = Double.parseDouble(request.getParameter("tel"));
			String email = request.getParameter("email");
			Double qq = Double.parseDouble(request.getParameter("qq"));
			stu.setUser_id(user_id);
			stu.setPassword(password);
			stu.setName(name);
			stu.setSex(sex);
			stu.setTel(tel);
			stu.setEmail(email);
			stu.setQq(qq);
			studentDao.update(stu);
			return new ModelAndView("stu_info","update_stu_result","success");
		}
		else
		{
			return new ModelAndView("stu_info","update_stu_result","fail");
		}
	}
}
