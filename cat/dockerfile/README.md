* cat的数据库参数配置是硬编码到xml文件的，没有通过环境变量获取，所有搞自动化docker配参数很麻烦

* 必须要有的目录 /data/appdatas/cat和/data/applogs/cat
* 必须要有的文件 /data/appdatas/cat/client.xml、/data/appdatas/cat/datasources.xml
* * datasources.xml是数据库连接信息，不用改变的话就无需修改
* * client.xml和server.xml两个文件里，有多少台服务器，就要写多少台服务器的地址上去

