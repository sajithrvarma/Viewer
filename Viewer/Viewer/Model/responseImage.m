//
//  responseImage.m
//  Viewer
//

//  Copyright © 2018 Personal. All rights reserved.
//

#import "responseImage.h"
#import "NSString+NSString_Utilities.h"
#import "Constants.h"
@implementation responseImage
- (instancetype)initWithDictionay:(NSDictionary*)details
{
    self = [super init];
    if (self) {
            if ([details objectForKey:imageKeytitle] && ![[details objectForKey:imageKeytitle] isKindOfClass:[NSNull class]] ) {
                  self.title = [details objectForKey:imageKeytitle];
            }
        if ([details objectForKey:imageKeyImageUrl] && ![[details objectForKey:imageKeyImageUrl] isKindOfClass:[NSNull class]] ) {
            self.imageURL = [details objectForKey:imageKeyImageUrl];
        }
        if ([details objectForKey:imageKeyImageDecription] && ![[details objectForKey:imageKeyImageDecription] isKindOfClass:[NSNull class]]) {
            self.descriptionText = [details objectForKey:imageKeyImageDecription];
        }
    }
    return self;
}
@end
