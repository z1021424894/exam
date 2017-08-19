package com.exam.dao;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.exam.model.Student;
import com.exam.dao.HibernateDao;

@Component
public class StudentDao {
	HibernateDao hibernateDao;

	public HibernateDao getHibernateDao() {
		return hibernateDao;
	}
	@Resource
	public void setHibernateDao(HibernateDao hibernateDao) {
		this.hibernateDao = hibernateDao;
	}
	
    //增加学生
	public  void save(Student stu) {
		hibernateDao.getHibernateTemplate().save(stu);		
	}
	
	//根据学号获取学生
	public Student getUserByUser_Id(Double user_id) {
		Student stu = new Student();
		
		String queryString="from Student s where s.user_id=?";
		
		List<Student> list = hibernateDao.getHibernateTemplate().find(queryString, user_id);
		
		Iterator iterator = list.iterator();
		
		while(iterator.hasNext()) {
			
			stu = (Student)iterator.next();
			
		};
		return stu;
	}
		
	/*分页得到所有学生*/
	@SuppressWarnings({ "unchecked" })
	public List<Student> get_allstu(final int begin,final int pageSize)
	{
		final String hql="from Student";
		List<Student> list= hibernateDao.getHibernateTemplate().executeFind(new HibernateCallback<Object>() {
			public List<Student> doInHibernate(Session session) throws HibernateException,
					SQLException {
				 			org.hibernate.Query query=session.createQuery(hql);
				 			query.setFirstResult(begin);
				 			query.setMaxResults(pageSize);
				 			List<Student> result = query.list();				 			
				 			return result;
			}
			
		});
		return list;
	}
	
	/*得到所有学生数*/
	public int getCount() {
		List<Long> list = hibernateDao.getHibernateTemplate().find("select count(*) from Student");
		if(list!=null) {
			return list.get(0).intValue();
		}
		return 0;
	}
	
	/*得到搜索学生数*/
	public int searchCount(String condition) {
		String hql = "select count(*) from Student s where s.name like ? or s.sex like ?";
		List<Long> list = hibernateDao.getHibernateTemplate().find(hql,new String[]{"%"+condition+"%","%"+condition+"%"});
		if(list!=null) {
			return list.get(0).intValue();
		}
		return 0;
	}
	
	/*搜索学生*/
	@SuppressWarnings({ "unchecked" })
	public List<Student> search_stu(final String condition,final int begin,final int pageSize)
	{
		final String hql="from Student s where s.name like ? or s.sex like ?";
		List<Student> list= hibernateDao.getHibernateTemplate().executeFind(new HibernateCallback<Object>() {
			public List<Student> doInHibernate(Session session) throws HibernateException,
					SQLException {
				 			org.hibernate.Query query=session.createQuery(hql);
				 			query.setParameter(0,"%"+condition+"%");
				 			query.setParameter(1,"%"+condition+"%");
				 			query.setFirstResult(begin);
				 			query.setMaxResults(pageSize);
				 			List<Student> result = query.list();				 			
				 			return result;
			}			
		});
		return list;
	}
	
	/*得到单个学生*/
	public Student getUserById(Integer Id)
	{
		return hibernateDao.getHibernateTemplate().get(Student.class, Id);
	}
	
	/*修改学生信息*/
	public void update(Student stu)
	{
		hibernateDao.getHibernateTemplate().update(stu);
	}
	
	/*删除学生*/
	public void delete(Student stu)
	{
		hibernateDao.getHibernateTemplate().delete(stu);
	}

}
