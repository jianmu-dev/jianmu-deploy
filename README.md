# jianmu-deploy

#### 介绍
jianmu服务部署示例

#### 使用说明

1.  根据需求自行修改nginx配置文件
2.  根据需求自行修改docker-compose.yml文件
3.  自行下载jianmu-ui项目代码并按照说明编译，编译后的文件目录映射到nginx容器内的/home/dist目录
4.  docker-compose up -d启动

系统登录的默认用户名密码为admin / 123456

如需更换密码可以使用JIANMU_API_ADMINPASSWD环境变量覆盖
