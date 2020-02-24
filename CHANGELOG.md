# 编译环境
> Channel stable, v1.12.13+hotfix.5


# 最近更新

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

## V0.1.12 `2019-10-21`
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
- App更新UI调整
- 适配Dio3.0版本
- pull_to_refresh更新:加入国际化


## V0.1.6 `2019-09-20`

- 修复收藏列表进入详情时,页面报错的bug

## V0.1.5 `2019-09-19`

- Flutter SDK更新至**Channel dev, v1.10.3**,修复`我的`页面莫名卡死的问题
- 修改Android端App名称为Fun Android
- 版本更新加入提示

## V0.1.4 `2019-09-18`

- **Android加入版本更新**
- 适配Flutter新版本`Channel dev, v1.10.3`
- 移除修复首页黑屏问题的代码`官方在1.10.1版本已修复`
- 加入LeanCloud API云服务
- 移除之前屏幕适配方案,对NativeView影响过大
- 修复版本更新导致的AppBar中进度条颜色与背景色不明显的问题
- 重构Http使用方式,解耦性更好
- 首页banner高度调整
- Android状态栏透明

## 0.1.3

- 修复各页面里文章**收藏**状态没有同步的问题
- 优化Dropdown弹出动画
- 禁用首页初次加载数据的上拉记载更多功能
- 登录页面输入框可通过回车键切换光标


## 0.1.2

- 修复积分数值在登录后没有刷新的bug
- 修复进入Splash页面短暂黑屏的bug
- 修复未登录时,点击收藏还可以播放动画的bug
- 默认主题色调整为亮色

## 0.1.1

- 添加积分记录和排行榜功能
- 在设置中添加WebViewPlugin的开关
- 更新收藏动画的实现方式和效果,此刻尽丝滑
- 在详情中移除收藏后,回到收藏列表页面更新

## 0.1.0

- 初始发布


