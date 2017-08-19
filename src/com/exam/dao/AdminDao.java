package com.exam.dao;

import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.exam.model.Admin;
import com.exam.model.Student;
import com.exam.dao.HibernateDao;

@Repository
public class AdminDao {
	HibernateDao hibernateDao;

	public HibernateDao getHibernateDao() {
		return hibernateDao;
	}
	@Resource
	public void setHibernateDao(HibernateDao hibernateDao) {
		this.hibernateDao = hibernateDao;
	}
	
    //增加管理员
	public  void save(Admin admin) {
		hibernateDao.getHibernateTemplate().save(admin);		
	}
	
	//根据用户名获取用户
	public Admin getUserByName(String username) {
		Admin admin = new Admin();
		String queryString="from Admin a where a.username = ?";		
		List<Admin> list = hibernateDao.getHibernateTemplate().find(queryString, username);
		Iterator iterator = list.iterator();
		
		while(iterator.hasNext()) {
			
			admin = (Admin)iterator.next();
			
		};
		return admin;
	}
	
	//根据模糊用户名获取用户
	public List<Admin> getUser(String condition) {
		String hql = "from Admin a where a.username like ? or a.name like ?";		
		List<Admin> admin = hibernateDao.getHibernateTemplate().find(hql,new String[]{"%"+condition+"%","%"+condition+"%"});		
		return admin;
	}
	
	/*得到所有管理员*/
	public List<Admin> get_admin()
	{
		List<Admin> admin = hibernateDao.getHibernateTemplate().find("from Admin");
		return admin;
	}	
	
	/*修改管理员信息*/
	public void update(Admin admin)
	{
		hibernateDao.getHibernateTemplate().update(admin);
	}
	
	/*删除管理员*/
	public void delete(Admin admin)
	{
		hibernateDao.getHibernateTemplate().delete(admin);
	}

}
