//
//  TestLoad.h
//  RuntTime
//
//  Created by hyc on 16/10/27.
//  Copyright © 2016年 baohe. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol TestProtocol

@optional
-(void)getName;

@end

@interface TestLoad : NSObject<TestProtocol>

-(NSString *)getUserName;
+(NSString *)getUserName2;
@end
