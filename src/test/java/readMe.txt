v1.0
	1、将html拷贝到web项目中
	2、建立DbUtil
	3、将Oracle jdbc驱动拷贝到WEB-INF/lib下
	4、建立xml文件sys-config.xml
	5、将dom4j相关的jar拷贝到WEB-INF/lib下
		* dom4j-1.6.1.jar
		* jaxen-1.1-beta-6.jar
	6、采用dom4j完成sys-config.xml配置文件的读取
	
v1.1
	* 完成用户添加业务逻辑方法实现
	
v1.2
	* 采用javascript完成用户添加合法性检查
	
v1.3
	* 添加用户	
	* 设置请求字符集
	
v1.4
	* 作业：判断用户添加电话号码，必须全部为数字，采用正则表达式
	* 作业：完成添加用户是否重复的判断
	* 保持页面数据
	
v1.5
	* 采用Ajax完成用户代码是否重复的判断
	
v1.6
	* 采用Ajax完成用户代码是否重复的判断(采用匿名函数)	

v1.7
	* 完成用户查询页面控制(选中所有的checkedbox)	
	
v1.8
	* 完成分页业务逻辑部分实现
	* 封装PageModel对象
	* 将每页的数据输出到jsp	
	* 完成整个分页查询
	
v1.9
	* PageModel采用泛型封装	
	
v2.0
	* 完成全部用户查询页面控制
	* 定义修改用户和删除用户方法
	
v2.1
	* 完成用户修改
	
v2.2
	* 完成用户删除	
	
v2.3
	* 采用Filter设置字符集	
