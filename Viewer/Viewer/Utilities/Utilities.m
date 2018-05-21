//
//  Utilities.m
//  Viewer
//

//  Copyright © 2018 Personal. All rights reserved.
//

#import "Utilities.h"

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
