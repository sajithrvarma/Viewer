//
//  Utilities.m
//  Viewer
//
//  Created by Applied Materials on 20/05/18.
//  Copyright © 2018 Personal. All rights reserved.
//

#import "Utilities.h"
#import "responseImage.h"
#import "NSString+NSString_Utilities.h"
@implementation Utilities
+(NSArray*)parseDictionaryListToImageModelList:(NSArray *)dictionaryList{
    NSMutableArray *resultList = [[NSMutableArray alloc]init];
    for (NSDictionary *element in dictionaryList) {
        if ([element isKindOfClass:[NSDictionary class]]) {
            responseImage *image = [[responseImage alloc ]initWithDictionay:element];
            [resultList addObject:image];
        }
    }
    return resultList;
}

@end