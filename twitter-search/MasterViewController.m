//
//  MasterViewController.m
//  twitter-search
//
//  Created by mcan on 15/11/2016.
//  Copyright © 2016 mcan. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

// library
#import "Masonry.h"

// custom class
#import "TweetSearchView.h"
#import "TweetSearchTableViewComponent.h"

@interface MasterViewController ()

@property (nonatomic, strong) TweetSearchView *tweetSearchView;
@property (nonatomic, strong) TweetSearchTableViewComponent *tweetSearchTableViewComponent;
@property (strong, nonatomic) IBOutlet UITableView *tweetSearchTableView;

@property (nonatomic, strong) NSArray *objects;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    //    self.navigationItem.rightBarButtonItem = addButton;
    
    self.tweetSearchView = [[TweetSearchView alloc] init];
    
    [self.view addSubview:self.tweetSearchView];
    [self.tweetSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.objects = @[@"asd", @"asd", @"asd"];

    self.tweetSearchTableViewComponent = [[TweetSearchTableViewComponent alloc] initWithArray:self.objects];
    
    [self.tweetSearchView.tweetsTableView setDelegate:self.tweetSearchTableViewComponent];
    [self.tweetSearchView.tweetsTableView setDataSource:self.tweetSearchTableViewComponent];
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}


- (void)viewWillAppear:(BOOL)animated {
    //self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

#pragma mark - Segues

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = self.objects[indexPath.row];
//        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
//        [controller setDetailItem:object];
//        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
//        controller.navigationItem.leftItemsSupplementBackButton = YES;
//    }
//}

@end
