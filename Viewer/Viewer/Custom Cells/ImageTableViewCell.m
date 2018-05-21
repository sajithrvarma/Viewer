//
//  ImageTableViewCell.m
//  Viewer
//
//  Copyright © 2018 Personal. All rights reserved.
//

#import "ImageTableViewCell.h"

@interface ImageTableViewCell (){
    dispatch_queue_t queue ;
    dispatch_queue_t main ;
}
@end
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
        queue = dispatch_queue_create("com.app.viewer",NULL);
        main = dispatch_get_main_queue();
    }
    return self;
}
-(void)setupCell:(responseImage *)imageDetails{
    [self addCellComponents];
    [self layoutCell];
    if (imageDetails.title) {
          self.title.text = imageDetails.title;
    }
    if (imageDetails.descriptionText) {
        self.descriptionLabel.text = imageDetails.descriptionText;
    }
    dispatch_async(queue, ^{
        NSURL *url = [NSURL URLWithString:imageDetails.imageURL];
        UIImage *profile = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        dispatch_async(main, ^{
            if (profile &&self.imageContainer ){
                [self.imageContainer setImage:profile];
            }
        });
    });
}
-(void)addCellComponents{
    if (_imageContainer) {
        [_imageContainer removeFromSuperview];
    }
    if (_descriptionLabel) {
        [_descriptionLabel removeFromSuperview];
    }
    if (_title) {
        [_title removeFromSuperview];
    }
    _imageContainer = [[UIImageView alloc] initWithFrame:CGRectMake(4.0f, 3.0f, 39.0f,38.0f)];
    [_imageContainer setContentMode:UIViewContentModeScaleAspectFit];
    _title = [[UILabel alloc] initWithFrame:CGRectMake(58.0f, 8.0f, 50.0f,27.0f)];
    _title.textAlignment = NSTextAlignmentCenter;
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(120.0f, 8.0f, 50.0f,27.0f)];
    [self.contentView addSubview:_imageContainer];
    [self.contentView addSubview:_title];
    [self.contentView addSubview:_descriptionLabel];
}
-(void)layoutCell{
    UILayoutGuide *marginGuide = [self.contentView layoutMarginsGuide];
    //desc
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
    [[self.descriptionLabel.topAnchor constraintEqualToAnchor:marginGuide.topAnchor] setActive:YES] ;
     [[self.descriptionLabel.leadingAnchor constraintEqualToAnchor:self.title.trailingAnchor] setActive:YES] ;
    [[self.descriptionLabel.bottomAnchor constraintEqualToAnchor:marginGuide.bottomAnchor] setActive:YES] ;
    [[self.descriptionLabel.trailingAnchor constraintEqualToAnchor:marginGuide.trailingAnchor] setActive:YES] ;
    _descriptionLabel.numberOfLines = 0;
    //imageview
    _imageContainer.translatesAutoresizingMaskIntoConstraints = false;
    [[self.imageContainer.topAnchor constraintEqualToAnchor:marginGuide.topAnchor] setActive:YES] ;
    [[self.imageContainer.widthAnchor constraintEqualToConstant:50] setActive:YES] ;
    [[self.imageContainer.bottomAnchor constraintEqualToAnchor:marginGuide.bottomAnchor] setActive:YES] ;
    [[self.imageContainer.leadingAnchor constraintEqualToAnchor:marginGuide.leadingAnchor] setActive:YES] ;
    //title
    _title.translatesAutoresizingMaskIntoConstraints = false;
    [[self.title.topAnchor constraintEqualToAnchor:marginGuide.topAnchor] setActive:YES] ;
    [[self.title.leadingAnchor constraintEqualToAnchor:self.imageContainer.trailingAnchor] setActive:YES] ;
    [[self.title.bottomAnchor constraintEqualToAnchor:marginGuide.bottomAnchor] setActive:YES] ;
    [[self.title.widthAnchor constraintEqualToConstant:100] setActive:YES] ;
    _title.numberOfLines = 0;
    [self.contentView layoutIfNeeded];
}
@end
