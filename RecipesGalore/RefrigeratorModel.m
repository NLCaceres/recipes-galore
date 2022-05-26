//
//  DataModel.m
//  InClassLab
//
//  Created by Nicholas Caceres on 9/28/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import "RefrigeratorModel.h"

// Filename for data - quotes plist
static NSString *const kRefrigeratorPList = @"refrigerator.plist";

// Class Extension
@interface RefrigeratorModel ()

// private properties
@property (strong, nonatomic) NSString* refrigeratorFilePath;
@property (strong, nonatomic) NSMutableArray *refrigerator;
@property NSUInteger currentIndex;

@end

@implementation RefrigeratorModel

- (void) saveRefrigerator {
    [self.refrigerator writeToFile:self.refrigeratorFilePath atomically: YES];
}



+ (instancetype) sharedModel {
    static RefrigeratorModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - safe for threading
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *refrigeratorPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *refrigeratorDocumentsDirectory = [refrigeratorPath objectAtIndex:0];
        
        _refrigeratorFilePath = [refrigeratorDocumentsDirectory stringByAppendingPathComponent:kRefrigeratorPList];
        
        _refrigerator = [NSMutableArray arrayWithContentsOfFile:_refrigeratorFilePath];
        
        
        if (!_refrigerator) { // file does not exist then auto instantiate as
            
            NSDictionary *ingredient1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"rye bread", kIngredientName, @"6", kAmount, @"slice", kMeasurement, nil];
            NSDictionary *ingredient2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"banana", kIngredientName, @"1", kAmount, @" ", kMeasurement, nil];
            
            
            _refrigerator = [[NSMutableArray alloc] initWithObjects:ingredient1, ingredient2, nil];
        }
    }
    return self;
}

- (NSUInteger) numberOfIngredients {
    return [self.refrigerator count];
}

- (NSDictionary *) ingredientAtIndex:(NSUInteger) index {
    return self.refrigerator[index];
}

- (void) insertIngredient: (NSDictionary *) ingredientObj
               atIndex: (NSUInteger) index {
    
    if ( index <= [self numberOfIngredients]) {
        [self.refrigerator insertObject: ingredientObj atIndex: index];
        [self saveRefrigerator];
    }
}
- (void) insertIngredient: (NSDictionary *) ingredientObj {
    [self.refrigerator addObject: ingredientObj];
    [self saveRefrigerator];
}
- (void) insertIngredient:(NSString *)ingredient
                   amount:(NSString *)amount
              measurement:(NSString *)measurement {
                 
    NSDictionary *newIngredient = [[NSDictionary alloc] initWithObjectsAndKeys:ingredient, kIngredientName, amount, kAmount, measurement, kMeasurement, nil];
    [self insertIngredient: newIngredient];
    [self saveRefrigerator];
}

- (void) insertIngredient:(NSString *)ingredient
                   amount:(NSString *)amount
              measurement:(NSString *)measurement
                  atIndex: (NSUInteger) index {
    NSDictionary *newIngredient = [[NSDictionary alloc] initWithObjectsAndKeys:ingredient, kIngredientName, amount, kAmount, measurement, kMeasurement, nil];
    [self insertIngredient: newIngredient atIndex: index];
    [self saveRefrigerator];
}



- (void) removeIngredientAtIndex:(NSUInteger)index {
    if (index < [self numberOfIngredients]) {
        [self.refrigerator removeObjectAtIndex: index];
        [self saveRefrigerator];
    }
}

- (BOOL) checkForIngredient: (NSString *) ingredient {
    
    NSPredicate *filter = [NSPredicate predicateWithFormat: @"ingredient = %@", ingredient];
    NSArray *filteredQuotes = [self.refrigerator filteredArrayUsingPredicate:filter];
    if (filteredQuotes.count == 1)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
 
@end
