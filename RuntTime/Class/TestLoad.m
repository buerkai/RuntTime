//
//  TestLoad.m
//  RuntTime
//
//  Created by hyc on 16/10/27.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import "TestLoad.h"
#import <objc/runtime.h>
@implementation TestLoad

-(id)init{
     //Class c=object_getClass(self);
    self=[super init];
//    BOOL result=[TestLoad respondsToSelector:NSSelectorFromString(@"getUserName")];
//    if (result) {
//        NSLog(@"4-1");
//    }else{
//        NSLog(@"4-0");
//    }

    return self;
}

+(void)load{
    NSLog(@"load...");
}

+(void)initialize{
//     Class c=object_getClass(self);
//    NSLog(@"%@",c);
//    BOOL result=[TestLoad respondsToSelector:NSSelectorFromString(@"getUserName")];
//    if (result) {
//        NSLog(@"4-1");
//    }else{
//        NSLog(@"4-0");
//    }

    NSLog(@"initialize....");
}

-(void)getName{
    NSLog(@"getName");
}

-(NSString *)getUserName{
    return @"test";
}

+(NSString *)getUserName2{
    return @"test2";
}
@end
