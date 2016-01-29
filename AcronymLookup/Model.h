//
//  Model.h
//  AcronymLookup
//
//  Created by Rahim Momin on 1/28/16.
//  Copyright © 2016 Momin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Acronym.h"
#import "Meaning.h"

@interface Model : NSObject

@property (nonatomic, strong) Acronym *acronym;

- (void)parseData:(NSDictionary *)dict;

+ (instancetype)sharedModel;

@end
