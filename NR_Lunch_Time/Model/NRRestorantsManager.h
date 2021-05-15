//
//  NRRestorantsManager.h
//  NR_Lunch_Time
//
//  Created by MacBook on 5/9/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRRestourant.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NRRestourantManagerDelegate <NSObject>

- (void)reastourantArrayCreated:(NSArray<NRRestourant *> *)restourants;
- (void)updatedRestourantImage:(UIImage *)image atIndexPath:(NSIndexPath *)indexPath;

@end

@interface NRRestorantsManager : NSObject

@property (nonatomic, weak, nullable) id <NRRestourantManagerDelegate> delegate;

- (void)updateRestourantListFromWebWithURL:(NSString *)urlString;
- (void)getImageForRestourantURL:(NSString *)urlString atIndex:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
