### 说明

使用 `Docker` 搭建的 `PHP` `Nginx` 运行环境。

目前 `php/Old` 这是编译版本并且通过本地包安装，由于众所周知的[国际网络]问题和不稳定因素，这个采用的是先将需要需要的包下载到本地，然后在安装本地包，维护起来比较麻烦，已经暂停维护。

### 如何使用

1. nginx 配置
2. 需要 `docker-compose` 工具

### Nginx配置

1. 在目录 `nginx/conf.d/` 下新建文件 `nginx.conf`，并添加 `server` 配置，例如下：.
2. 
```
   server {
    listen       80;
    server_name  localhost;
    root 	     /app;
    autoindex    on;

   # location / {
       # try_files $uri $uri/ /index.php?$query_string;
   # }

   location ~ \.php$ {
       fastcgi_pass    php:9000;
       fastcgi_index   index.php;
       fastcgi_param   SCRIPT_FILENAME 		$document_root$fastcgi_script_name;
       include         fastcgi_params;
   }
   ```

- `"/app"` 是容器内部已经约定好的主目录，所有的项目都在此目录下
- `php:9000 "php"` 是在 docker-compose 配置中设置的名称


### docker-compose.yml

需要修改 `nginx` 和 `php` 中的 `volumes`

  > 举例：
  >
  > 你现在的项目目录是 `/wwwroot/sites`
  >
  > 那么就将 `volumes` 中设置为：
  >
  > `/wwwroot/sites:/app:rw`
  >
  > 需要修改的就是 `：` [冒号]之前的内容
  >
  > 它的意思是：将你本机的这个目录 `/wwwroot/sites` 映射到容器内部 `/app` 目录

`dns` 设置为公司内部`DNS`，没有就删除此项。

### Windows

> 在 `windows_software` 目录中有 `docker-compose` 工具，另外你还需要下载 `windows docker` 这个太大了，就不放到这里，你需要先安装它们
>
> 下载地址`https://download.docker.com/win/stable/Docker%20for%20Windows%20Installer.exe` 

### 启动

在当前目录下输入命令 `docker-compose up `

> `docker-compose up `  如果是第一次 `up` ， 需要耐心等待。
>
> 一切就绪之后，你会看到类似下面的信息：
>
> ```bash
> Starting wedocker_redis_1     ... done
> Starting wedocker_beanstalk_1 ... done
> Starting wedocker_php_1       ... done
> Starting wedocker_nginx_1     ... done
> ```
>
> 并且命令行处于占用的状态。
>
> 如果你想后台启动，你需要执行：
>
> `docker-composer up -d` 命令

### 运行

浏览器中输入 `localhost` 或者 `127.0.01` 将能看到你配置的目录文件。