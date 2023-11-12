# DaSE CSAPP VSCode on Docker

> CSAPP Dockerfile for DaSE



## 使用方法

### 安装本地的docker desktop

下载链接：https://www.docker.com/products/docker-desktop/，根据您使用的操作系统选择对应的版本下载，如下图所示。

![image-20231112131710924](./README.assets/image-20231112131710924.png)

下载完后应该可以看到长成这样很可爱的小🐳鲸鱼的图标，然后让我们点击它。点击之后，docker的启动会需要一点时间，所以给点时间给我们可爱的小鲸鱼。<img src="./README.assets/image-20231112132455799.png" alt="image-20231112132455799" style="zoom: 33%;" />

当你看到docker desktop的左下角的小鲸鱼🐳图标变成绿色的时候，就代表它已经启动了，如下图所示。【括号里的内容可以略过：变为绿色代表docker dameon守护进程已经启动，相当于你手动在本机的命令行中输入了`systemctl start docker`】![image-20231112133036586](./README.assets/image-20231112133036586.png)

好，那到目前为止，我们安装docker小鲸鱼🐳的过程就结束了，接下来我们去把小鲸鱼🐳的食物（dockerfile）给下载下来吧，见后面的小节。



## 安装Git Large File Storage

下载指导链接：https://git-lfs.com/，Github官方教程链接：https://docs.github.com/en/repositories/working-with-files/managing-large-files/installing-git-large-file-storage

![Screenshot 2023-11-12 at 16.06.02](./README.assets/Screenshot 2023-11-12 at 16.06.02.png)

因为众所周知的原因，我们下载某些软件总是会面临中断、连不上、网络错误等失败，所以我们事先把要用Docker中要使用到的软件包下载下来并放到了Github 仓库中，但是由于这个包有97.3MB的大小，属于大型文件，所以在Github 仓库中上传和下载时都会有一些不同的地方，比如原本的`git clone`指令就要变成`git lfs clone`。所以为了能够支持大型文件的下载克隆，我们需要实现安装一个git-lfs如上图的网址所示，如何下载会根据你的电脑操作系统不同而有所区别，上图为我的mac电脑的安装方式。



### 下载我们编写的Dockerfile并运行

#### 命令：

```bash
> git lfs install # 使用此指令确认你已经安装了git lfs
> git lfs clone https://github.com/TOMYUE/csapp-docker-dase.git csapp-docker
> cd csapp-docker
> docker build -t csapp . #这条命令会让docker默认按照当前目录下的Dockerfile启动Docker容器
```

#### 命令解释：

1. 克隆仓库到本地：`git lfs clone https://github.com/TOMYUE/csapp-docker-dase.git` 或者如果你配置过Github的ssh key的话使用`git lfs clone git@github.com:TOMYUE/csapp-docker-dase.git`，在不能科学上网的情况下，ssh也是可以很快速的使用的，没配置过的话推荐配置一下，因为仅依靠https下载是个玄学事件。同时这份clone任务不会很快能执行完，因为其中包含了一份我事先加入的cpptools-linux-1.17.5.vsix的给vscode code_server的插件，这份插件比较大所以麻烦各位耐心了。

![Screenshot 2023-11-12 at 13.33.22](./README.assets/Screenshot 2023-11-12 at 13.33.22.png)![image-20231112134915270](./README.assets/image-20231112134915270.png)![image-20231112135014717](./README.assets/image-20231112135014717.png)



2. 构建并运行docker: `docker build -t csapp .`
