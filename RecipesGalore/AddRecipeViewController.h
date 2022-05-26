//
//  AddRecipeViewController.h
//  RecipesGalore
//
//  Created by Lionel Caceres on 12/11/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddRecipeCompletionHandler)(NSString *recipeName,
                                               NSString *recipeImage, NSString *cookTime, NSString *prepTime, NSString *servingSize, NSMutableArray *ingredientList, NSMutableArray *direcionList, NSString *category);

@interface AddRecipeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) AddRecipeCompletionHandler completionHandler;

-(void) enableSave;
-(void) resetProps;

@end
