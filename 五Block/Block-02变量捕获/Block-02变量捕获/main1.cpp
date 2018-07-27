
struct __block_impl {
    void *isa;
    int Flags;
    int Reserved;
    void *FuncPtr;
};

//全局变量不会捕获。直接访问。
int globalVar = 100;


struct __main_block_impl_0 {
  struct __block_impl impl;
  struct __main_block_desc_0* Desc;
  int *age;
  float height;
  __main_block_impl_0(void *fp, struct __main_block_desc_0 *desc, int *_age, float _height, int flags=0) : age(_age), height(_height) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __main_block_func_0(struct __main_block_impl_0 *__cself) {
  int *age = __cself->age; // bound by copy
  float height = __cself->height; // bound by copy

            NSLog((NSString *)&__NSConstantStringImpl__var_folders_sw_fglrwts54sq9r773br4nmngm0000gn_T_main_572ec5_mi_0,(*age), height,globalVar);
        }

static struct __main_block_desc_0 {
  size_t reserved;
  size_t Block_size;
} __main_block_desc_0_DATA = { 0, sizeof(struct __main_block_impl_0)};
int main(int argc, const char * argv[]) {
    /* @autoreleasepool */ { __AtAutoreleasePool __autoreleasepool; 
        static int age = 10;  //static 修饰的局部变量被捕获后，通过地址进行访问。
        float height = 45.8;

        void(*block2)(void) = ((void (*)())&__main_block_impl_0((void *)__main_block_func_0, &__main_block_desc_0_DATA, &age, height));

        age = 40;
        height = 66.66;
        globalVar = 8888;

        ((void (*)(__block_impl *))((__block_impl *)block2)->FuncPtr)((__block_impl *)block2);
    }
    return 0;
}

