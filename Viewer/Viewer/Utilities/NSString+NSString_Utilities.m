//
//  NSString+NSString_Utilities.m
//  Viewer
//

//  Copyright © 2018 Personal. All rights reserved.
//

#import "NSString+NSString_Utilities.h"

@implementation NSString (NSString_Utilities)
-(BOOL)isValidText{
    if (self == nil || [self isKindOfClass:[NSNull class]]) {
        return false;
    }else{
        return true;
    }
}
@end
