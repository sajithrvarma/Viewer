//
//  NetworkManager.h
//  Viewer
//
//  Created by Applied Materials on 20/05/18.
//  Copyright © 2018 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkManager : NSObject{
   
}
+ (void)fetchDatawithCompletion:(void (^)(NSDictionary *data))data;


@end
