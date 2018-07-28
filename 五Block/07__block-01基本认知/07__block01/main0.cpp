

//第一部分 __block_impl 结构体。
struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

//第二部分: block的描述信息 desc
static struct __main_block_desc_0 {
    size_t reserved;
    size_t Block_size;
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};


//block结构体。__main_block_impl_0
struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
    
    
    //第三部分:block 内部捕获的自动变量。
  int age;
    
    //C语言的构造函数。
  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int _age, int flags=0) : age(_age) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};


//第四部分: block代码会被封装成了函数。  __main_block_func_0
//block是封装了函数调用和函数调用环境的OC对象。
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
  int age = __cself->age; // bound by copy

            NSLog((NSString *)&__NSConstantStringImpl__var_folders_sw_fglrwts54sq9r773br4nmngm0000gn_T_main_023c15_mi_0,age);
        }



typedef void(*RBBlock)(void);

int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool; 

        int age = 10;
        RBBlock block1 = (&__main_block_impl_0(__main_block_func_0, &__main_block_desc_0_DATA, age));

        age = 200;
        block1->FuncPtr(block1);
    }
    return 0;
}

