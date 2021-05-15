//
//  NRImageOfRestourant.h
//  NR_Lunch_Time
//
//  Created by MacBook on 5/12/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface NRImageOfRestourant : NSObject

@property (nonatomic, nullable) NSData *restourantImageData;
@property (nonatomic, readonly, nullable) NSString *imageURL;

@end

NS_ASSUME_NONNULL_END
