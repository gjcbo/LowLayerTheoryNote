



typedef void(*RBBlock)(void);


//被__block 修饰的变量被包装成了OC对象。
struct __Block_byref_age_0 {
  void *__isa; //有isa ---->OC 对象
__Block_byref_age_0 *__forwarding;
 int __flags;
 int __size;
 int age;
};

struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};


struct __main_block_impl_0 {
  struct __block_impl impl; //__block_impl 结构体
    
  struct __main_block_desc_0* Desc; //block的描述信息
    
  __Block_byref_age_0 *age; // by ref __blcok修饰的auto变量被包装成OC对象。
    
    // C++构造函数。
  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, __Block_byref_age_0 *_age, int flags=0) : age(_age->__forwarding) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};


// block块被封装成函数。 __main_block_func_0
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
  __Block_byref_age_0 *age = __cself->age; // bound by ref

            NSLog((NSString *)&__NSConstantStringImpl__var_folders_sw_fglrwts54sq9r773br4nmngm0000gn_T_main_faba5f_mi_0,(age->__forwarding->age));
        }
static void __main_block_copy_0(struct __main_block_impl_0*dst, struct __main_block_impl_0*src) {_Block_object_assign((void*)&dst->age, (void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);}

static void __main_block_dispose_0(struct __main_block_impl_0*src) {_Block_object_dispose((void*)src->age, 8/*BLOCK_FIELD_IS_BYREF*/);}


//如果是对象类型。会进行内存管理。
// copy      拷贝内存。
// dispose   处置。
static struct __main_block_desc_0 {
  size_t reserved;
  size_t Block_size;
  void (*copy)(struct __main_block_impl_0*, struct __main_block_impl_0*);
  void (*dispose)(struct __main_block_impl_0*);
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0), __main_block_copy_0, __main_block_dispose_0};
int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool; 

       __attribute__((__blocks__(byref))) __Block_byref_age_0 age = {(void*)0,(__Block_byref_age_0 *)&age, 0, sizeof(__Block_byref_age_0), 10};
        RBBlock block1 = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, (__Block_byref_age_0 *)&age, 570425344));

        (age.__forwarding->age) = 200;
        ((void (*)(__block_impl *))((__block_impl *)block1)->FuncPtr)((__block_impl *)block1);
    }
    return 0;
}

