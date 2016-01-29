//
//  SearchViewController.m
//  AcronymLookup
//
//  Created by Rahim Momin on 1/28/16.
//  Copyright © 2016 Momin. All rights reserved.
//

#import "SearchViewController.h"
#import "Networking.h"
#import "MBProgressHUD.h"
#import "TableViewCell.h"
#import "Model.h"


@interface SearchViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation SearchViewController

#pragma mark - Object Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 62.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - UISearchBarDelegate Functions

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [Networking downloadMeaningForAcronym:self.searchBar.text success:^{

        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *message = [NSString stringWithFormat:@"An error occurred searching '%@'", searchBar.text];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alertController dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alertController addAction:ok];
        [self presentViewController:alertController animated:YES completion:nil];
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.view endEditing:YES];
}

#pragma mark - UITableView Data Source and Delegate Functions

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    Acronym *acronym = [Model sharedModel].acronym;
    return [acronym.lfs count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Acronym *acronym = [Model sharedModel].acronym;
    Meaning *meaning = [acronym.lfs objectAtIndex:section];
    return [meaning.vars count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *titleLabel = nil;
//    UIButton *button = nil;
    
    static NSString *HeaderIdentifier = @"sectionHeader";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderIdentifier];
    if(! headerView)
    {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:HeaderIdentifier];
        headerView.contentView.backgroundColor = [UIColor lightGrayColor];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.tag = 10000;
        [headerView addSubview:titleLabel];
        
//        button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        button.tag = 10001;
//        [headerView addSubview:button];
    }
    
    titleLabel = [headerView viewWithTag:10000];
//    button = [headerView viewWithTag:10001];
    
    Acronym *acronym = [Model sharedModel].acronym;
    Meaning *meaning = [acronym.lfs objectAtIndex:section];
    
    titleLabel.text = nil;
    titleLabel.text = meaning.lf;
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints: NO];

    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[titleLabel]-14-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(titleLabel)];
    [headerView addConstraints:constraints];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:titleLabel
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:headerView
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0];
    [headerView addConstraint:constraint];
    
//    constraint = [NSLayoutConstraint constraintWithItem:button
//                                              attribute:NSLayoutAttributeCenterY
//                                              relatedBy:NSLayoutRelationEqual
//                                                 toItem:headerView
//                                              attribute:NSLayoutAttributeCenterY
//                                             multiplier:1
//                                               constant:0];
//    [headerView addConstraint:constraint];
//    
//    constraint = [NSLayoutConstraint constraintWithItem:button
//                                              attribute:NSLayoutAttributeCenterX
//                                              relatedBy:NSLayoutRelationEqual
//                                                 toItem:headerView
//                                              attribute:NSLayoutAttributeCenterX
//                                             multiplier:1
//                                               constant:0];
//    [headerView addConstraint:constraint];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    Acronym *acronym = [Model sharedModel].acronym;
    Meaning *meaning = [acronym.lfs objectAtIndex:indexPath.section];
    Meaning *subMeaning = [meaning.vars objectAtIndex:indexPath.row];
    cell.lf.text = subMeaning.lf;
    cell.freq.text = [NSString stringWithFormat:@"%ld", (long)subMeaning.freq];
    cell.since.text = [NSString stringWithFormat:@"%ld", (long)subMeaning.since];
    
    return cell;
}


@end
