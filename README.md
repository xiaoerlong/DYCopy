# DYCopy
使用swift仿写斗鱼TV

项目采用MVC+swift+cocoapod,仿写斗鱼TV


1.从斗鱼APP中获取资源文件
连接iTunes，从应用中获取资源文件 http://www.jianshu.com/p/469f459c0db0
但是有些资源文件被存放在Assets.car文件中，所以需要通过 https://github.com/xiaoerlong/cartool 这个第三方库来获取

2.数据来源
在我做这个项目的时候，通过Charles已经抓不到数据了，所以在网上找了一个之前别人写的，目前还可以用 http://www.cnblogs.com/jiaoxiangjie/p/6748039.html

3.开发工具
Xcode9+swift3

4.项目架构
由于个人能力有限，所以使用的是最常用的MVC，以Alamofire+SwiftyJSON+ObjectMapper来获取数据及模型化，刷新使用的是ESPullToRefresh，目前的主要功能是首页和直播页面的展示，以及本地直播

5.核心
核心的地方是直播这里是我在做直播时候的参考资料

采集过程使用框架 AVFoundation
摄像头采集和编码参考 http://www.jianshu.com/p/8423724dffc1
GPUIImage https://github.com/BradLarson/GPUImage

一个集成编码和推流的框架 https://github.com/LaiFengiOS/LFLiveKit
RTMP协议介绍 http://blog.csdn.net/shangmingyang/article/details/50837852

本地搭建RTMP服务器  nginx+rtmp  http://www.jianshu.com/p/cefbfb37c1e1

播放端 IJKPlayer的使用   http://www.jianshu.com/p/2215c8be03a8

具体的可以看demo
由于自己水平有限，所以代码写的很差，希望谅解。
