//
//  NetworkManager.h
//  Viewer
//

//  Copyright © 2018 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject
+ (void)fetchDatawithCompletion:(void (^)(NSDictionary *data))data;
+(void) retrieveJSONAtURL: (NSURL *) url completionHandler: (void (^)(NSData *data, NSURLResponse *response, NSError *error)) handler ;

@end
