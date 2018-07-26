
struct __block_impl {
    void *isa; //isa指针----》确认过眼神👁,可以确认Block就是OC对象。他可以调用 class方法。
    //MRC 下Block分三种类型，都继承自 NSBlock: NSObject  因为继承自NSObject所以有个isa指针。所以是OC对象。
    
    int Flags;
    int Reserved;
    void *FuncPtr;  //保存block块生成的函数的地址。通过函数地址进行函数调用。
};

static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};

struct __main_block_impl_0 {
    //第一部分: __block_impl 结构体。
  struct __block_impl impl;
    
    //第二部分:
  struct __main_block_desc_0* Desc;
    
    //第三部分:capture捕获的自动变量。函数调用环境 外界的auto变量int age 会捕获到这里
  int age;
    
    // C++ 构造函数。类似OC的init方法。
    // 语法解释
    // 1.C++ 语法可以在一个结构体内定义一个函数。
    // 2.虽然函数没有返回值。但其实会返回一个 创建好的当前结构体
    
  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _age, int flags=0) : age(_age) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
      
    // 3.  : age(_age) 含义就是 外面传递进来的 _age 变量会自动赋值给 age成员。
//      age = _age;
  }
};


// 第四部分: 将代码块{} 转换成的一个函数
// 使用clang转为C++可见  {} 被封装成了函数
// block代码块被封装成了 C/C++函数。
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
  int age = __cself->age; // bound by copy

            // 简化操作,伪代码
            NSLog(这是一个block);
            NSLog(这是一个block);
            NSLog(@"----age:%d",age);
}

int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool; 

        //简化后的代码:删除各种强制类型转换的代码。删除干扰代码，方便看。
        int age = 10;
        
        
        //这就其实就是block代码块{} ,被封装成的函数。 将函数的地址赋值给一个函数指针(就是在main.m中定义的了block名字)
        
        void(*block)(void) = (& (__main_block_func_0, &__main_block_desc_0_DATA, age));

        age = 20;
        
        
        //不是特别明白。将中间的强制类型转换后的代码删掉后的简化代码
        //通过 通过函数指针调用block。
        // -> 访问结构体里面的成员。
        block->FuncPtr(block);
    }
    return 0;
}

