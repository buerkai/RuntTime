//
//  RunTimeTest.m
//  RuntTime
//
//  Created by hyc on 16/10/27.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import "RunTimeTest.h"
#import "TestLoad.h"
#import <objc/runtime.h>
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
-(void)test_NSObject_copy{
    TestLoad *load=[TestLoad new];
    load.loadName=@"aaaaa";
    NSDictionary *dd=@{@"key":@"value"};
    NSDictionary *cc=[dd copy];
    if (dd==cc) {
        NSLog(@"1111");
    }else{
        NSLog(@"2222");
    }
    NSDictionary *bb=[dd mutableCopy];
    if (dd==bb) {
        NSLog(@"3");
    }else{
        NSLog(@"4");
    }
    TestLoad *b=[load mutableCopy];
    NSLog(@"%@",b.loadName);

    TestLoad *a=[load copy];
    NSLog(@"%@",a.loadName);
}

-(void)test_runTime_01{
    //
    TestLoad *load=[TestLoad new];
    load.loadName=@"testLoad....aadsf";
    Class class01=object_getClass(load);
    if (class01== [TestLoad class]) {
        NSLog(@"q1");
    }else{
        NSLog(@"q2");
    }
    //object_isClass  判断是否是Class
    NSLog(@"object_isClass %d",object_isClass(load));
    NSLog(@"object_isClass %d",object_isClass(class01));
    
    //获取类名
    const char *className00=object_getClassName(load);
    NSLog(@"TestLoad class name is %s",className00);

    //测试改变类
    BOOL testChangeClass=NO;
    if (testChangeClass) {
        //设置Class
        Class class02=object_setClass(load, [NSString class]);
        if (class02) {
            NSLog(@"修改Class成功");
        }
        //获取类名称
        const char *className01=object_getClassName(load);
        NSLog(@"TestLoad class name is %s",className01);
        
        SEL sel=NSSelectorFromString(@"uppercaseString");
        if ([load respondsToSelector:sel]) {
            //是从Class中检查是否有此方法
            id out01=[load performSelector:sel];
            NSLog(@"%@",out01);
        }
    }
    
    
    
    
    //测试获取类属性
    
    BOOL testProp=NO;
    if (testProp) {
        const char *prop01Name="loadName";
        //class_getClassVariable
        Ivar prop01Var=class_getInstanceVariable(class01,prop01Name);
        if (prop01Var) {
            id prop01= object_getIvar(load, prop01Var);
            NSLog(@"%@",prop01);
        }else{
            NSLog(@"属性不存在");
        }
        
        //获取属性
        unsigned int propCount=0;
        Ivar *list= class_copyIvarList(class01,&propCount);
        if (list) {
            for (int i=0; i<propCount; i++) {
                Ivar item=list[i];
                //获取名称，都以_开头
                const char *propName=ivar_getName(item);
                //获取数据类型
                const char *propType=ivar_getTypeEncoding(item);
                 NSLog(@"属性名称：%s,type=%s",propName,propType);
            
               
            }
        }
        free(list);
       
        
        //获取属性
        objc_property_t *props=class_copyPropertyList(class01, &propCount);
        if (props) {
            for (int i=0; i<propCount; i++) {
                objc_property_t p=props[i];
                //属性名称,不以_开头
                const char* pname=property_getName(p);
                const char * p_patr=property_getAttributes(p);
                NSLog(@"pname=%s,属性=%s",pname,p_patr);
                unsigned int pcount=0;
                objc_property_attribute_t *ps=property_copyAttributeList(p, &pcount);
                if (ps) {
                    for (int n=0; n<pcount; n++) {
                        objc_property_attribute_t pt=ps[i];
                        NSLog(@"属性 name=%s,value=%s",pt.name,pt.value);
                    }
                }
                free(ps);
                //free(&pcount);
            }
        }
        free(props);
        
        objc_property_t loadNamep=class_getProperty(class01, "loadName");
        if (loadNamep) {
            const char* pname=property_getName(loadNamep);
            const char * p_patr=property_getAttributes(loadNamep);
            NSLog(@"pname=%s,属性=%s",pname,p_patr);

        }
        
    }
    
    //Method
    BOOL testMethod=YES;
    if (testMethod) {
        unsigned int methodCount=0;
        Method *methods=class_copyMethodList(class01, &methodCount);
        for (int i=0; i<methodCount; i++) {
            Method method=methods[i];
            NSLog(@"方法名称:%@",NSStringFromSelector(method_getName(method)));
            NSLog(@"方法参数个数:%d",method_getNumberOfArguments(method));
            size_t returnTypeLen=1024;

            char *retrurnType=(char*)malloc(returnTypeLen);
            method_getReturnType(method, retrurnType, returnTypeLen);
            NSLog(@"方法返回类型:%s,len=%ld",retrurnType,returnTypeLen);
            free(retrurnType);
           
            //获取参数类型
            unsigned int argCount=method_getNumberOfArguments(method);
            if (argCount>0) {
                for (int n=0; n<argCount; n++) {
                    char *argType=method_copyArgumentType(method, n);
                    NSLog(@"参数类型:%s",argType);
                }
            }
             NSLog(@"----------");
        }
        
        //获取对象方法-(NSString *)getUserName
        Method test=class_getInstanceMethod(class01, NSSelectorFromString(@"getUserName"));
        IMP testIMP=method_getImplementation(test);
        id block= imp_getBlock(testIMP);
        if (block) {
            NSLog(@"%@",block);
        }
        //修改方法体
        IMP createIMP=imp_implementationWithBlock((NSString *)^(void){
            return @"cccccccc";
        });
        IMP retIMP= method_setImplementation(test, createIMP);
        if (retIMP) {
            NSLog(@"%@",[load getUserName]);
        }
        //再次获取方法体
        testIMP=method_getImplementation(test);
        block= imp_getBlock(testIMP);
        if (block) {
            NSLog(@"%@",block);
        }
        
        
        //动态添加方法
        IMP insertIMP=imp_implementationWithBlock((NSString *)^(id target,NSString *p1,NSString *p2){
            return [NSString  stringWithFormat:@" ret=%@,%@",p1,p2];
        });
        BOOL addOKMethod= class_addMethod(class01, NSSelectorFromString(@"getTest:withUserName"),insertIMP,0);
        if (addOKMethod) {
            NSLog(@"add method ret=%@",[load performSelector:NSSelectorFromString(@"getTest:withUserName") withObject:@"1111" withObject:@"2222"]);
        }
        
        //获取类方法 +(NSString *)getUserName2;
       Method getMethod= class_getClassMethod(class01, NSSelectorFromString(@"getUserName2"));
        if (getMethod) {
            NSLog(@"getUserName2 方法存在");
            NSLog(@"方法返回值:%@",[class01 performSelector:NSSelectorFromString(@"getUserName2")]);
        }
                                                  
    }
}
@end
