# FunFlutter系列之Wandroid 2.0

## 新的征程

在1.x的基础上主要更新了以下内容

 1. 适配Flutter SDK 2.0+

 2. 迁移[空安全](https://dart.cn/null-safety)

 3. 状态管理从[Provider](https://pub.flutter-io.cn/packages/provider)迁移到了使用层面更便于理解的[GetX](https://pub.dev/packages/get)

> Flutter SDK 2.x+ && null-safety && GetX

## 项目结构





## 相关插件

1. getx相关便捷代码生成插件[getx-snippets-intelliJ](https://github.com/cjamcu/getx-snippets-intelliJ) | [getx-snippets-vscode](https://github.com/kauemurakami/getx_snippets_extension) 快速生成代码
2. getx相关便捷模块(文件夹、文件)生成插件[getx_template](https://github.com/CNAD666/getx_template) 快速生成文件



## 相关介绍

### GetX

地址

- Github：[jonataslaw/getx](https://github.com/jonataslaw/getx)
- Pub：[get](https://pub.dev/packages/get)

#### 状态管理

1. 简单状态管理器和响应式状态管理器如何选择。

   以下分析内容来自[Flutter GetX使用\-\-\-简洁的魅力！](https://juejin.cn/post/6924104248275763208#heading-13)

   > **分析**
   >
   > - Obx是配合Rx响应式变量使用、GetBuilder是配合update使用：请注意，这完全是俩套定点刷新控件的方案
   >   - 区别：前者响应式变量变化，Obx自动刷新；后者需要使用update手动调用刷新
   > - 响应式变量，因为使用的是`StreamBuilder`，会消耗一定资源
   > - `GetBuilder`内部实际上是对StatefulWidget的封装，所以占用资源极小
   >
   > **使用场景**
   >
   > - 一般来说，对于大多数场景都是可以使用响应式变量的
   > - 但是，在一个包含了大量对象的List，都使用响应式变量，将生成大量的`StreamBuilder`，必将对内存造成较大的压力，该情况下，就要考虑使用简单状态管理了

   

#### 插件的事半功倍

- getx_template：一键生成每个页面必需的文件夹、文件、模板代码等等
  - [Android Studio/Intellij插件](https://plugins.jetbrains.com/plugin/15919-getx)
- GetX Snippets：输入少量字母，自动提示选择后，可生成常用的模板代码
  - [Android Studio/Intellij扩展](https://plugins.jetbrains.com/plugin/14975-getx-snippets)
  - [VSCode扩展](https://marketplace.visualstudio.com/items?itemName=get-snippets.get-snippets)

