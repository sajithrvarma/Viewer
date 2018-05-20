//
//  ViewController.m
//  Viewer
//
//  Created by Applied Materials on 20/05/18.
//  Copyright © 2018 Personal. All rights reserved.
//test

#import "ViewController.h"
#import "ImageTableViewCell.h"
#import "NetworkManager.h"
#import "Utilities.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UINavigationBar* navbar;
    UINavigationItem* navItem;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupView];
    self.imageLoader.estimatedRowHeight = 10;
    self.imageLoader.rowHeight = UITableViewAutomaticDimension;
    [self.imageLoader registerClass:[ImageTableViewCell class]  forCellReuseIdentifier:@"Cell"];
    // Load images async

}
- (void) viewWillAppear:(BOOL)animated
{
   // [self.navigationController setNavigationBarHidden:NO animated:NO];
    [super viewWillAppear:animated];
}
-(void)setupNavigationBar
{
     navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navItem = [[UINavigationItem alloc] initWithTitle:self.title];
    UIBarButtonItem *doneButton=[[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(onTapDone:)];
    navItem.rightBarButtonItem = doneButton;
    [navbar setItems:@[navItem]];
    [self.view addSubview:navbar];
    [self.view layoutIfNeeded];
}


-(void)onTapDone:(UIBarButtonItem*)item{
    [self refresh];
}

- (void)setupView{
    self.imageLoader = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.imageLoader.dataSource =self;
    self.imageLoader.delegate = self;
    [self.view addSubview:self.imageLoader];
     [self setupNavigationBar];
   // [self addConstraints:self.imageLoader];
    [self setupAuto];
    [self refresh];
}
-(void)refresh{
    [NetworkManager fetchDatawithCompletion:^(NSDictionary *data) {
        NSArray *imageList = [data objectForKey:@"rows"];
        self.imageDataList =[Utilities parseDictionaryListToImageModelList:imageList ];
        self.navTitle = [data objectForKey:@"title"];
        NSLog(@"response:%@",self.imageDataList);
        dispatch_async(dispatch_get_main_queue(), ^{
            // do work here
            [self.imageLoader reloadData];
            [navItem setTitle:self.navTitle];
        });
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    // Set the data for this cell:
    responseImage *rowDetails = [self.imageDataList objectAtIndex:indexPath.row];
    [cell setupCell:rowDetails];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageDataList.count;
}

-(void)addConstraints:(UIView*)view{
    UILayoutGuide *safe = self.view.safeAreaLayoutGuide;
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    /* Leading space to superview */
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint
                                                 constraintWithItem:view attribute:NSLayoutAttributeLeft
                                                 relatedBy:NSLayoutRelationEqual toItem:self.view attribute:
                                                 NSLayoutAttributeLeft multiplier:1.0 constant:0];
    /* Top space to superview Y*/
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint
                                                 constraintWithItem:view attribute:NSLayoutAttributeTop
                                                 relatedBy:NSLayoutRelationEqual toItem:navbar attribute:
                                                 NSLayoutAttributeTop multiplier:1.0f constant:0];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint
                                          constraintWithItem:view attribute:NSLayoutAttributeRight
                                          relatedBy:NSLayoutRelationEqual toItem:self.view attribute:
                                          NSLayoutAttributeRight multiplier:1.0 constant:0];
    /* Top space to superview Y*/
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint
                                                 constraintWithItem:view attribute:NSLayoutAttributeBottom
                                                 relatedBy:NSLayoutRelationEqual toItem:self.view attribute:
                                                 NSLayoutAttributeBottom multiplier:1.0f constant:0];
    [self.view addConstraints:@[leftConstraint, topConstraint,
                                rightConstraint,bottomConstraint]];
    [self.view layoutIfNeeded];
   //[view.topAnchor constraintEqualToAnchor:safe.topAnchor]
}
-(void)setupAuto{
    self.imageLoader.translatesAutoresizingMaskIntoConstraints = false;
    [[self.imageLoader.topAnchor constraintEqualToAnchor:navbar.bottomAnchor] setActive:YES] ;
    [[self.imageLoader.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES] ;
       [[self.imageLoader.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES] ;
    [[self.imageLoader.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES] ;

    //navview
    navbar.translatesAutoresizingMaskIntoConstraints = false;
    [[navbar.topAnchor constraintEqualToAnchor:self.view.topAnchor] setActive:YES] ;
    [[navbar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES] ;
    [[navbar.heightAnchor constraintEqualToConstant:84] setActive:YES] ;
    [[navbar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES] ;
    
}

@end
