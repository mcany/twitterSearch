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

@interface MasterViewController () <UITextFieldDelegate>

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
    [self.tweetSearchTableViewComponent setCellSelectedDelegate:self];
    [self.tweetSearchTableViewComponent setNextResultDelegate:self];
    [self.tweetSearchView.tweetsTableView setDelegate:self.tweetSearchTableViewComponent];
    [self.tweetSearchView.tweetsTableView setDataSource:self.tweetSearchTableViewComponent];
    [self.tweetSearchView.searchTextField setDelegate:self];
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self searchTweetsWithKeyword:self.tweetSearchView.searchTextField.text];
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

- (void)loadNextPage {
    if (self.tweetSearchTableViewComponent.isLoading) return;
    self.tweetSearchTableViewComponent.isLoading = YES;
    
    [UIManager showHUD];
    @weakify(self);
    [[self.viewModel nextResults] subscribeNext:^(TweetSearch *search) {
        @strongify(self);
        [UIManager dismissHUD];
        self.tweetSearchTableViewComponent.search = search;
        [self.tweetSearchView.tweetsTableView reloadData];
        self.tweetSearchTableViewComponent.isLoading = NO;
    } error:^(NSError *error) {
        @strongify(self);
        [UIManager dismissHUD];
        if(error.code == 100){
            UIAlertController *alert= [UIManager showErrorWithMessage:@"Next Result URL is null. Maybe try again later?"];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else{
            UIAlertController *alert= [UIManager showErrorWithMessage:error.description];
            [self presentViewController:alert animated:YES completion:nil];
        }
        self.tweetSearchTableViewComponent.isLoading = NO;
    }];
    
}

#pragma mark - Segues

-(void)cellSelectedAtIndex:(NSInteger)index{
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tweetSearchView.tweetsTableView indexPathForSelectedRow];
        SearchStatuses *object = [self.viewModel searchStatusesAtIndex:indexPath.row];
        if (object) {
            DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
            [controller setDetailItem:object];
            controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
            controller.navigationItem.leftItemsSupplementBackButton = YES;
        }
    }
}

#pragma mark textField
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.tweetSearchView.searchTextField) {
        NSString *keyword = textField.text;
        [self searchTweetsWithKeyword:keyword];
    }
}

@end
