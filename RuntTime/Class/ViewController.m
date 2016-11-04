//
//  ViewController.m
//  RuntTime
//
//  Created by hyc on 16/10/27.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *testArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _testArray=@[].mutableCopy;
    //
    [_testArray addObject:@{@"name":@"测试NSObject load方法",@"action":@"test_NSObject_load"}];
    [_testArray addObject:@{@"name":@"测试NSObject initialize方法",@"action":@"test_NSObject_initialize"}];
    [_testArray addObject:@{@"name":@"测试NSObject isMemberOfClass方法",@"action":@"test_NSObject_isMemberOfClass"}];
[_testArray addObject:@{@"name":@"测试NSObject isKindOfClass方法",@"action":@"test_NSObject_isKindOfClass"}];
    [_testArray addObject:@{@"name":@"测试NSObject respondsToSelector方法",@"action":@"test_NSObject_respondsToSelector"}];
    [_testArray addObject:@{@"name":@"测试NSObject conformsToProtocol方法",@"action":@"test_NSObject_conformsToProtocol"}];
     [_testArray addObject:@{@"name":@"测试NSObject performSelector方法",@"action":@"test_NSObject_performSelector"}];
    [_testArray addObject:@{@"name":@"测试NSObject copy方法",@"action":@"test_NSObject_copy"}];
    [_testArray addObject:@{@"name":@"测试Runtime01",@"action":@"test_runTime_01"}];

    
    long hash=self.hash;
     NSLog(@"%ld",hash);
  Class class2=  [NSMutableArray self];
    NSLog(@"%@",class2);
    
   }



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _testArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"testcell"];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testcell"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    }
    
    [cell.textLabel setText:[_testArray objectAtIndex:indexPath.row][@"name"] ];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *item=[_testArray objectAtIndex:indexPath.row];
    if (!item) {
        NSLog(@"测试案例不存在");
        return;
    }
    Class test=NSClassFromString(@"RunTimeTest");
    SEL sel=NSSelectorFromString(item[@"action"]);
    //Method imp=class_getClassMethod(test, sel);
    //NSInvocation
    id obj=[test new];
    if ([obj respondsToSelector:sel]) {
         [obj performSelector:sel withObject:nil];
    }
   
}



@end
