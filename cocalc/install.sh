 docker pull sagemathinc/cocalc-docker
 docker run --name=cocalc -d -v ~/cocalc:/projects -p 443:443 sagemathinc/cocalc-docker

 https://gitee.com/microcloud/cocalc-docker

 docker exec -it cocalc bash
root@931045eda11f:/# make-user-admin wstein@gmail.com

https://192.168.188.153/admin

 
