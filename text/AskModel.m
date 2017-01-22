//
//  AskModel.m
//  text
//
//  Created by CSX on 2017/1/22.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "AskModel.h"

@implementation AskModel

- (instancetype)initWithDictory:(NSDictionary *)dic{
    if ([super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}



@end
