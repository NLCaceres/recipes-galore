//
//  CollectionViewController.h
//  Lab7
//
//  Created by Nicholas Caceres on 11/26/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"
 
/* CollectionView that displays recipes based on type clicked from previous MainViewController */

@interface CollectionViewController : UICollectionViewController<UIGestureRecognizerDelegate, DeletableCellProtocol>

@property (strong, nonatomic) NSNumber *recipeStyleIndex;

@end
