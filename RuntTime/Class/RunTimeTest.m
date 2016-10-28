//
//  RunTimeTest.m
//  RuntTime
//
//  Created by hyc on 16/10/27.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import "RunTimeTest.h"
#import "TestLoad.h"
@implementation RunTimeTest

+(void)load{
    NSLog(@"loading  RunTimeTest ....");
    //NSLog(@"load=%@",NSStringFromClass([self class]));
}

+(void)initialize{
    NSLog(@"initialize=%@",NSStringFromClass([self class]));
}


//测试NSObject load方法
-(void)test_NSObject_load{
  
}

//测试NSObject initialize方法
-(void)test_NSObject_initialize{
    Class clasz=NSClassFromString(@"TestLoad");
    id obj=[clasz new];
    
    
}

-(void)test_NSObject_isMemberOfClass{
    NSString *testStr=@"11111";
    //NSString *testStr=[NSString new];
    Class testStrClass=[testStr class];
    NSLog(@"%@",testStrClass);//输出 __NSCFConstantString
    Class nsstringClass=[NSString class];
    NSLog(@"%@",nsstringClass);//输出 NSString
    BOOL ismember=[testStr isMemberOfClass:[NSString class]];
    if (ismember) {
        NSLog(@"1");
    }else{
        NSLog(@"2");
    }
    //上面打印结果是:2,
    //为什么会出现这种情况呢？
    //由于NString的底层实现是CFStringRef，操作NSString其实就是在调用底层CF对应的函数。在IOS中NString,NSMutableString, NSArray,NSMutableArray,NSDictionary,NSMutableDictionary,NSSet,NSMutableSet等都有对应的CF类，后续将详细讲解
    
    id test=[TestLoad new];
    BOOL isTestLoad=[test isMemberOfClass:[TestLoad class]];
    if (isTestLoad) {
        NSLog(@"3");
    }else{
        NSLog(@"4");
    }
    //上面打印结果为：3，其中TestLoad是自己实现的一个简单类，继承与NSObject
}

-(void)test_NSObject_isKindOfClass{
    TestLoad *test=[TestLoad new];
    BOOL result0=[test isKindOfClass:[TestLoad class]];
    if (result0) {
        NSLog(@"1");
    }else{
        NSLog(@"2");
    }
    result0=[test isKindOfClass:[NSObject class]];
    if (result0) {
        NSLog(@"3");
    }else{
        NSLog(@"4");
    }
    result0=[TestLoad isSubclassOfClass:[NSObject class]];
    if (result0) {
        NSLog(@"5");
    }else{
        NSLog(@"6");
    }
    result0=[TestLoad isSubclassOfClass:[TestLoad class]];
    if (result0) {
        NSLog(@"7");
    }else{
        NSLog(@"8");
    }
    result0=[TestLoad isKindOfClass:[NSObject class]];
    if (result0) {
        NSLog(@"9");
    }else{
        NSLog(@"10");
    }
       //以上输出为：1，3，5，7,9
}

//
-(void)test_NSObject_respondsToSelector{
    TestLoad *test=[TestLoad new];
    BOOL result=[TestLoad instancesRespondToSelector:NSSelectorFromString(@"load")];
    if (result) {
        NSLog(@"1-1");
    }else{
        NSLog(@"1-0");
    }
    result=[TestLoad instancesRespondToSelector:NSSelectorFromString(@"init")];
    if (result) {
        NSLog(@"2-1");
    }else{
        NSLog(@"2-0");
    }
    result=[TestLoad instancesRespondToSelector:NSSelectorFromString(@"getUserName")];
    if (result) {
        NSLog(@"2-3");
    }else{
        NSLog(@"2-4");
    }
    result=[TestLoad instancesRespondToSelector:NSSelectorFromString(@"getName")];
    if (result) {
        NSLog(@"3-1");
    }else{
        NSLog(@"3-0");
    }
    result=[TestLoad respondsToSelector:NSSelectorFromString(@"getName")];
    if (result) {
        NSLog(@"4-1");
    }else{
        NSLog(@"4-0");
    }
    result=[TestLoad respondsToSelector:NSSelectorFromString(@"getUserName")];
    if (result) {
        NSLog(@"4-3");
    }else{
        NSLog(@"4-4");
    }
    
    result=[test respondsToSelector:NSSelectorFromString(@"getName")];
    if (result) {
        NSLog(@"5-1");
    }else{
        NSLog(@"5-0");
    }
    //输出结果为：
//    2016-10-28 15:49:42.127 RuntTime[2165:1008788] 1-0
//    2016-10-28 15:49:42.128 RuntTime[2165:1008788] 2-1
//    2016-10-28 15:49:42.128 RuntTime[2165:1008788] 2-3
//    2016-10-28 15:49:42.128 RuntTime[2165:1008788] 3-1
//    2016-10-28 15:49:42.128 RuntTime[2165:1008788] 4-0
//    2016-10-28 15:49:42.128 RuntTime[2165:1008788] 4-4
//    2016-10-28 15:49:42.129 RuntTime[2165:1008788] 5-1
    
    //为什么+ (BOOL)respondsToSelector:(SEL)sel不能检查类中是否存在某个方法呢？
    //其主要原因还是回到了-self 和 +self 问题上，查看其源码：
//    + (BOOL)respondsToSelector:(SEL)sel {
//        if (!sel) return NO;
//        return class_respondsToSelector_inst(object_getClass(self), sel, self);
//    }
//    
//    - (BOOL)respondsToSelector:(SEL)sel {
//        if (!sel) return NO;
//        return class_respondsToSelector_inst([self class], sel, self);
//    }
    
    //类方法中的self其实为当前类的Class,object_getClass获取的是当前Class的Class,而不是当前类的Class对象，所有此方法永远不能检查类中的方法是否存在
}
-(void)test_NSObject_conformsToProtocol{
    TestLoad *test=[TestLoad new];
    BOOL result=[TestLoad conformsToProtocol:@protocol(TestProtocol)];
    if (result) {
        NSLog(@"1-1");
    }else{
        NSLog(@"1-0");
    }
    result=[test conformsToProtocol:@protocol(TestProtocol)];
    if (result) {
        NSLog(@"1-3");
    }else{
        NSLog(@"1-4");
    }
    
    //NSObject是protocol
    result=[test conformsToProtocol:@protocol(NSObject)];
    if (result) {
        NSLog(@"1-5");
    }else{
        NSLog(@"1-6");
    }
   //输出结果：
//    2016-10-28 16:12:56.389 RuntTime[2284:1132797] 1-1
//    2016-10-28 16:12:56.389 RuntTime[2284:1132797] 1-3
//    2016-10-28 16:12:56.389 RuntTime[2284:1132797] 1-5

}
-(void)test_NSObject_performSelector{
    //如果此处执行的是getUserName，将会报异常，找不到此方法
    id result=[TestLoad performSelector:NSSelectorFromString(@"getUserName2")];
    NSLog(@"%@",result);
    TestLoad *test=[TestLoad new];
     //如果此处执行的是getUserName2，将会报异常，找不到此方法
     result=[test performSelector:NSSelectorFromString(@"getUserName")];
    NSLog(@"%@",result);
}
@end
