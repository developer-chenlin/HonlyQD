//
//  HttpTool.m
//  HonlyQD
//
//  Created by 陈林 on 2017/11/13.
//  Copyright © 2017年 陈林. All rights reserved.
//

#import "HttpTool.h"

#define IP @"cc"


@implementation HttpTool


+(HttpTool *)shareStance {
    static HttpTool *shareInstance;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        shareInstance = [[HttpTool alloc] init];
        shareInstance.manager = [AFHTTPSessionManager manager];
        shareInstance.manager .requestSerializer = [AFHTTPRequestSerializer  serializer];
        shareInstance.manager .responseSerializer = [AFHTTPResponseSerializer serializer];
        shareInstance.manager .responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    });
    return shareInstance;
}




+(void)HttpRequestWithMethod:(HttpMethod)httpMethod
                   parameter:(NSDictionary *)parameter
                         api:(NSString *)api
                     success:(void(^)(id responseObject))success
                      failed: (void(^)(NSError *error))failed{
   
    switch (httpMethod) {
        case GET:
            [[HttpTool shareStance] getRequestWithApi:api parameter:parameter success:success failed:failed];
            break;
            case POST:
            [[HttpTool shareStance] postRequestWithApi:api parameter:parameter success:success failed:failed];
            break;
        default:
            break;
    }
    
}
 






///get 请求
-(void)getRequestWithApi:(NSString *)api
               parameter:(NSDictionary *)parameter
                 success:(void(^)(id responseObject))success
                  failed: (void(^)(NSError *error))failed {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"%@%@",IP,api] parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}




///post 请求
-(void)postRequestWithApi:(NSString *)api
                parameter:(NSDictionary *)parameter
                  success:(void(^)(id responseObject))success
                   failed: (void(^)(NSError *error))failed {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:[NSString stringWithFormat:@"%@%@",IP,api] parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failed(error);
    }];
}











@end
