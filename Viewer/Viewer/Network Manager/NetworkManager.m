//
//  NetworkManager.m
//  Viewer
//

//  Copyright © 2018 Personal. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

+ (void)fetchDatawithCompletion:(void (^)(NSDictionary *data))completionBlock{
    NSURL *url = [NSURL URLWithString:
                  @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
    [NetworkManager retrieveJSONWithConnectionAtURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            NSString *responseString = [[NSString alloc]initWithData:data encoding:kCFStringEncodingUTF8];
            NSData *datanew = [responseString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:datanew options:kNilOptions error:&error];
            completionBlock(jsonResponse);
        }else{
            completionBlock(nil);
        }
    }];
}
//+(void) retrieveJSONAtURL: (NSURL *) url completionHandler: (void (^)(NSData *data, NSURLResponse *response, NSError *error)) handler {
//    NSURLSessionConfiguration *conf = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *sessionWithoutADelegate = [NSURLSession sessionWithConfiguration:conf];
//    NSURLSessionDataTask * task = [sessionWithoutADelegate dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        handler(data, response, error);
//        [sessionWithoutADelegate finishTasksAndInvalidate];
//    }];
//    [task resume];
//}
+(void) retrieveJSONWithConnectionAtURL: (NSURL *) url completionHandler: (void (^)(NSData *data, NSURLResponse *response, NSError *error)) handler {
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            handler(data,response,connectionError);
        }];
    

    

}
@end
