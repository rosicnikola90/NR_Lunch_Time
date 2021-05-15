//
//  NRCollectionViewCell.h
//  NR_Lunch_Time
//
//  Created by MacBook on 5/9/21.
//  Copyright © 2021 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NRCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *restourantNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *categoryTypeLbl;
@property (weak, nonatomic) IBOutlet UIImageView *restourantImage;

@end

NS_ASSUME_NONNULL_END
