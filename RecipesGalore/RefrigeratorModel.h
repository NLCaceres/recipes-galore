//
//  DataModel.h
//  InClassLab
//
//  Created by Nicholas Caceres on 9/28/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kIngredientName = @"ingredient name";
static NSString * const kAmount = @"number amount";
// type of measurement like lbs or Tbsp or package
static NSString * const kMeasurement = @"measurement type";

@interface RefrigeratorModel : NSObject

// class methods
+ (instancetype) sharedModel;

// public method signatures
// instance methods
- (void) saveRefrigerator;

- (NSUInteger) numberOfIngredients;

- (NSDictionary *) ingredientAtIndex: (NSUInteger) index;

- (void) insertIngredient: (NSDictionary *) ingredientObj
               atIndex: (NSUInteger) index;
- (void) insertIngredient: (NSDictionary *) ingredientObj;
- (void) insertIngredient: (NSString *) ingredient
              amount: (NSString *) amount
              measurement: (NSString *) measurement;
- (void) insertIngredient:(NSString *)ingredient
                   amount:(NSString *)amount
              measurement:(NSString *)measurement
                  atIndex: (NSUInteger) index;

- (void) removeIngredientAtIndex: (NSUInteger) index;

- (BOOL) checkForIngredient: (NSString *) ingredient;

@end
