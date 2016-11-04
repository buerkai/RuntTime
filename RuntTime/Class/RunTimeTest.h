//
//  RunTimeTest.h
//  RuntTime
//
//  Created by hyc on 16/10/27.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RunTimeTest : NSObject

//测试NSObject load方法
-(void)test_NSObject_load;

//测试NSObject initialize方法
-(void)test_NSObject_initialize;
//
-(void)test_NSObject_isMemberOfClass;

//
-(void)test_NSObject_isKindOfClass;

//
-(void)test_NSObject_respondsToSelector;

-(void)test_NSObject_conformsToProtocol;

-(void)test_NSObject_performSelector;

-(void)test_NSObject_copy;

//测试runtimg
-(void)test_runTime_01;
@end
