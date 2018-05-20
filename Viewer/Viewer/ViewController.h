//
//  ViewController.h
//  Viewer
//
//  Created by Applied Materials on 20/05/18.
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

