
//
//  responseImage.h
//  Viewer
//

//  Copyright © 2018 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+NSString_Utilities.h"
#import "ViewController.h"
@interface responseImage : NSObject
{
    
}
@property(nonatomic,strong) NSString *imageURL;
@property(nonatomic,strong) NSString* title;
@property(nonatomic,strong) NSString* descriptionText;
- (instancetype)initWithDictionay:(NSDictionary*)details;
@end
