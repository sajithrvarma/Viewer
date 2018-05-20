//
//  ViewController.h
//  Viewer
//

//  Copyright © 2018 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    dispatch_queue_t queue;
    dispatch_queue_t main;
}
@property(nonatomic,strong) UITableView *imageLoader;
@property(nonatomic,strong) NSArray* imageDataList;
@property(nonatomic,strong) NSString* navTitle;
@end

