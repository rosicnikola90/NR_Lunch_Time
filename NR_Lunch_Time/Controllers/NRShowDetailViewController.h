//
//  NRShowDetailViewController.h
//  NR_Lunch_Time
//
//  Created by MacBook on 5/13/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "NRRestourant.h"


NS_ASSUME_NONNULL_BEGIN

@interface NRShowDetailViewController : UIViewController

@property (nonatomic, nullable) NRRestourant *restourant;

@end

NS_ASSUME_NONNULL_END
