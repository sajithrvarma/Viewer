//
//  ImageTableViewCell.m
//  Viewer
//
//  Created by Applied Materials on 20/05/18.
//  Copyright © 2018 Personal. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "Constants.h"
@implementation ImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:
(NSString *)reuseIdentifier

{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _imageContainer = [[UIImageView alloc] initWithFrame:CGRectMake(4.0f, 3.0f, 39.0f,
                                                               38.0f)];
        _title = [[UILabel alloc] initWithFrame:CGRectMake(58.0f, 8.0f, 50.0f,
                                                                27.0f)];
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(120.0f, 8.0f, 50.0f,
                                                           27.0f)];
        [self.contentView addSubview:_imageContainer];
        [self.contentView addSubview:_title];
        [self.contentView addSubview:_descriptionLabel];
        //[self addConstraints:_descriptionLabel];
    }
    return self;
}
-(void)setupCell:(responseImage *)imageDetails{
    if (imageDetails.title) {
          _title.text = imageDetails.title;
    }
    if (imageDetails.descriptionText) {
        _descriptionLabel.text = imageDetails.descriptionText;
    }
    dispatch_async(dispatch_queue_create("com.app.task",NULL), ^{
        NSURL *url = [NSURL URLWithString:imageDetails.imageURL];
        UIImage *profile = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // do work here
            if (profile){
                [self.imageContainer setImage:profile];
            }
            //
        });
    });
}
-(void)addConstraints:(UIView*)view{
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    /* Leading space to superview */
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint
                                          constraintWithItem:view attribute:NSLayoutAttributeLeft
                                          relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:
                                          NSLayoutAttributeLeft multiplier:1.0 constant:0];
    /* Top space to superview Y*/
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint
                                         constraintWithItem:view attribute:NSLayoutAttributeTop
                                         relatedBy:NSLayoutRelationEqual toItem:self attribute:
                                         NSLayoutAttributeTop multiplier:1.0f constant:0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint
                                           constraintWithItem:view attribute:NSLayoutAttributeRight
                                           relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:
                                           NSLayoutAttributeLeft multiplier:1.0 constant:0];
    /* Top space to superview Y*/
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint
                                            constraintWithItem:view attribute:NSLayoutAttributeBottom
                                            relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:
                                            NSLayoutAttributeTop multiplier:1.0f constant:0];
    [self.contentView addConstraints:@[leftConstraint,topConstraint,
                                rightConstraint,bottomConstraint]];
    [self.contentView layoutIfNeeded];
}

@end
