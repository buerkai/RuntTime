//
//  TestLoad.m
//  RuntTime
//
//  Created by hyc on 16/10/27.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import "TestLoad.h"
#import <objc/runtime.h>
@interface TestLoad()

@property(nonatomic,strong)NSMutableArray *testArray;

@property(nonatomic,assign)UInt8 *testUint8;

@property(nonatomic,assign)BOOL *testBool;

@property(nonatomic,assign)float *testFloat;
@end


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


- (id)mutableCopyWithZone:(nullable NSZone *)zone{
    return self;
}

- (id)copyWithZone:(nullable NSZone *)zone{
    return self;
}

-(NSString *)getURL:(NSString *)url withPort:(int)port{
    return [NSString stringWithFormat:@"%@:%d",url,port];
}
@end
