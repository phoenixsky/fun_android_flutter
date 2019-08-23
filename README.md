### 基于Google的[Flutter](https://flutter.dev),利用[玩Android](https://wanandroid.com/)开放的API，打造的一款产品级开源App《[Fun Android](https://github.com/phoenixsky/fun_android_flutter)》

![logo,灵感来自2dimensions是个蓝色的F，自己挺喜欢，就down了下来，后来又翻了好久也没找到作者，如果侵权请联系我](https://upload-images.jianshu.io/upload_images/581515-f3a4b2e4392e63bf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/500) 

> Logo的里F，既代表了`Fun`也代表了`Flutter`.

![0-欢迎页面](http://blogimgs.phoenixsky.cn/2019-08-22-0-%E6%AC%A2%E8%BF%8E%E9%A1%B5%E9%9D%A2.gif)

![1-空中阁楼小.gif](https://upload-images.jianshu.io/upload_images/581515-54b8e7498039dc11.gif?imageMogr2/auto-orient/strip)

![2-页面状态骨架屏.gif](https://upload-images.jianshu.io/upload_images/581515-383fba933a0abbbc.gif?imageMogr2/auto-orient/strip)

![3-状态页小](https://upload-images.jianshu.io/upload_images/581515-b94dfce6335bc25d.gif?imageMogr2/auto-orient/strip)

![5-主题](http://blogimgs.phoenixsky.cn/2019-08-22-5-%E4%B8%BB%E9%A2%98.gif)

![4-字体](http://blogimgs.phoenixsky.cn/2019-08-22-4-%E5%AD%97%E4%BD%93.gif)

![6-收藏及跳转app.gif](https://upload-images.jianshu.io/upload_images/581515-6de61fdded963914.gif?imageMogr2/auto-orient/strip)

![7-移除收藏](http://blogimgs.phoenixsky.cn/2019-08-22-7-%E7%A7%BB%E9%99%A4%E6%94%B6%E8%97%8F.gif)


# 项目地址：
 > [https://github.com/phoenixsky/fun_android_flutter](https://github.com/phoenixsky/fun_android_flutter)

# 下载地址: 
  * Android：
  >  https://github.com/phoenixsky/fun_android_flutter/releases/download/0.1.0/FunAndroid_0.1.0.apk

  * iOS: 
  >  `审核被拒...待调整后上架`


借用群里水友的两句对白，在预览版出来时候

*   1A：话说`玩Android`的开源项目已经多如牛毛了。

*   3C：我想看最完美的。

感谢这位朋友对`FunAndroid`的认可。

关于App的主题风格，不是Google倡导的Material Design 也不是Apple的Cupertino Style。由于我是一个Android开发者，但又长期使用的iPhone，所以App的风格是两者的结合又夹杂了点私货。个人认为iOS版本的确实好看点。

我也不是大佬，刚玩Flutter不久，用音乐圈的方式来说，做了一些代码裁缝，加了点自己的思考。所以代码中存在的问题，请大家积极提[Issue](https://github.com/phoenixsky/fun_android_flutter/issues).

## 简单介绍一下项目结构

  ![项目结构1](https://upload-images.jianshu.io/upload_images/581515-74078e828d25fa7b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

  ![项目解构2](https://upload-images.jianshu.io/upload_images/581515-362f48ef83763615.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## Provider的简单实用方式
*  快速添加一个拥有下拉刷新,上拉加载更多的页面.比如开发一个`玩Android`首页列表页面
    1. 定义获取数据的接口
        ![Api](https://upload-images.jianshu.io/upload_images/581515-f60f2fceef71b2cc.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
    2. 编写ViewModel
        ![-w494](https://upload-images.jianshu.io/upload_images/581515-3ab778bafeb3b5b7.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
    3. 编写页面
        ![-w637](https://upload-images.jianshu.io/upload_images/581515-1aa9bd76f0e6f600.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 以上是Provider结合ViewModel的基础使用方式,考虑了App中会出现的比较全面的情况,希望大家一起探讨使用方式

> 另外再判断页面状态的时候,其实拿`model.viewState == ViewState.busy`会更严谨一点.为了书写方便,加了一个对应方法     

## 这里能找到什么？

1.  Provider状态管理的最佳实践，虽然Google很早就废弃了`Provide`，宣布[`Provider`](https://github.com/rrousselGit/provider)为推荐的状态管理工具，可是在开发中，我们总是会遇到很多问题。

    1.  比如`Provider`的几个衍生类在具体的业务中应该怎么使用？

    2.  页面最初需要的数据什么时候进行初始化,在哪里初始化。

    3.  如何将页面的几个常用状态`loading`、`error`、`empty`、`idle`、`unAuthorized`进行组合使用。

    4.  常用的`下拉刷新`，`上拉加载更多`应如何服用才能效果更佳。

    5.  Widget在dispose后，`model`不再notify()。

2.  清晰的代码结构。

    1.  让页面归页面，让业务归业务，所有的业务逻辑都在`view_model`中，Widget只关注页面本身。

3.  不要再满屏幕的setState()。

    1.  同一页面内可以利用Flutter框架给我们提供的各种XxxBuilder,来局部刷新。

    2.  多层嵌套可使用前边提到的`Provider`。

    3.  当然颗粒度足够细的Widget，还是要使用setState()。eg: [ChangeLogPage中的ChangeLogView](https://github.com/phoenixsky/fun_android_flutter/blob/6b4167c5f540b0c656c97ac8fe71a861601649d2/lib/ui/page/change_log_page.dart) 功能单一，刷新不会影响别的widget。

4.  实现了App的基础功能，可copy当作模板代码快速开发

    1.  主题切换

    2.  夜间模式切换

    3.  字体切换

    4.  漂亮的骨架屏

    5.  利用`IDE`插件`i18n`进行国际化

    6.  Dio结合Cookjar，实现`玩Android`的登录功能

    7.  AnimationList结合SmartRefresh的常规数据加载

5.  当然还有WanAndroid本身也有不错的内容，每日闲暇时，可以读一读。

## 未完成的功能

1.  文章详情页面，也就是webview页面没有加入导航功能，没有找到不影响美观的地方，实在不想像微信那样底部加个箭头，所以目前还不能后退。

2.  首页二楼目前是我个人的blog，也无法前进后退。后期会放一个flutter专题。

3.  Hero动画，在非最后一个tab登陆时，logo的动画会漂移到最后一个，需要加状态判断。

4.  退出登陆加入动效。

## 目前已知存在的问题

1.  表单中，光标不会切换到下一个。待更新到1.7.8-hotfix4后的稳定版再观察修复。

2.  [webview_flutter](https://pub.dev/packages/webview_flutter) 插件的问题还是很多，有些链接点击会没有反应，不会跳转。

3.  [webview_flutter](https://pub.dev/packages/webview_flutter) 不能结合`CustomScrollView`滑动。见[issue](https://github.com/flutter/flutter/issues/31243#issuecomment-521564216) 。

4.  两个同样颜色的widget，中间莫名其妙的会多一条背景色的线。见[issue](https://github.com/flutter/flutter/issues/14288) 。


5.  Tabbar的Indicator的颜色，在Dark模式切换到Light模式时，偶尔会没有跟随切换。

## Future

1.  后期会上线大量博客，来讲述这个项目里所遇到的问题及解决的思路。

## 作者的话
*  坐标上海,想找Flutter方向的工作,4年Android开发,可面向API进行小程序,Vue开发.还成功上架过weex应用.

## 感谢

1.  感谢 [V2Lf](https://github.com/w4mxl/V2LF) 开源项目，很早就在TestFlight中下载了该App,那时还没开源。萌生了想做一个开源的App的想法。

2.  借鉴了`goweii`[WanAndroid](https://github.com/goweii/WanAndroid)项目的UI，最美原生版WanAndroid，感谢。

3.  在实践Provider时，发现了[Tutorials](https://github.com/FilledStacks/flutter-tutorials),作者Youtube的教程很好。

4.  感谢优秀的[pull_to_refresh](https://pub.dev/packages/pull_to_refresh)刷新库。

5.  感谢站酷提供的开源的字体。

## 关于作者
* [Github](https://github.com/phoenixsky)
* [个人博客](http://blog.phoenixsky.cn/)
* [简书](https://www.jianshu.com/u/145e6297cb26)
* Email: moran.fc@gmail.com
