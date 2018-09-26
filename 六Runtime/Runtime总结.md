# Runtime总结

### 主要内容
写在前面的话：总结后，才会变成自己的。别想着一下子写好，随着认识能力的提升不断的进行优化，希望：系统、简洁、有重点、写代码验证。

OC 是一门动态性语言，OC的动态性由Runtime的API来支撑。Runtime提供的API接口基本都是C语言的。

1.消息机制：消息发送、动态方法解析、消息转发。

2.数据结构：Class、IMP、SEL、isa、method_t ....

3.关联对象：给分类添加属性
4.动态创建类：KVO的底层实现。
4.hook：method Swizzing 方法交换：替换系统方法、给UIFont 设置字体系数。 数组、字典、NSUserDefault添加 nil 对象奔溃。

5.消息转发，使用NSProxy巧妙解决定时器循环引用问题。
6.遍历所有的成员变量：修改textField的占位文字、字典转模型、自动归档接档。
系统提供的API
7.runtime用的比较多的三方库：MJExtension、YYModel、Aspect;
8.参考资料

#### 一 ：消息机制的理解
OC 方法的调用底层都会被转成了objc_msgSend()函数的调用。给receive(方法调用者)发送了一条消息(selector方法名)。每一个方法内部都有两个默认参数：self 消息的接收者、_cmd 方法选择器(SEL) 

关于方法找不到的处理方式：
从生活的角度：要么你动态添加一个。要么你让人家去处理（帅锅）。
体现在代码上：要么动态方法解析+(BOOL)resolveXXXXMethod:(SEL)sel 中动态添加一个方法的实现。  要么进行消息转发，干不了，帅锅给人家。- (id)forwardingTargetForSelector:(SEL)aSelector { return 背锅的人 } 


OC的消息机制分为三个阶段：1、消息发送,2、动态方法解析，3、消息转发。
/Users/raobo/Desktop/提交代码/LowLayerTheoryNote/六Runtime/Images/1-sa指针.png

- 消息发送阶段流程图：
![1-isa指针](/Users/raobo/Desktop/提交代码/LowLayerTheoryNote/六Runtime/Images/1-sa指针.png)
图解：OC对象分三种：instance(实例)对象、class(类)对象、meta-class(元类)对象。每种都有一个isa指针；后两个另外多了一个superclass指针。
每种对象存储的信息不一样。
instance实例对象：isa指针，其他成员变量的具体值。
class类对象：isa指针、superclass指针、对象方法、...
meta-class元类对象：isa指针、superclass指针、类方法。
eg:调用对象方法。先通过isa指针---->class类对象，调用对象方法。没有就通过superclass 去父类的class类对象中找，有就调用，没有就继续通过superclass往上找，直到NSObject，还没找到就报错：unrecognize selector sent to xxxxxx。炸了。

![2-消息发送](/Users/raobo/Desktop/提交代码/LowLayerTheoryNote/六Runtime/Images/2-消息发送阶段.png)

消息发送阶段就是通过isa指针找到class(类)对象，先去cache 中查找是否有方法的实现,有就结束查找，并展开调用；没有就去method_list_t 方法列表中查找。有就调用，结束操作，并缓存到cache中。如果没有有就通过superclass指针找到父类的class(类)对象，重复上述步骤，如果一直找找到基类也没找到，就会进入第二阶段：动态方法解析阶段

- 动态方法解析阶段流程图：

![3-动态方法解析阶段](/Users/raobo/Desktop/提交代码/LowLayerTheoryNote/六Runtime/Images/3-动态方法解析阶段.png)
我的理解：1.什么时候该方法会被调用？2.该方法的作用？3.下一步操作？

第一个问题：能来到这里就说明，方法的实现找不到，你能做的就是动态的添加一个方法的实现，标记为YES并返回(只是一个标记,没什么用)，就不会出现”unrecognize selector sent to xxxx“这种奔溃。

第二个问题：给你一次改过自新的机会，把握住了(利用runtime动态的添加一个方法的实现, class_addMethod(xxxxx))，重走消息发送流程，能找得到，程序就正常运行。依然不作为，直接进入消息转发流程，还是没人处理，直接奔溃。

```
+ (BOOL)resolveInstanceMethod:(SEL)sel {

if(sel == @selector(test)) {
//获取其他方法
Method otherMethod = class_getInstanceMethod(self, @selector(other));

//动态添加 -(void)test方法的实现
//对象方法添加到类对象上。
class_addMethod(self, sel, method_getImplementation(otherMethod), method_getTypeEncoding(otherMethod));

return YES; //其实你传NO，也没问题。通过查看底层源码，他根本就没用这个值。
}

return [super resolveInstanceMethod:sel];
}

```


第三个问题：如果动态添加了方法的实现就进入消息发送阶段，如果没有就进入消息转发阶段，调用 - (id)forwardingTargetForSelector:(SEL)aSelector将消息转发给别人，或者称方法重定向(redirect)。总会联想到http的302重定向。

```
- (id)forwardingTargetForSelector:(SEL)aSelector {

//将消息转发给别的对象处理。注意不能返回自己，会导致死循环。
//返回值 non-nil (and non-self)
return 返回一个对象，处理  aSelector 
}
```




- 消息转发阶段流程图：
![4-消息转发阶段](/Users/raobo/Desktop/提交代码/LowLayerTheoryNote/六Runtime/Images/4-消息转发阶段.png)
使用场景举例：使用第三者进行消息转发，解决定时器循环引用问题。
![使用NSProxy解决定时器循环引用问题](/Users/raobo/Desktop/提交代码/LowLayerTheoryNote/六Runtime/Images/解决定时器循环引用.png)

我的理解:通过看视频+代码验证，我的认识是这样的。如果是一个继承自NSObject的对象。只需要调用下面的方法就行。

```
- (id)forwardingTargetForSelector:(SEL)aSelector {
return self.target;
}

```

如果是继承自 NSProxy(代理人(中介、经纪人),专门做消息转发的，不继承NSObject，也是一个基类，没有init方法。跟NSObject处于同一级别，不常用) ,操作如下：

```
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
[invocation invokeWithTarget:self.target];
}
```


#### 二 数据结构：
Class ： 


#### 参考资料
//  1.利用runtime解决数组字典的崩溃问题: https://www.jianshu.com/p/080a238c62b9
//  博客：http://yulingtianxia.com/blog/2014/11/05/objective-c-runtime/


