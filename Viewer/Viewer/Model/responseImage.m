//
//  responseImage.m
//  Viewer
//

//  Copyright © 2018 Personal. All rights reserved.
//

#import "responseImage.h"
#import "ConstantsHeader.h"

@implementation responseImage
- (instancetype)initWithDictionay:(NSDictionary*)details
{
    self = [super init];
    if (self) {
            if ([details objectForKey:KeyTitle] && ![[details objectForKey:KeyTitle] isKindOfClass:[NSNull class]] ) {
                  self.title = [details objectForKey:KeyTitle];
            }
        if ([details objectForKey:KeyImageUrl] && ![[details objectForKey:KeyImageUrl] isKindOfClass:[NSNull class]] ) {
            self.imageURL = [details objectForKey:KeyImageUrl];
        }
        if ([details objectForKey:KeyDecription] && ![[details objectForKey:KeyDecription] isKindOfClass:[NSNull class]]) {
            self.descriptionText = [details objectForKey:KeyDecription];
        }
    }
    return self;
}
@end
