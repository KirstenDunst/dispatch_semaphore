//
//  AMToolHttp.m
//  ZSAgencyManage
//
//  Created by CSX on 2016/12/21.
//  Copyright © 2016年 宗盛商业. All rights reserved.
//

#import "AMToolHttp.h"
#import <AFNetworking.h>

@implementation AMToolHttp
+(void)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(id))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
    {
//        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
//        
//        config.timeoutIntervalForRequest = 15.0;
        
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
      
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
       
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
        
        [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                progress(downloadProgress);
            }
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        
    }
    
    
+(void)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(id))progress success:(void (^)(id))success failure:(void (^)(NSError *))failure
    {
        // 获取http请求管理者
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
        [contentTypes addObject:@"text/html"];
        [contentTypes addObject:@"text/plain"];
        manager.responseSerializer.acceptableContentTypes = contentTypes;
        [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            if (progress) {
                progress(uploadProgress);
            }
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
        
        
    }
@end
