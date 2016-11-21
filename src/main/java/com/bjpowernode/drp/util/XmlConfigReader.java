package com.bjpowernode.drp.util;

import java.io.InputStream;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * 采用单例模式解析sys-config.xml文件
 * @author ddh
 *
 */
public class XmlConfigReader {
//  饿汉式(预先加载)
//	private static XmlConfigReader instance = new XmlConfigReader();
//	
//	private XmlConfigReader(){}
//	
//	public static XmlConfigReader getInstance(){
//		return instance;
//	}
	
	private static XmlConfigReader instance = null;
	
	private JdbcConfig jdbcConfig = new JdbcConfig();
	
	private XmlConfigReader(){
		SAXReader reader = new SAXReader();
		InputStream in = Thread.currentThread().getContextClassLoader().getResourceAsStream("sys-config.xml");
		
		try {
			/**
			 * 获取jdbc的配置
			 */
			Document doc = reader.read(in);
			Element driverNameElt = (Element) doc.selectObject("/config/db-info/driver-name");
			Element urlElt = (Element)doc.selectObject("/config/db-info/url");
			Element userNameElt = (Element)doc.selectObject("/config/db-info/user-name");
			Element passwordElt = (Element)doc.selectObject("/config/db-info/password");
			
			/**
			 * 设置配置到jdbcConfig对象中
			 */
			jdbcConfig.setDriverName(driverNameElt.getStringValue());
			jdbcConfig.setUrl(urlElt.getStringValue());
			jdbcConfig.setUserName(userNameElt.getStringValue());
			jdbcConfig.setPassword(passwordElt.getStringValue());
			
		} catch (DocumentException e) {
			e.printStackTrace();
		}
	}
	
	public static XmlConfigReader getInstall(){
		if(instance == null){
			instance = new XmlConfigReader();
		}
		return instance;
	}
	
	/**
	 * 返回jdbcConfig对象
	 * @return
	 */
	public JdbcConfig getJdbcConfig(){
		return jdbcConfig;
	}
	
	public static void main(String[] args){
		JdbcConfig jdbcConfig = XmlConfigReader.getInstall().getJdbcConfig();
		System.out.println(jdbcConfig.getDriverName());
		
	}
	
}
