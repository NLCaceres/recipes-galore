//
//  MainViewCollectionViewCell.h
//  RecipesGalore
//
//  Created by Nick Caceres on 7/25/19.
//  Copyright © 2019 Nicholas Caceres. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainViewCollectionViewCell : UICollectionViewCell

- (void) setUpCell: (NSInteger) collectionViewCellTag;
- (NSString *) getFoodType;

@end

NS_ASSUME_NONNULL_END
