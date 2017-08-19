package com.exam.dao;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.exam.model.Exam;



@Repository
public class ExamDao {
	HibernateDao hibernateDao;

	public HibernateDao getHibernateDao() {
		return hibernateDao;
	}
	@Resource
	public void setHibernateDao(HibernateDao hibernateDao) {
		this.hibernateDao = hibernateDao;
	}
	
    //增加考试
	public  void save(Exam exam) {
		hibernateDao.getHibernateTemplate().save(exam);		
	}
	
	//根据考试名称获取考试
	public Exam getExamByName(String exam_name) {
	
		Exam exam = new Exam();
		
		String queryString="from Exam a where a.exam_name=?";
		
		List<Exam> list = hibernateDao.getHibernateTemplate().find(queryString, exam_name);
		
		Iterator iterator = list.iterator();
		
		while(iterator.hasNext()) {
			
			exam = (Exam)iterator.next();
			
		};
		return exam;
	}
	
	/*学生得到所有考试*/
	public List<Exam> stu_get_exam(Date date)
	{
		String hql = "from Exam e where ? between e.entertime and e.endtime";
		List<Exam> exam = hibernateDao.getHibernateTemplate().find(hql,date);
		return exam;
	}
	
	/*管理员得到所有考试*/
	public List<Exam> get_exam()
	{
		String hql = "from Exam";
		List<Exam> exam = hibernateDao.getHibernateTemplate().find(hql);
		return exam;
	}
	
	/*搜索考试*/
	public List<Exam> search_exam(String condition)
	{
		String hql = "from Exam a where a.exam_name like ?";
		List<Exam> exam = hibernateDao.getHibernateTemplate().find(hql,"%"+condition+"%");
		return exam;
	}
	
	/*得到单个考试*/
	public Exam getExamById(Integer id)
	{
		return hibernateDao.getHibernateTemplate().get(Exam.class, id);
	}
	
	/*修改考试信息*/
	public void update(Exam exam)
	{
		hibernateDao.getHibernateTemplate().update(exam);
	}
	
	/*删除考试*/
	public void delete(Exam exam)
	{
		hibernateDao.getHibernateTemplate().delete(exam);
	}
}
