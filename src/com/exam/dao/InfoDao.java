package com.exam.dao;

import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.stereotype.Component;

import com.exam.model.Admin;
import com.exam.model.Info;
import com.exam.model.Student;


@Component
public class InfoDao {
	HibernateDao hibernateDao;

	public HibernateDao getHibernateDao() {
		return hibernateDao;
	}
	@Resource
	public void setHibernateDao(HibernateDao hibernateDao) {
		this.hibernateDao = hibernateDao;
	}
    
	//增加信息
	public  void save(Info info) {
		hibernateDao.getHibernateTemplate().save(info);		
	}
	
	/*得到所有信息数*/
	public int getCount() {
		List<Long> list = hibernateDao.getHibernateTemplate().find("select count(*) from Info");
		if(list!=null) {
			return list.get(0).intValue();
		}
		return 0;
	}
	
	/*得到所有合格人数*/
	public int getLevelCount() {
		String level;
		int levelCount = 0;
		List<String> list = hibernateDao.getHibernateTemplate().find("select level from Info");
		Iterator iterator = list.iterator();		
		while(iterator.hasNext()) {			
			level = (String)iterator.next();
			if("合格".equals(level)) {
				levelCount ++;
			}
		};
		return levelCount;
	}
	
	
	/*分页得到所有信息*/
	@SuppressWarnings({ "unchecked" })
	public List<Info> get_allinfo(final int begin,final int pageSize)
	{
		final String hql="from Info order by score desc";
		List<Info> list= hibernateDao.getHibernateTemplate().executeFind(new HibernateCallback<Object>() {
			public List<Info> doInHibernate(Session session) throws HibernateException,
					SQLException {
				 			org.hibernate.Query query=session.createQuery(hql);
				 			query.setFirstResult(begin);
				 			query.setMaxResults(pageSize);
				 			List<Info> result = query.list();				 			
				 			return result;
			}
			
		});
		return list;
	}
	
	/*得到搜索信息数*/
	public int searchCount(String condition) {
		String hql;
		List<Long> list;
		if(!isNumeric(condition))
		{
			hql = "select count(*) from Info i where i.name like ? or i.exam_name like ?";		
		    list = hibernateDao.getHibernateTemplate().find(hql,new Object[]{"%"+condition+"%","%"+condition+"%"});
			if(list!=null) {
				return list.get(0).intValue();
			}
		}
		else
		{
			hql = "select count(*) from Info i where YEAR(i.time) = ?";		
			list = hibernateDao.getHibernateTemplate().find(hql,Integer.parseInt(condition));
			if(list!=null) {
				return list.get(0).intValue();
			}
		}
		return 0;
	}
		
	/*搜索所有合格人数*/
	public int searchLevelCount(String condition) {
		String level;
		int levelCount = 0;
		List<String> list;
		String hql;
		if(!isNumeric(condition))
		{
			hql = "select level from Info i where i.name like ? or i.exam_name like ?";		
		    list = hibernateDao.getHibernateTemplate().find(hql,new Object[]{"%"+condition+"%","%"+condition+"%"});
			Iterator iterator = list.iterator();		
			while(iterator.hasNext()) {			
				level = (String)iterator.next();
				if("合格".equals(level)) {
					levelCount ++;
				}
			};
			return levelCount;
		}
		else
		{
			hql = "select level from Info i where YEAR(i.time) = ?";		
			list = hibernateDao.getHibernateTemplate().find(hql,Integer.parseInt(condition));
			Iterator iterator = list.iterator();		
			while(iterator.hasNext()) {			
				level = (String)iterator.next();
				if("合格".equals(level)) {
					levelCount ++;
				}
			};
			return levelCount;
		}
	}
	
	/*搜索信息*/
	@SuppressWarnings({ "unchecked" })
	public List<Info> search_info(final String condition,final int begin,final int pageSize)
	{
		List<Info> info;
		if(!isNumeric(condition))
		{
			final String hql = "from Info i where i.name like ? or i.exam_name like ? order by score desc";		
			info= hibernateDao.getHibernateTemplate().executeFind(new HibernateCallback<Object>() {
				public List<Info> doInHibernate(Session session) throws HibernateException,
						SQLException {
					 			org.hibernate.Query query=session.createQuery(hql);
					 			query.setParameter(0,"%"+condition+"%");
					 			query.setParameter(1,"%"+condition+"%");
					 			query.setFirstResult(begin);
					 			query.setMaxResults(pageSize);
					 			List<Info> result = query.list();				 			
					 			return result;
				}			
			});
			return info;
		}
		else
		{
			final String hql = "from Info i where YEAR(i.time) = ? order by score desc";		
			info= hibernateDao.getHibernateTemplate().executeFind(new HibernateCallback<Object>() {
				public List<Info> doInHibernate(Session session) throws HibernateException,
						SQLException {
					 			org.hibernate.Query query=session.createQuery(hql);
					 			query.setParameter(0,Integer.parseInt(condition));
					 			query.setFirstResult(begin);
					 			query.setMaxResults(pageSize);
					 			List<Info> result = query.list();				 			
					 			return result;
				}			
			});
			return info;
		}
	}
	
	/*得到单个信息*/
	public Info getInfoById(Integer Id)
	{
		return hibernateDao.getHibernateTemplate().get(Info.class, Id);
	}
	
	//根据学号获取学生考试信息
	public List<Info> getInfoByUser_Id(Double user_id) {
		String queryString="from Info i where i.user_id=?";		
		List<Info> info = hibernateDao.getHibernateTemplate().find(queryString, user_id);		
		return info;
	}
	
	/*修改信息*/
	public void update(Info info)
	{
		hibernateDao.getHibernateTemplate().update(info);
	}
	
	/*删除信息*/
	public void delete(Info info)
	{
		hibernateDao.getHibernateTemplate().delete(info);
	}
	
	public boolean isNumeric(String str){ 
		   Pattern pattern = Pattern.compile("[0-9]*"); 
		   Matcher isNum = pattern.matcher(str);
		   if( !isNum.matches() ){
		       return false; 
		   } 
		   return true; 
	}
}
