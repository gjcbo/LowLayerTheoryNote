//
//  Person+Test.h
//  01-给Category添加属性
//
//  Created by RaoBo on 2018/7/25.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import "Person.h"

@interface Person (Test)
{
//    Instance variables may not be placed in categories(成员变量不能放在Category中)
//    double height;
}
//@property (nonatomic, assign) int age;

@property (nonatomic, assign) float weight;


/**基本认知
 1. 成员变量(ivars)不能写在 Category中
 2. @property属性可以写在 Category中, 但是不会生成 _成员变量+ setter + getter方法 。如果在外面调用 self.age 会奔溃的。爆unrecognized selector send to xxxx 。应为没有生成setter和getter所以找不到。直接报错。
 3. 就是想在分类里面添加属性，怎么了？怎么做？答:关联对象。
 
 4.步骤: 应为不会实现setter + getter，所以要自己实现setter 和 getter方法。
 */
@end
