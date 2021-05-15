//
//  NRRestourant.h
//  NR_Lunch_Time
//
//  Created by MacBook on 5/9/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NRImageOfRestourant.h"

NS_ASSUME_NONNULL_BEGIN

@interface NRRestourant : NSObject

@property (nonatomic, readonly, nullable) NSString *name;
@property (nonatomic, nullable) NRImageOfRestourant *backgroundImageWithURL;
@property (nonatomic, readonly, nullable) NSString *category;
@property (nonatomic, readonly, nullable) NSString *phoneNo;
@property (nonatomic, readonly, nullable) NSString *twitter;
@property (nonatomic, readonly, nullable) NSArray *address;
@property (nonatomic, readonly, nullable) NSString *latitude;
@property (nonatomic, readonly, nullable) NSString *longitude;


@end

NS_ASSUME_NONNULL_END
