//
//  ProfileRecipeCollectionViewCell.h
//  RecipesGalore
//
//  Created by Nick Caceres on 7/27/19.
//  Copyright © 2019 Nicholas Caceres. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ProfileRecipeCollectionViewCell;
@protocol DeletableCellProtocol <NSObject>

-(void) deleteCell: (ProfileRecipeCollectionViewCell *) cell;

@end

@interface ProfileRecipeCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) id<DeletableCellProtocol> delegate;

- (void) setUpCell: (NSDictionary *) recipeDictionary;
- (void) setDeleteMode;

@end

NS_ASSUME_NONNULL_END
