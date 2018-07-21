//
//  main.m
//  06
//
//  Created by RaoBo on 2018/7/21.
//  Copyright © 2018年 RaoBo. All rights reserved.
//  简书:https://www.jianshu.com/p/56244ef0db26 

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

//Person
@interface Person  : NSObject <NSCopying>
{
    @public
    int _age;
}
@property (nonatomic, assign) int num;
- (void)personInstanceMethod;
+ (void)personClassMethod;

@end

@implementation Person

- (void)personInstanceMethod {
    NSLog(@"- [Person personInstanceMethod] 方法调用者:%@ 第:%d行",self,__LINE__);
}

+ (void)personClassMethod {
    NSLog(@"+ [Person personClassMethod]  方法调用者:%@  第:%d行",self,__LINE__);
}
- (id)copyWithZone:(NSZone *)zone {
    return nil;
}
@end

//Student
@interface Student : Person <NSCoding>
{
    @public
    int _weight;
}
@property (nonatomic, assign) int height;
- (void)studentInstanceMethod;
+ (void)studentClassMethod;
@end
@implementation Student
//子类重写父类方法实现
- (void)personInstanceMethod  {
//    [super personInstanceMethod];
    NSLog(@"- [Student personInstanceMethod] 方法调用者:%@ 第:%d行",self,__LINE__);
    
}
- (void)studentInstanceMethod {
    
}
+ (void)studentClassMethod {
    NSLog(@"+ [Student studentClassMethod] 方法调用者:%@ 第:%d行",self,__LINE__);

}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return nil;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
}

@end
#pragma mark - 一 方法调用的流程之 isa 不考虑继承
/***
 为什么会报unrecognized selector send to xxxxxx
 */


int main1(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Person * person = [[Person alloc] init];
        Class personClass = [Person class];
        Class personMetaClass = object_getClass(personClass);
        NSLog(@"%p--%p--%p",person,personClass,personMetaClass);
        NSLog(@"%@",class_isMetaClass(personMetaClass) ? @"是" : @"不是");
        [person personInstanceMethod];
        //        void objc_msgSend(id self, SEL cmd, ...)
        
        
        ((void (*)(id, SEL))objc_msgSend)(person,@selector(personInstanceMethod)); //✅
        ((void(*)(id, SEL)) objc_msgSend)(personClass, @selector(personClassMethod));//✅
        
        
        //为什么下面两句代码会崩溃。
        //前置条件:对象方法存放在class对象(类对象中), 类方法存放在meta-class对象(元类对象中),不然下面的奔溃就无法自圆其说了。
        //对象方法调用流程。isa-->找到class对象。展开调用对象方法。 (暂时不考虑继承问题)
        //类方法调用流程:  isa--->meta-class对象。展开调用类方法。(暂时不考虑继承问题)
        //OC调方法的本质就是发消息。person的实例对象的isa指针找到 Person类对象(对象方法存放在这里),没有+ (void)personClassMethod 这个方法。(这个方法是放在元类里面的)。找不到自然就报 unrecognized xxxxxxx 错误
//        ((void(*)(id, SEL))objc_msgSend)(person,@selector(personClassMethod)); // ❌ unrecognized selector sent
    // reason: '-[Person personClassMethod]: unrecognized selector sent to instance 0x10051cc80'

        
        //问什么会奔溃: 因为:类方法存放在meta-class对象(元类对象)中。 class对象(类对象)调用类方法。通过 isa---->找到meta-class对象(元类对象)--->调用对象方法。但是你传进来的就是meta-class对象(元类对象)。通过isa找到rootClass(基类)的元类对象,没有找到这个方法，∴ 奔溃unrecognized selector xxxxxx
        
        
        //isa-->找到class对象(类对象)然后调用对象方法--->isa---->找到metaclass对象(元类对象)然后调用对象方法。
//        ((void(*)(id, SEL))objc_msgSend)(personMetaClass,@selector(personClassMethod)); //❌
//        '+[Person personClassMethod]: unrecognized selector sent to class 0x100002528'

        
    }
    return 0;
}

#pragma mark - 二 对象方法的调用轨迹
//对象方法调用轨迹
int main2() {
    //重复这样一个认识: class对象(类对象)存放对象方法。 meta-class对象(元类对象)存放类方法。
    
    //之类调用父类的方法的流程。
    // isa--->class对象---->superclass----->父类的class对象
    // 子类重写父类的方法,根据isa指针的查找顺序可以,会有些调用子类的方法。如果找不到再在通过superclass 找到父类的类对象。然后在展开调用。
    Student *stu = [[Student alloc] init];
    [stu personInstanceMethod];
    return 0;

}



#pragma mark - 三 对象方法的调用轨迹
int main () {
    
    //获取class对象(类对象)
    Person *per = [[Person alloc] init];
    Class personClass = object_getClass(per);
    Class personClass2 = [Person class];
    NSLog(@"%p %p",personClass,personClass2); //0x1000025d8 0x1000025d8 --->同一个class对象有且只有一份,存放对象方法。
    
    
//    [Person personClassMethod];
//    // 调方法就是发消息
//    ((void(*)(id,SEL))objc_msgSend)(personClass,@selector(personClassMethod));
    
    
    //子类调用自己的类方法
    //子类的类对象---->isa--->找到子类的元类对象。调用自己的类方法。
    [Student studentClassMethod];
    
    //子类的类对象--->isa---->子类元类对象---->superclass指针---->父类的元类对象。调用父类的类方法。
    [Student personClassMethod];
    
    return  0;
}
