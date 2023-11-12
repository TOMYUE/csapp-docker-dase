# DaSE CSAPP VSCode on Docker

> CSAPP Dockerfile for DaSE



## 使用方法

### 安装本地的docker desktop

下载链接：https://www.docker.com/products/docker-desktop/，根据您使用的操作系统选择对应的版本下载，如下图所示。

![image-20231112131710924](./README.assets/image-20231112131710924.png)

下载完后应该可以看到长成这样很可爱的小🐳鲸鱼的图标，然后让我们点击它。点击之后，docker的启动会需要一点时间，所以给点时间给我们可爱的小鲸鱼。<img src="./README.assets/image-20231112132455799.png" alt="image-20231112132455799" style="zoom: 33%;" />

当你看到docker desktop的左下角的小鲸鱼🐳图标变成绿色的时候，就代表它已经启动了，如下图所示。【括号里的内容可以略过：变为绿色代表docker dameon守护进程已经启动，相当于你手动在本机的命令行中输入了`systemctl start docker`】![image-20231112133036586](./README.assets/image-20231112133036586.png)

好，那到目前为止，我们安装docker小鲸鱼🐳的过程就结束了，接下来我们去把小鲸鱼🐳的食物（dockerfile）给下载下来吧，见下一小节。



### 下载我们编写的Dockerfile并运行

#### 命令：

```bash
> git clone https://github.com/TOMYUE/csapp-docker-dase.git csapp-docker
> cd csapp-docker
> docker build -t csapp . #这条命令会让docker默认按照当前目录下的Dockerfile启动Docker容器
```

#### 命令解释：

1. 克隆仓库到本地：`git clone https://github.com/TOMYUE/csapp-docker-dase.git` 或者如果你配置过Github的ssh key的话使用`git clone git@github.com:TOMYUE/csapp-docker-dase.git`，在不能科学上网的情况下，ssh也是可以很快速的使用的，没配置过的话推荐配置一下，因为仅依靠https下载是个玄学事件。同时这份clone任务不会很快能执行完，因为其中包含了一份我事先加入的cpptools-linux-1.17.5.vsix的给vscode code_server的插件，这份插件比较大所以麻烦各位耐心了。

![Screenshot 2023-11-12 at 13.33.22](./README.assets/Screenshot 2023-11-12 at 13.33.22.png)![image-20231112134915270](./README.assets/image-20231112134915270.png)![image-20231112135014717](./README.assets/image-20231112135014717.png)



2. 构建并运行docker: `docker built -t csapp .`
