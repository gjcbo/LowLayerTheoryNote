//
//  main.m
//  08
//
//  Created by RaoBo on 2018/7/21.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


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


//struct objc_class : objc_object {
//    // Class ISA;
//    Class superclass;
//    cache_t cache;             // formerly cache pointer and vtable
//    class_data_bits_t bits;    // class_rw_t * plus custom rr/alloc flags
struct rb_objc_class {
    Class isa;
    Class superclass;
};


int main(int argc, const char * argv[]) {
    @autoreleasepool {

  /***
# if __arm64__
#   define ISA_MASK        0x0000000ffffffff8 ULL
# elif __x86_64__               //Mac 命令行程序
#   define ISA_MASK        0x00007ffffffffff8 ULL
*/
        
        // intance对象的isa & ISA_MASK --->class对象
        // class对象的  isa & ISA_MASK --->meta-class元类对象
        
        //Person类对象的地址:0x0000000100002530
        //Person的实例对象的isa指针:  0x001d800100002531
        //isa & ISA_MASK : 0x0000000100002530
        
//        Person *person = [[Person alloc] init];
//        Class personClass = [Person class];
//        Class personMetaClass = object_getClass(personClass);
//
//        Student *stu = [[Student alloc] init];
//        struct rb_objc_class *studentClass = (__bridge struct rb_objc_class *)[Student class];
//
//        Class stuentMetaClass = object_getClass([Student class]);
//        NSLog(@"1111");
        

        //isa指针--->class 对象
        //1> instance对象(实例对象)的isa指向--->class对象(类对象)
        //2> class对象(类对象的) isa指向 ---> 父类的 class对象(类对象)
        //3> meta-class对象(元类对象)的isa指向 ---> 基类的meta-class对象
        Person *p3 = [[Person alloc] init];
        struct rb_objc_class * p3Class = (__bridge struct rb_objc_class *)[Person class];
        struct rb_objc_class * p3MetaClass = (__bridge struct rb_objc_class *)(object_getClass([Person class]));
        Class objectClass = [NSObject class];
        Class objectMetaClass = object_getClass([NSObject class]);

        
        Student *stu3 = [[Student alloc] init];
        struct rb_objc_class * stu3Class = (__bridge struct rb_objc_class *)object_getClass(stu3);
        struct rb_objc_class * stu3MetaClass = (__bridge struct rb_objc_class *)object_getClass([Student class]);
        
        //说明系统没有暴露 isa。自己暴露
//        (lldb) p/x p3MetaClass->isa
//    error: member reference base type 'Class' is not a structure or union

        
        
        NSLog(@"3333");
        //superclass指针--->metaclass
        
    }
    return 0;
}
