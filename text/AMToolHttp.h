//
//  AMToolHttp.h
//  ZSAgencyManage
//
//  Created by CSX on 2016/12/21.
//  Copyright © 2016年 宗盛商业. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMToolHttp : NSObject
+ (void)GET:(NSString *)URLString parameters:(id)parameters progress:(void (^)(id downloadProgress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
    
    
    
+ (void)POST:(NSString *)URLString parameters:(id)parameters progress:(void (^)(id downloadProgress))progress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
