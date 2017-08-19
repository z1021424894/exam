package com.exam.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.exam.model.Ann;
import com.exam.model.Info;


@Repository
public class AnnDao {
	HibernateDao hibernateDao;

	public HibernateDao getHibernateDao() {
		return hibernateDao;
	}
	@Resource
	public void setHibernateDao(HibernateDao hibernateDao) {
		this.hibernateDao = hibernateDao;
	}
   
	//增加公告
	public  void save(Ann ann) {
		hibernateDao.getHibernateTemplate().save(ann);		
	}
	
	//根据公告标题获取公告
	public Ann getAnnByTitle(String title) {
	
		Ann ann = new Ann();
		
		String queryString="from Ann a where a.title=?";
		
		List<Ann> list = hibernateDao.getHibernateTemplate().find(queryString, title);
		
		Iterator iterator = list.iterator();
		
		while(iterator.hasNext()) {
			
			ann = (Ann)iterator.next();
			
		};
		return ann;
	}
	
	/*得到所有公告*/
	public List<Ann> get_ann()
	{
		List<Ann> ann = hibernateDao.getHibernateTemplate().find("from Ann order by time");
		return ann;
	}
	
	/*搜索公告*/
	public List<Ann> search_ann(String condition)
	{
		String hql;
		List<Ann> ann;
		System.out.println(condition);
		if(!hasNumeric(condition))
		{
			hql = "from Ann a where a.title like ? order by time";		
			ann = hibernateDao.getHibernateTemplate().find(hql,"%"+condition+"%");
			return ann;
		}
		else
		{
			SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = new Date();
			try {
				date = sdf.parse(condition);
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
			hql = "from Ann a where a.time <= ? order by time";		
			ann = hibernateDao.getHibernateTemplate().find(hql,date);
			return ann;
		}
	}
	
	/*得到单个公告*/
	public Ann getAnnById(Integer id)
	{
		return hibernateDao.getHibernateTemplate().get(Ann.class, id);
	}
	
	/*修改公告信息*/
	public void update(Ann ann)
	{
		hibernateDao.getHibernateTemplate().update(ann);
	}
	
	/*删除公告*/
	public void delete(Ann ann)
	{
		hibernateDao.getHibernateTemplate().delete(ann);
	}
	
	public boolean hasNumeric(String str){ 
		   Pattern pattern = Pattern.compile(".*\\d+.*"); 
		   Matcher hasNum = pattern.matcher(str);
		   if( !hasNum.matches() ){
		       return false; 
		   } 
		   return true; 
	}
}
