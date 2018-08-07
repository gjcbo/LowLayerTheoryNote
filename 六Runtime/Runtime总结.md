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

- 消息发送阶段流程图：
![1-isa指针](/Users/raobo/Desktop/1-sa指针.png)
图解：OC对象分三种：instance(实例)对象、class(类)对象、meta-class(元类)对象。每种都有一个isa指针；后两个另外多了一个superclass指针。
每种对象存储的信息不一样。
instance实例对象：isa指针，其他成员变量的具体值。
class类对象：isa指针、superclass指针、对象方法、...
meta-class元类对象：isa指针、superclass指针、类方法。
eg:调用对象方法。先通过isa指针---->class类对象，调用对象方法。没有就通过superclass 去父类的class类对象中找，有就调用，没有就继续通过superclass往上找，直到NSObject，还没找到就报错：unrecognize selector sent to xxxxxx。炸了。

![2-消息发送](/Users/raobo/Desktop/2-消息发送阶段.png)

消息发送阶段就是通过isa指针找到class(类)对象，先去cache 中查找是否有方法的实现,有就结束查找，并展开调用；没有就去method方法中查找。有就调用，结束操作，并缓存到cache总。如果没有有就通过superclass指针找到父类的class(类)对象，重复上述步骤，如果一直找找到基类也没找到，就会进入第二阶段：动态方法解析阶段

- 动态方法解析阶段流程图：


- 消息转发阶段流程图：


#### 二 数据结构：
Class ： 


#### 参考资料
//  1.利用runtime解决数组字典的崩溃问题: https://www.jianshu.com/p/080a238c62b9
//  博客：http://yulingtianxia.com/blog/2014/11/05/objective-c-runtime/


