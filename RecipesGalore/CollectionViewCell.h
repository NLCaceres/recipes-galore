//
//  CollectionViewCell.h
//  Lab7
//
//  Created by Nicholas Caceres on 11/26/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import <UIKit/UIKit.h>

/* CollectionViewCell that displays recipes */

@class CollectionViewCell;
@protocol DeletableCellProtocol <NSObject>

-(void) deleteCell: (CollectionViewCell *) cell;

@end

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) id<DeletableCellProtocol> delegate;
@property BOOL isDeleteMode;

- (void) setUpCell: (NSDictionary *) recipeDictionary;
- (void) setDeleteMode;

@end
