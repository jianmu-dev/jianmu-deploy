# jianmu-deploy

## Docker部署

#### 系统需求

1. Docker 19.30以上
2. Docker-compose 1.29.2以上
3. Centos 7.4.1708以上
4. 需要Docker Engine端口对外开放

#### 介绍
jianmu服务部署

#### 使用说明

1.  wget https://gitee.com/jianmu-dev/jianmu-deploy/raw/master/docker-compose.yml
2.  docker-compose up -d启动

#### 访问平台
地址：[http://127.0.0.1](http://127.0.0.1)    
账号：admin/123456

#### ubuntu部署
若要在ubuntu上部署，需要自行修改docker-cmpose中ci-server的docker.sock路径，以及确保有相应权限，或修改docker-compose中ci-server的EMBEDDED_DOCKER-WORKER_DOCKER-HOST为tcp的socket，具体可参考docker-compose-ubuntu.yml.sample

## k8s部署

#### 使用说明

1.  wget https://gitee.com/jianmu-dev/jianmu-deploy/raw/master/kubernetes-yaml
2.  kubectl apply -f kubernetes-yaml启动

#### 访问平台
地址: node节点ip:30180
账号: admin/123456