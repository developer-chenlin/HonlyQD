//
//  HttpTool.h
//  HonlyQD
//
//  Created by 陈林 on 2017/11/13.
//  Copyright © 2017年 陈林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>


 

typedef NS_ENUM(NSInteger,HttpMethod) {
    GET = 1,
    POST = 2
};






@interface HttpTool : NSObject

@property (nonatomic,strong)AFHTTPSessionManager *manager;




/**
 AFNetWorking 请求封装

 @param httpMethod GET ／ POST
 @param parameter 请求参数
 @param api 请求api（不包含IP）
 @param success 请求成功回掉
 @param failed 请求失败回掉
 */
+(void)HttpRequestWithMethod:(HttpMethod)httpMethod
                   parameter:(NSDictionary *)parameter
                         api:(NSString *)api
                     success:(void(^)(id responseObject))success
                      failed: (void(^)(NSError *error))failed;
@end
