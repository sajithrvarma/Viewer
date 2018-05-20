//
//  responseImage.h
//  Viewer
//

//  Copyright © 2018 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface responseImage : NSObject
@property(nonatomic,strong) NSString *imageURL;
@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* descriptionText;
- (instancetype)initWithDictionay:(NSDictionary*)details;
@end
