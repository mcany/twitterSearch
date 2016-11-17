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
#import "ReactiveCocoa.h"
#import "MTLJSONAdapter.h"

// custom class
#import "MasterViewViewModel.h"
#import "TweetSearchView.h"
#import "TweetSearchTableViewComponent.h"
#import "UIManager.h"

@interface MasterViewController ()

@property (nonatomic, strong) MasterViewViewModel *viewModel;
@property (nonatomic, strong) TweetSearchView *tweetSearchView;
@property (nonatomic, strong) TweetSearchTableViewComponent *tweetSearchTableViewComponent;

@end

@implementation MasterViewController

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.viewModel = [MasterViewViewModel new];
    self.tweetSearchView = [[TweetSearchView alloc] init];
    [self.view addSubview:self.tweetSearchView];
    [self.tweetSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.tweetSearchTableViewComponent = [[TweetSearchTableViewComponent alloc] init];
    [self.tweetSearchView.tweetsTableView setDelegate:self.tweetSearchTableViewComponent];
    [self.tweetSearchView.tweetsTableView setDataSource:self.tweetSearchTableViewComponent];
    
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    // RAC
    [self searchTweetsWithKeyword:@"test"];
}

- (void)viewWillAppear:(BOOL)animated {
    //self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)searchTweetsWithKeyword:(NSString *)keyword{
    [UIManager showHUD];
    @weakify(self);
    [[self.viewModel searchTweetsWithKeyword:keyword] subscribeNext:^(TweetSearch *search) {
        @strongify(self);
        [UIManager dismissHUD];
        self.tweetSearchTableViewComponent.search = search;
        [self.tweetSearchView.tweetsTableView reloadData];

    } error:^(NSError *error) {
        @strongify(self);
        [UIManager dismissHUD];
        UIAlertController *alert= [UIManager showErrorWithMessage:error.description];
        [self presentViewController:alert animated:YES completion:nil];
    }];
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
