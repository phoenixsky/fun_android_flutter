

Language: [English](https://github.com/phoenixsky/fun_android_flutter/blob/master/README-EN.md) | [中文简体](https://github.com/phoenixsky/fun_android_flutter/blob/master/README.md)



![logo,灵感来自2dimensions是个蓝色的F，自己挺喜欢，就down了下来，后来又翻了好久也没找到作者，如果侵权请联系我](https://upload-images.jianshu.io/upload_images/581515-f3a4b2e4392e63bf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/200) 

> Big F, it's `Fun`, also it means `Flutter`.

`FunAndroid` is a  production project , Provider's best practices with MVVM

# ScreenShot

| ![splash.gif](https://upload-images.jianshu.io/upload_images/581515-1e3e9fe19d44adca.gif?imageMogr2/auto-orient/strip) | ![首页空中楼阁](https://upload-images.jianshu.io/upload_images/581515-2f68e3fc18a3161e.gif?imageMogr2/auto-orient/strip) | ![tab概览_1080-50-128.gif](https://upload-images.jianshu.io/upload_images/581515-be91ba09c020f594.gif?imageMogr2/auto-orient/strip) |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![页面不同状态展示.gif](https://upload-images.jianshu.io/upload_images/581515-81e45c5a72fd6b83.gif?imageMogr2/auto-orient/strip) | ![搜索.gif](https://upload-images.jianshu.io/upload_images/581515-00f7b2f89cf141a1.gif?imageMogr2/auto-orient/strip) | ![收藏-50.gif](https://upload-images.jianshu.io/upload_images/581515-5c5e9b7219100c26.gif?imageMogr2/auto-orient/strip) |
| ![登录页展示.gif](https://upload-images.jianshu.io/upload_images/581515-9d83d6940c9a57ed.gif?imageMogr2/auto-orient/strip) | ![收藏列表到登录.gif](https://upload-images.jianshu.io/upload_images/581515-15084c89cc5a55f2.gif?imageMogr2/auto-orient/strip) | ![主题切换-1080-75-256.gif](https://upload-images.jianshu.io/upload_images/581515-348b013cc8a52621.gif?imageMogr2/auto-orient/strip) |

# Home Page

> [https://github.com/phoenixsky/fun_android_flutter](https://github.com/phoenixsky/fun_android_flutter)

# Download page 

# 下载地址
    
 > [download page](https://www.pgyer.com/Ki0F)
   
  ![](https://www.pgyer.com/app/qrcode/Ki0F)

# Environment :
  * Flutter SDK (Channel dev, v1.10.3)


# Update

## 2019-08-28

- add WebViewPlugin switcher in Setting Page
- My favourite list can refresh after the unlike in the detail page

## 2019-08-26 

- update favourite animation with Hero and Route . (hiding original hero after hero transition.见[pr-37341](https://github.com/flutter/flutter/pull/37341))

  ![Hero-收藏-25-64.gif](https://upload-images.jianshu.io/upload_images/581515-c95bf682c308bd40.gif?imageMogr2/auto-orient/strip)



# Provider MVVM Best Practices

- Quickly add a page with pull-down refresh and pull up to load more pages. For example
  1. Model
     ![Api](https://upload-images.jianshu.io/upload_images/581515-f60f2fceef71b2cc.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
  2. ViewModel
     ![-w494](https://upload-images.jianshu.io/upload_images/581515-3ab778bafeb3b5b7.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
  3. View
     ![-w637](https://upload-images.jianshu.io/upload_images/581515-1aa9bd76f0e6f600.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> `model.viewState == ViewState.busy`  is better way ,but `isBusy` easy to write

# What can you find here?？

1. Provider 
   1. When and Where init data
   2. how to be with ViewState(`loading`、`error`、`empty`、`idle`、`unAuthorized`)。
   3. use together  with `pull to refresh`
2. Clear Structure。
3. Drop setState, Partial Rerefresh with  XxxBuilder
4. App base module
   1. Theme
   2. DarkMode
   3. Switch Font 
   4. Skeleton 
   5. i18n
   6. Dio with Cookjar，use cookie login

# To-Do

1. homepage  second floor can't navigate
2. Sign in Hero animation shift
3. Sign out add animation

# Bug

1. webview_flutter](https://pub.dev/packages/webview_flutter)  some url can't navigate
2. [webview_flutter](https://pub.dev/packages/webview_flutter)  in `CustomScrollView` can't scroll ,[issue](https://github.com/flutter/flutter/issues/31243#issuecomment-521564216) 。
3. anti-aliasing when same-colour blocks in SignIn Page。见[issue](https://github.com/flutter/flutter/issues/14288) 。



# Thanks

1. [V2Lf](https://github.com/w4mxl/V2LF) ，made me like flutter
2. `goweii`[WanAndroid](https://github.com/goweii/WanAndroid)
3. [Tutorials](https://github.com/FilledStacks/flutter-tutorials),Video tutorial on youtube
4. [pull_to_refresh](https://pub.dev/packages/pull_to_refresh)
5. ZCOOL Font
6. [WanAndroid](https://www.wanandroid.com/blog/show/2) provide Api

# About Me

- [Github](https://github.com/phoenixsky)
- [Blog](http://blog.phoenixsky.cn/)
- [简书](https://www.jianshu.com/u/145e6297cb26)
- Email: moran.fc@gmail.com

# License

Copyright 2019 phoenixsky

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
