//
//  NSObject+Swizzing.h
//  runtime消息转发
//
//  Created by RaoBo on 2018/8/5.
//  Copyright © 2018年 RaoBo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzing)

+ (void)rb_swizzingOriginSelector:(SEL)originSel swizzledSelector:(SEL)swizzledSel;

@end
