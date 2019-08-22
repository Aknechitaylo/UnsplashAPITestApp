//
//  ANServerManager.h
//  UnsplashAPITestApp
//
//  Created by Андрей on 31.07.2019.
//  Copyright © 2019 Андрей. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface ANServerManager : NSObject

+ (ANServerManager *)sharedManager;

- (void)getPhotosFromServerWithQuery:(NSString *)query
                     quantityPerPage:(NSUInteger)quantity
                           onSuccess:(void(^)(NSArray *photos))success
                           onFailure:(void(^)(NSError *error, NSUInteger statusCode))failure;

@end

NS_ASSUME_NONNULL_END
