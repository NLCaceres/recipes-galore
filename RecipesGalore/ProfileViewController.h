//
//  ProfileViewController.h
//  RecipesGalore
//
//  Created by Lionel Caceres on 12/11/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileRecipeCollectionViewCell.h"
@import GoogleSignIn;

@interface ProfileViewController : UIViewController<UIGestureRecognizerDelegate, DeletableCellProtocol>

- (void) beginEditMode;

@end
