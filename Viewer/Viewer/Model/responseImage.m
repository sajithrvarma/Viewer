//
//  responseImage.m
//  Viewer
//

//  Copyright © 2018 Personal. All rights reserved.
//

#import "responseImage.h"
#import "NSString+NSString_Utilities.h"
@implementation responseImage
- (instancetype)initWithDictionay:(NSDictionary*)details
{
    self = [super init];
    if (self) {
            if ([details objectForKey:@"title"] && ![[details objectForKey:@"title"] isKindOfClass:[NSNull class]] ) {
                  self.title = [details objectForKey:@"title"];
            }
        if ([details objectForKey:@"imageHref"] && ![[details objectForKey:@"imageHref"] isKindOfClass:[NSNull class]] ) {
            self.imageURL = [details objectForKey:@"imageHref"];
        }
        if ([details objectForKey:@"description"] && ![[details objectForKey:@"description"] isKindOfClass:[NSNull class]]) {
            self.descriptionText = [details objectForKey:@"description"];
        }
    }
    return self;
}

@end
