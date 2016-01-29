//
//  Meaning.h
//  AcronymLookup
//
//  Created by Rahim Momin on 1/28/16.
//  Copyright © 2016 Momin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meaning : NSObject

@property (nonatomic, copy) NSString *lf;
@property (nonatomic, assign) NSInteger freq;
@property (nonatomic, assign) NSInteger since;
@property (nonatomic, strong) NSArray *vars;

@end
