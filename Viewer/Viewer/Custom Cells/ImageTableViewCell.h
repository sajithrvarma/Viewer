//
//  ImageTableViewCell.h
//  Viewer
//
//  Created by Applied Materials on 20/05/18.
//  Copyright © 2018 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "responseImage.h"
#import "ViewController.h"
@interface ImageTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView * imageContainer;
@property(nonatomic,strong)  UILabel *title;
@property(nonatomic,strong)  UILabel *descriptionLabel;
-(void)setupCell:(responseImage *)imageDetails;
@end