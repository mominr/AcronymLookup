//
//  TableViewCell.h
//  AcronymLookup
//
//  Created by Rahim Momin on 1/28/16.
//  Copyright © 2016 Momin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lf;
@property (weak, nonatomic) IBOutlet UILabel *freq;
@property (weak, nonatomic) IBOutlet UILabel *since;

@end
