//
//  Model.m
//  AcronymLookup
//
//  Created by Rahim Momin on 1/28/16.
//  Copyright © 2016 Momin. All rights reserved.
//

#import "Model.h"

@implementation Model

+ (instancetype)sharedModel
{
    static id model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[[self class] alloc] init];
    });
    
    return (Model *)model;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.acronym = nil;
    }
    return self;
}

- (void)parseData:(NSDictionary *)dict
{
    @try
    {
        NSMutableArray *meanings = [NSMutableArray array];
        NSArray *lfs = dict[@"lfs"];
        for (NSDictionary *item in lfs)
        {
            @try
            {
                NSMutableArray *vars = [NSMutableArray new];
                NSArray *varsDict = item[@"vars"];
                for (NSDictionary *varItem in varsDict)
                {
                    @try
                    {
                        Meaning *subMeaning = [Meaning new];
                        subMeaning.lf = [NSString stringWithFormat:@"%@", varItem[@"lf"]];
                        subMeaning.freq = [varItem[@"freq"] integerValue];
                        subMeaning.since = [varItem[@"since"] integerValue];
                        
                        [vars addObject:subMeaning];
                    }
                    @catch (NSException *exception)
                    {}
                }
                
                Meaning *meaning = [Meaning new];
                meaning.lf = [NSString stringWithFormat:@"%@", item[@"lf"]];
                meaning.freq = [item[@"freq"] integerValue];
                meaning.since = [item[@"since"] integerValue];
                meaning.vars = [NSArray arrayWithArray:vars];
                
                [meanings addObject:meaning];
            }
            @catch (NSException *exception)
            {}
        }
        
        Acronym *acronym = [Acronym new];
        acronym.sf = dict[@"sf"];
        acronym.lfs = [NSArray arrayWithArray:meanings];
        
        self.acronym = acronym;
    }
    @catch (NSException *exception)
    {}
}

@end
