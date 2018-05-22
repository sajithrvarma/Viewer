//
//  ViewController.m
//  Viewer
//

//  Copyright © 2018 Personal. All rights reserved.
//test

#import "ViewController.h"
#import "ImageTableViewCell.h"
#import "NetworkManager.h"
#import "Utilities.h"
#import "ConstantsHeader.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UINavigationBar* navbar;
    UINavigationItem* navItem;
    NSString * CellIdentifier;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupView];


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
    [self setupTableView];
    [self setupNavigationBar];
    [self layoutView];
    [self refresh];
}
-(void)setupTableView{
    self.imageLoader = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.imageLoader.dataSource =self;
    self.imageLoader.delegate = self;
    [self.view addSubview:self.imageLoader];
    self.imageLoader.estimatedRowHeight = 10;
    self.imageLoader.rowHeight = UITableViewAutomaticDimension;
    CellIdentifier = @"Cell";
    [self.imageLoader registerClass:[ImageTableViewCell class]  forCellReuseIdentifier:CellIdentifier];
}
-(void)refresh{
    [NetworkManager fetchDatawithCompletion:^(NSDictionary *data) {
        if (data) {
            NSArray *imageList = [data objectForKey:KeyRow];
            self.imageDataList =[Utilities parseDictionaryListToImageModelList:imageList];
            self.navTitle = [data objectForKey:KeyTitle];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.imageLoader reloadData];
                [navItem setTitle:self.navTitle];
            });
        }
        else{
            NSLog(ErrorMessge);
            [self showAlert];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
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

-(void)layoutView{
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
-(void)showAlert{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Oops!!!"
                                 message:ErrorMessge
                                 preferredStyle:UIAlertControllerStyleAlert];
    //Add Buttons
    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                }];
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
