//
//  Networking.h
//  AcronymLookup
//
//  Created by Rahim Momin on 1/28/16.
//  Copyright © 2016 Momin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Networking : NSObject

+ (void)downloadMeaningForAcronym:(NSString *)acronym success:(void(^)(void))success failure:(void(^)(NSError *))failure;

@end
