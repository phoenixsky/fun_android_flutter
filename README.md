> Language: [简体中文](README.md) | [English](README-EN.md)

</br>

> 基于Google的[Flutter](https://flutter.dev),及官方推荐状态管理[Provider](https://github.com/rrousselGit/provider)和[玩Android](https://wanandroid.com/)开放的API，打造的一款产品级开源App《[Fun Android](https://github.com/phoenixsky/fun_android_flutter)》

![logo,灵感来自2dimensions是个蓝色的F，自己挺喜欢，就down了下来，后来又翻了好久也没找到作者，如果侵权请联系我](https://user-gold-cdn.xitu.io/2019/9/18/16d43ceba7b8ec29?w=500&h=500&f=png&s=73992) 

> Logo的里F，既代表了`Fun`也代表了`Flutter`.

# 先来点样图

|![splash.gif](https://user-gold-cdn.xitu.io/2019/9/18/16d43ceba81f5d97?w=375&h=810&f=gif&s=1510179)| ![首页空中楼阁](https://user-gold-cdn.xitu.io/2019/9/18/16d43ceba80a0d00?w=250&h=540&f=gif&s=4839426) | ![tab概览_1080-50-128.gif](https://user-gold-cdn.xitu.io/2019/9/18/16d43ceba8a2a682?w=250&h=540&f=gif&s=2990202)|
| --- | --- | --- |
| ![页面不同状态展示.gif](https://user-gold-cdn.xitu.io/2019/9/18/16d43ceba907d9bd?w=375&h=810&f=gif&s=3024125) | ![搜索.gif](https://user-gold-cdn.xitu.io/2019/9/18/16d43ceba918bab1?w=375&h=810&f=gif&s=3447239)| ![收藏-50.gif](https://user-gold-cdn.xitu.io/2019/9/18/16d43cebc94cf612?w=250&h=540&f=gif&s=3324262)|
| ![登录页展示.gif](https://user-gold-cdn.xitu.io/2019/9/18/16d43cebd9316b4f?w=375&h=810&f=gif&s=1153965) | ![收藏列表到登录.gif](https://user-gold-cdn.xitu.io/2019/9/18/16d43cebe40dd5db?w=375&h=810&f=gif&s=2890935) | ![主题切换-1080-75-256.gif](https://user-gold-cdn.xitu.io/2019/9/18/16d43cebe9dc7aad?w=375&h=810&f=gif&s=2763511)| 

# 项目地址
 > [https://github.com/phoenixsky/fun_android_flutter](https://github.com/phoenixsky/fun_android_flutter)

# 下载地址
    
 > [蒲公英下载页](https://www.pgyer.com/Ki0F)
   
  ![](https://www.pgyer.com/app/qrcode/Ki0F)

# 代码编译
  * 当前代码的Flutter SDK (Channel stable, v1.12.13+hotfix.8).因flutter还在高速发展中,BreakingChange比较多.如有编译中代码错误,核对下sdk版本号
  * 如果要查看运行效果,一定要使用Release模式,流畅程度差距非常大
      > Flutter的`Debug`和`Release`的编译模式不同,下分别是 `JIT` 和 `AOT`.`Debug`模式支持`hot reload`.
  * iOS运行在splash页面卡住,需要检查当前的scheme,如果为`release`,需在命令行执行`flutter build ios`
  ![image.png](https://user-gold-cdn.xitu.io/2019/9/18/16d43cebf41a7cdc?w=1000&h=266&f=png&s=144513)
    
  * 项目国际化方案从[flutter_i18n](https://github.com/long1eu/flutter_i18n)迁移到[flutter_intl](https://flutter.cn/docs/development/accessibility-and-localization/internationalization)方案,使用说明见[FunFlutter系列之国际化Intl方案 \- 掘金](https://juejin.im/post/5e4536d0e51d4526ef5f85a9)

    
# 介绍
借用群里水友的两句对白，在预览版出来时候

*   1A：话说`玩Android`的开源项目已经多如牛毛了。

*   3C：我想看最漂亮的。

感谢这位朋友对`Fun Android`的认可。

关于App的主题风格，不全是Google倡导的Material Design 也不全是Apple的Cupertino Style。由于我是一个Android开发者，但又长期使用的iPhone，所以App的风格是两者的结合又夹杂了点私货。个人认为iOS版本的确实好看点。

代码中存在的问题，请大家积极提[Issue](https://github.com/phoenixsky/fun_android_flutter/issues).

# 更新

## V1.0.0 `2021-04-12` (未打包)
- 适配SDK版本 `2.0.4`
- tag > 1.0.0 

## V0.1.15 `2020-02-24` (未打包)
- 优化ViewStateError
- ViewState状态重命名
- 升级部分依赖库

## V0.1.14 `2020-02-13` (未打包)
- 更新SDK版本为`stable, v1.12.13+hotfix.8`
- 适配Provider4.x
- 迁移国际化方案到`flutter_intl`,使用说明见[FunFlutter系列之国际化Intl方案 \- 掘金](https://juejin.im/post/5e4536d0e51d4526ef5f85a9)

## V0.1.13 `2019-12-20` (未打包)
- 修复之前未上传签名文件导致编译出错的问题
- 更新SDK版本为`stable, v1.12.13+hotfix.5`
- 更新Provider版本到3.2.0
- 更新Cache_Network_Image到2.0.0RC
- 隐藏部分重写导致import冲突的widget
- 增加部分ignore配置
- 感谢[liyujiang-gzu](https://github.com/liyujiang-gzu)的pr 


## V0.1.12 `2019-10-21` (未打包)
- 下拉刷新列表在加载失败时,如果当前页没有数据显示错误提示页,有数据则弹出toast提示

## V0.1.11 `2019-10-17`
- 增加网络加载失败的提示

## V0.1.10 `2019-10-16`
- 修复收藏页面'shareUser'字段为空导致报错的bug

## V0.1.9 `2019-10-14`
- 极致黑(Native的闪屏页面适配darkMode)
- 首页banner高度根据屏幕宽高适应
- 签名文件调整

## V0.1.8 `2019-10-13`
- 文章列表加入分享人
- 首页加入数据为空的逻辑判断
- ViewStateModel中逻辑优化,bug fix
- 状态栏字体颜色优化
- 修复TextField中hint为中文时不居中的问题

## V0.1.7 `2019-09-23`

- DarkMode自动跟随系统设置
- App更新组件调整
- 适配Dio3.0版本
- pull_to_refresh更新:加入国际化

## V0.1.6 `2019-09-20`

- 修复收藏列表进入详情时,页面报错的bug

## V0.1.5 `2019-09-19`

- Flutter SDK更新至**Channel dev, v1.10.3**,修复`我的`页面莫名卡死的问题
- 修改Android端App名称为Fun Android

## V0.1.4 `2019-09-18`

- 适配Flutter 1.9.x
- **Android加入版本更新**
- 加入LeanCloud API云服务
- 移除修复首页黑屏问题的代码`官方在1.10.1版本已修复`
- 移除之前屏幕适配方案,对NativeView影响过大
- 修复版本更新导致的AppBar中进度条颜色与背景色不明显的问题
- 重构Http使用方式,解耦性更好
- 首页banner高度调整
- Android状态栏透明

## 2019-09-10

- flutter版本更新
- 适配更新AppBar区域CupertinoActivityIndicator的主题色彩冲突
- 移除OffState和Indicator的组合使用,优化性能
- 调整textField的clear实现方式,防止报错

## 2019-09-09

- 修复各页面里文章 **收藏** 状态没有同步的问题
    - 首页收藏后,其他tab页对应item的收藏状态同步
    - 我的收藏页面里移除收藏.其他页面状态同步
    - 登录登出后各页面收藏状态刷新
    - 如果相同账号在其他平台修改过收藏状态,只需要刷新列表即可同步收藏状态.(WanAndroid接口目前存在问题)
- 优化Dropdown弹出动画
- 首页初次加载数据禁用上拉记载更多功能
- 登录页面输入框可通过回车键切换


## 2019-08-30

- 修复积分数值在登录后没有刷新的bug
- 修复进入Splash页面短暂黑屏的bug
- 修复未登录时,点击收藏还可以播放动画的bug
- 默认主题色调整为亮色

## 2019-08-29
- 添加积分记录和排行榜功能

## 2019-08-28
- 在设置中添加WebViewPlugin的开关
- 在详情中移除收藏后,回到收藏列表页面自动刷新

## 2019-08-26 
- 更新收藏动画的实现方式,之前实现的方式侵入性太强，每个页面都要先隐藏一个小❤❤。现在换了路由➕Hero的思路，重新调整了Flare。显示动画一行代码就ok。(如果你运行代码之后发现,该动画与图上会有一丝丝不一致,列表项右下角的小心会闪一下.不用担心那是flutter的bug,目前在master分支已经修复.见[pr-37341](https://github.com/flutter/flutter/pull/37341))

    ![Hero-收藏-25-64.gif](https://user-gold-cdn.xitu.io/2019/9/18/16d43cebffb04cd8?w=236&h=468&f=gif&s=2132860)

# 项目结构

| ![项目结构1](https://user-gold-cdn.xitu.io/2019/9/18/16d43cec0809ff91?w=500&h=1092&f=png&s=250069) | ![项目解构2](https://user-gold-cdn.xitu.io/2019/9/18/16d43cec1e9ffedc?w=500&h=1067&f=png&s=226283) |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
|                                                              |                                                              |

# Provider MVVM的简单使用方式

*  快速添加一个拥有下拉刷新,上拉加载更多的页面.比如开发一个`玩Android`首页列表页面
    1. Model
        ![Api](https://user-gold-cdn.xitu.io/2019/9/18/16d43cec219bfccc?w=978&h=332&f=jpeg&s=30568)
    2. ViewModel
        ![-w494](https://user-gold-cdn.xitu.io/2019/9/18/16d43cec37ddbd5b?w=988&h=296&f=jpeg&s=29699)
    3. View
        ![-w637](https://user-gold-cdn.xitu.io/2019/9/18/16d43cec22be5dbb?w=1240&h=1041&f=jpeg&s=135195)

> 以上是Provider结合ViewModel的基础使用方式,考虑了App中会出现的比较全面的情况,希望大家一起探讨使用方式

> 另外在判断页面状态的时候,其实拿`model.viewState == ViewState.busy`会更严谨一点.为了书写方便,加了一个对应方法     

# 这里能找到什么？

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

# 未完成的功能

1.  首页二楼目前是我个人的blog，也无法前进后退。后期会放一个flutter专题。

2.  Hero动画，在非最后一个tab登陆时，logo的动画会漂移到最后一个，需要加状态判断。

3.  退出登陆加入动效。

# 目前已知存在的问题


1.  [webview_flutter](https://pub.dev/packages/webview_flutter) 插件的问题还是很多，有些链接点击会没有反应，不会跳转。所以接入了两套WebView方案

2.  [webview_flutter](https://pub.dev/packages/webview_flutter) 不能结合`CustomScrollView`滑动。见[issue](https://github.com/flutter/flutter/issues/31243#issuecomment-521564216) 。

3.  两个同样颜色的widget，中间莫名其妙的会多一条背景色的线。见[issue](https://github.com/flutter/flutter/issues/14288) 。


# Future

*  后期会上线大量博客，来讲述这个项目里所遇到的问题及解决的思路。

# 寻找组织
* Fun Flutter微信交流群  
    加入我微信（GitHub用户名）备注`fun flutter`，拉你进群 

# 作者的话

*  坐标上海,打算找Flutter方向的工作.有意向可以联系我

# 感谢

1.  感谢 [V2Lf](https://github.com/w4mxl/V2LF) 开源项目，很早就在TestFlight中下载了该App,那时还没开源。萌生了想做一个开源的App的想法。

2.  借鉴了`goweii`[WanAndroid](https://github.com/goweii/WanAndroid)项目的UI，最美原生版WanAndroid，感谢。

3.  在实践Provider时，发现了[Tutorials](https://github.com/FilledStacks/flutter-tutorials),作者Youtube的教程很好。

4.  感谢优秀的[pull_to_refresh](https://pub.dev/packages/pull_to_refresh)刷新库。

5.  感谢站酷提供的开源的字体。

6.  感谢WanAndroid提供的API。

# 关于作者
* [Github](https://github.com/phoenixsky)
* [个人博客](http://blog.phoenixsky.cn/)
* [掘金](https://juejin.im/user/567fe97c60b25aa3dcd4bcc0)
* [简书](https://www.jianshu.com/u/145e6297cb26)
* Email: moran.fc@gmail.com

# License

Copyright 2019 phoenixsky

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
