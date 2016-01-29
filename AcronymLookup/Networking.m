//
//  Networking.m
//  AcronymLookup
//
//  Created by Rahim Momin on 1/28/16.
//  Copyright © 2016 Momin. All rights reserved.
//

#import "Networking.h"
#import "AFNetworking.h"
#import "Model.h"

@implementation Networking

+ (void)downloadMeaningForAcronym:(NSString *)acronym success:(void(^)(void))success failure:(void(^)(NSError *))failure
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=%@", acronym]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        @try
        {
            NSError *error;
            NSArray *data = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
            NSDictionary *dict = [data firstObject];
            
            [[Model sharedModel] parseData:dict];
            return success();
        }
        @catch (NSException *exception)
        {
            return failure(nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        return failure(error);
    }];
    
    [operation start];
}


@end
