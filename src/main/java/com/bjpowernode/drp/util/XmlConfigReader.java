package com.bjpowernode.drp.util;

import java.io.InputStream;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * ���õ���ģʽ����sys-config.xml�ļ�
 * @author ddh
 *
 */
public class XmlConfigReader {
//  ����ʽ(Ԥ�ȼ���)
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
			 * ��ȡjdbc������
			 */
			Document doc = reader.read(in);
			Element driverNameElt = (Element) doc.selectObject("/config/db-info/driver-name");
			Element urlElt = (Element)doc.selectObject("/config/db-info/url");
			Element userNameElt = (Element)doc.selectObject("/config/db-info/user-name");
			Element passwordElt = (Element)doc.selectObject("/config/db-info/password");
			
			/**
			 * �������õ�jdbcConfig������
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
	 * ����jdbcConfig����
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
