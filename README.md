# APM
iOS性能监测SDK

# 监控参数
据统计，有十种应用性能问题危害最大，分别为：
连接超时、闪退、卡顿、崩溃、黑白屏、网络劫持、交互性能差、CPU 使用率问题、内存泄露、不良接口

# 卡顿监控
主线程卡顿监控的实现思路：开辟一个子线程，然后实时计算 kCFRunLoopBeforeSources 和 kCFRunLoopAfterWaiting 两个状态区域之间的耗时是否超过某个阀值，来断定主线程的卡顿情况，可以将这个过程想象成操场上跑圈的运动员，我们会每隔一段时间间隔去判断是否跑了一圈，如果发现在指定时间间隔没有跑完一圈，则认为在消息处理的过程中耗时太多，视为主线程卡顿。


# FPS
屏幕更新频率是固定的，通常是60Hz，如果显卡的输出高于60fps，两者不同步，画面便会撕裂。通常游戏内选项内的垂直同步(V Sync)打开后便可解决画面撕裂的问题

基于CADisplayLink实现的 FPS 无法完全检测出当前 Core Animation 的性能情况，它只能检测出当前 RunLoop 的帧率。

# 内存泄露
FBRetainCycleDetector

[1](https://draveness.me/retain-cycle1)
[2](https://draveness.me/index)
[3](https://code.facebook.com/posts/583946315094347/automatic-memory-leak-detection-on-ios/)

## 图像的绘制
图像的绘制通常是指用那些以 CG 开头的方法把图像绘制到画布中，然后从画布创建图片并显示这样一个过程。这个最常见的地方就是 [UIView drawRect:] 里面了。由于 CoreGraphic 方法通常都是线程安全的，所以图像的绘制可以很容易的放到后台线程进行。一个简单异步绘制的过程大致如下（实际情况会比这个复杂得多，但原理基本一致）：

```bash
- (void)display {
dispatch_async(backgroundQueue, ^{
CGContextRef ctx = CGBitmapContextCreate(...);
// draw in context...
CGImageRef img = CGBitmapContextCreateImage(ctx);
CFRelease(ctx);
dispatch_async(mainQueue, ^{
layer.contents = img;
});
});
}
```

# UI异步绘制
UIKit 和 CoreAnimation 相关操作必须在主线程执行

# CPU渲染和子线程CG比较？

## 文本渲染
屏幕上能看到的所有文本内容控件，包括 UIWebView，在底层都是通过 CoreText 排版、绘制为 Bitmap 显示的。常见的文本控件 （UILabel、UITextView 等），其排版和绘制都是在主线程进行的，当显示大量文本时，CPU 的压力会非常大。对此解决方案只有一个，那就是自定义文本控件，用 TextKit 或最底层的 CoreText 对文本异步绘制。尽管这实现起来非常麻烦，但其带来的优势也非常大，CoreText 对象创建好后，能直接获取文本的宽高等信息，避免了多次计算（调整 UILabel 大小时算一遍、UILabel 绘制时内部再算一遍）；CoreText 对象占用内存较少，可以缓存下来以备稍后多次渲染。

# 文章参考
1. [ iOS 性能监控 SDK —— Wedjat（华狄特）开发过程的调研和整理](https://github.com/aozhimin/iOS-Monitor-Platform)
2. [iOS 保持界面流畅的技巧](https://blog.ibireme.com/2015/11/12/smooth_user_interfaces_for_ios/)
3. [iOS-Performance-Optimization](https://github.com/DeftMKJ/iOS-Performance-Optimization)
4. [资源使用](http://sindrilin.com/apm/2017/05/05/资源使用.html)

