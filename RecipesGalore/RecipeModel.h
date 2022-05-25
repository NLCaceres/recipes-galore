//
//  DataModel.h
//  InClassLab
//
//  Created by Nicholas Caceres on 9/28/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kRecipeName = @"recipe name";
static NSString * const kImage = @"recipe image";
static NSString * const kCookPrepServe = @"Cooking, Preparation Time, Serving size";
static NSString * const kIngredients = @"Recipe Ingredients";
static NSString * const kRecipeDirections = @"Recipe Directions";
static NSString * const kStyleIndex = @"style index";

@interface RecipeModel : NSObject

// class methods
+ (instancetype) sharedModel;

// public method signatures
// instance methods
- (void) saveRecipe;

- (NSUInteger) numberOfRecipes: (NSNumber *) styleIndex;

- (NSDictionary *) recipeAtIndex: (NSUInteger) recipeIndex
                         styleIndex: (NSNumber *) styleIndex;

- (void) insertRecipe: (NSDictionary *) recipeObj
           styleIndex: (NSNumber *) styleIndex
               atIndex: (NSUInteger) recipeIndex;
- (void) insertRecipe: (NSDictionary *) recipeObj
           styleIndex: (NSNumber *) styleIndex;
- (void) insertRecipe: (NSString *) recipeName
          recipeImage: (NSString *) image
        cookPrepServe: (NSMutableArray *) cookPrepServe
    recipeIngredients: (NSMutableArray *) ingredients
     recipeDirections: (NSMutableArray *) directions
           styleIndex: (NSNumber *) styleIndex;

- (void) insertRecipe: (NSString *) recipeName
          recipeImage: (NSString *) image
        cookPrepServe: (NSMutableArray *) cookPrepServe
    recipeIngredients: (NSMutableArray *) ingredients
     recipeDirections: (NSMutableArray *) directions
           styleIndex: (NSNumber *) styleIndex
              atIndex: (NSUInteger) recipeIndex;

- (void) removeRecipeAtIndex: (NSUInteger) recipeIndex
                     styleIndex: (NSNumber *) styleIndex;

- (NSDictionary *) nextRecipe;
- (NSDictionary *) prevRecipe;

@end
