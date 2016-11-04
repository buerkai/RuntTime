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

@interface TestLoad : NSObject<TestProtocol,NSMutableCopying,NSCopying>

@property(nonatomic,strong)NSString *loadName;

-(NSString *)getUserName;
+(NSString *)getUserName2;

-(NSString *)getURL:(NSString *)url withPort:(int)port;
@end
