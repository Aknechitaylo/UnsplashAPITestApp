//
//  ANServerManager.m
//  UnsplashAPITestApp
//
//  Created by Андрей on 31.07.2019.
//  Copyright © 2019 Андрей. All rights reserved.
//

#import "ANServerManager.h"
#import "AFNetworking.h"



@interface ANServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestManager;

@end


@implementation ANServerManager

+ (ANServerManager *)sharedManager {
    
    static ANServerManager *serverManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serverManager = [ANServerManager new];
    });
    
    return serverManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *baseURL = [NSURL URLWithString:@"https://api.unsplash.com/"];
        self.requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    }
    return self;
}

- (void)getPhotosFromServerWithQuery:(NSString *)query
                     quantityPerPage:(NSUInteger)quantity
                           onSuccess:(void(^)(NSArray *photos))success
                           onFailure:(void(^)(NSError *error, NSUInteger statusCode))failure {
    
    // GET request example: @"https://api.unsplash.com/search/photos?page=1&query=office"

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
    NSDictionary *configuration = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    NSString *clientID = configuration[@"Client_ID"];
    
    NSDictionary *params = @{@"query"     : query,
                             @"per_page"  : @(quantity),
                             @"client_id" : clientID};
//    search/photos - GET запрос
    [self.requestManager GET:@"search/photos"
                  parameters:params
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                         NSLog(@"JSON: %@", responseObject);
                         NSArray *dictsArray = [responseObject objectForKey:@"results"];
                         NSMutableArray *photosUrls = [NSMutableArray array];

                         for (NSDictionary *dict in dictsArray) {
                             NSString *urlString = [[dict objectForKey:@"urls"] objectForKey:@"regular"];
                             NSURL *imageURL = [NSURL URLWithString:urlString];
                             [photosUrls addObject:imageURL];
                         }
                         
                         if (success)
                             success(photosUrls);
                     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         NSLog(@"Error: %@", error);
                         if (failure)
                             failure(error, operation.response.statusCode);
                     }];
}



@end
