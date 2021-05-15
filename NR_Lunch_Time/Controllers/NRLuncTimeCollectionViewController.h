//
//  CollectionViewController.h
//  NR_Lunch_Time
//
//  Created by MacBook on 5/8/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NRRestorantsManager.h"
#import "NRConstants.h"
#import "NRCollectionViewCell.h"
#import "NRShowDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NRLuncTimeCollectionViewController : UICollectionViewController <NRRestourantManagerDelegate, UICollectionViewDelegateFlowLayout>

@end

NS_ASSUME_NONNULL_END
