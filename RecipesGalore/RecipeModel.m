//
//  DataModel.m
//  InClassLab
//
//  Created by Nicholas Caceres on 9/28/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import "RecipeModel.h"

// Filename for data - quotes plist
static NSString *const kRecipesPList = @"Recipes.plist";

// Class Extension
@interface RecipeModel ()

// private properties
@property (strong, nonatomic) NSString* recipeFilePath;
@property (strong, nonatomic) NSMutableArray *recipes;
@property NSUInteger currentIndex;

@end

@implementation RecipeModel

- (void) saveRecipe {
    [self.recipes writeToFile:self.recipeFilePath atomically: YES];
}


+ (instancetype) sharedModel {
    static RecipeModel *_sharedModel = nil;
    
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
        NSArray *recipePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *recipeDocumentsDirectory = [recipePath objectAtIndex:0];
        
        self.recipeFilePath = [recipeDocumentsDirectory stringByAppendingPathComponent:kRecipesPList];
        
        self.recipes = [NSMutableArray arrayWithContentsOfFile:self.recipeFilePath];
        
        
        if (!self.recipes) { // file does not exist then auto instantiate as
            
            NSMutableArray *ethnicFood;
            NSMutableArray *healthyFood;
            NSMutableArray *meats;
            NSMutableArray *seafood;
            NSMutableArray *snack;
            NSMutableArray *dessert;
            NSMutableArray *userAddedRecipes;
            
            // For future reference
            NSInteger prepTime = 40;
            NSString *prepTimeString = [NSString stringWithFormat:@"Prep Time: %ld minutes", prepTime];
            NSMutableArray *cookPrepServe1 = [[NSMutableArray alloc] initWithObjects: prepTimeString, @"Cook Time: 20 minutes", @"Serves: 4 people", nil];
            
            // For future reference
            NSString *ingredientAmount = @"1/2";
            NSString *ingredientMeasurement = @"tablespoon";
            NSString *ingredientString = [NSString stringWithFormat:@"%@ %@ salt", ingredientAmount,ingredientMeasurement];
            NSArray *ingredients1 = [[NSMutableArray alloc] initWithObjects:@"1 cup all-purpose flour", @"2 tablespoons cornstarch", @"1 Tsp baking powder", ingredientString, @"1 egg", @"1 cup beer", @"1/2 cup plain yogurt", @"1/2 cup mayonnaise", @"1 lime, juiced", @"1 jalapeno pepper, minced", @"1 Tsp minced capers", @"1/2 Tsp dried oregano", @"1/2 Tsp ground cumin", @"1/2 Tsp dried dill weed", @"1 Tsp ground cayenne pepper", @"1 quart oil for frying", @"1 lb cod fillets, cut into 2 to 3 oz", @"1 package corn tortillas", @"1/2 medium head cabbage, finely shredded", nil];
            
            NSMutableArray *recipeDirections1 = [[NSMutableArray alloc] initWithObjects: @"For beer batter: In a large bowl, combine flour, cornstarch, baking powder, and salt. Blend egg and beer, then quickly stir into the flour mixture (don't worry about lumps too much).", @"For white sauce: In a medium bowl, mix together yogurt and mayonnaise. Gradually stir in fresh lime juice until consistency is slightly runny. Season with jalapeno, capers, oregano, cumin, dill and cayenne.", @"Heat oil in deep-fryer at 375 degrees F (190 degrees C)", @"Dust fish pieces lightly with flour. Dip into beer batter, and fry until crisp and golden brown. Drain on paper towels. Lightly fry tortilas; not too crisp. To serve, place fried fish in a tortilla, and top with shredded cabbage, and white sauce", nil];
            
            NSDictionary *recipe1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Fish Tacos", kRecipeName, @"fish_tacos", kImage, cookPrepServe1, kCookPrepServe, ingredients1, kIngredients, recipeDirections1, kRecipeDirections, nil];
            
            NSMutableArray *cookPrepServe2 = [[NSMutableArray alloc] initWithObjects:@"Prep Time: 5 minutes", @"Cook Time: 0 minutes", @"Serves: 1 person", nil];
            NSMutableArray *ingredients2 = [[NSMutableArray alloc] initWithObjects:@"1 Tbsp almond butter", @"1 slice rye bread", @"1 banana", nil];
            NSMutableArray *recipeDirections2 = [[NSMutableArray alloc] initWithObjects: @"Spread almond butter on toast", @"Top with banana slices", nil];
            NSDictionary *recipe2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Banana & Almond Butter Toast", kRecipeName, @"banana_almond_toast", kImage, cookPrepServe2, kCookPrepServe, ingredients2, kIngredients, recipeDirections2, kRecipeDirections, nil];
            
            NSMutableArray *cookPrepServe3 = [[NSMutableArray alloc] initWithObjects:@"Prep Time: 5 minutes", @"Cook Time: 0 minutes", @"Serves: 1 person", nil];
            NSMutableArray *ingredients3 = [[NSMutableArray alloc] initWithObjects:@"2 Tbsp semisweet chocolate chips", @"1 banana", nil];
            NSMutableArray *recipeDirections3 = [[NSMutableArray alloc] initWithObjects: @"Place chocolate chips in a zip-top bag or bowl. Microwave 1 minute or until they melt", @"Dip banana pieces into chocolate", nil];
            NSDictionary *recipe3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Chocolate-dipped Banana Bites", kRecipeName, @"chocolate_bananas", kImage, cookPrepServe3, kCookPrepServe, ingredients3, kIngredients, recipeDirections3, kRecipeDirections, nil];
            
            NSMutableArray *cookPrepServe4 = [[NSMutableArray alloc] initWithObjects:@"Prep Time: 15 minutes", @"Cook Time: 15 minutes", @"Serves: 6 people", nil];
            NSMutableArray *ingredients4 = [[NSMutableArray alloc] initWithObjects:@"Cooking spray", @"1 cup thinly sliced onion", @" 5 garlic cloves, minced", @"2 cups shredded cooked chicken breast", @"1 can black beans, rinsed and drained", @"1 cup fat-free, less-sodium chicken broth", @"1 can salsa de chile fresco", @"15 corn tortillas, cut into 1-inch strips", @"1 cup shredded queso blanco", nil];
            NSMutableArray *recipeDirections4 = [[NSMutableArray alloc] initWithObjects:@"Preheat oven to 450 degrees F", @"Using large skillet, add onion; saute 5 minutes or until lightly browned. Saute garlic for 1 minute. Cook chicken for 30 seconds", @"Transfer mixture to a medium bowl; stir in beans. Add broth and salsa to pan; bring to boil. Reduce heat and simmer 5 minutes, stirring occasionally. Set aside", @"Place half of tortilla strips in bottom of 11 x 7-inch baking dish coated with cooking spray", @"Layer half of chicken mixture over tortillas; top with remaining tortillas and chicken mixture", @"Evenly pour broth mixture over chicken mixture, sprinkle with cheese", @"Bake at 450 degrees F for 10 minutes or until tortillas are lightly browned and cheese melts", nil];
            NSDictionary *recipe4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Baked Mexican Chilaquiles", kRecipeName, @"chilaquiles", kImage, cookPrepServe4, kCookPrepServe, ingredients4, kIngredients, recipeDirections4, kRecipeDirections, 0, kStyleIndex, nil];
            
            ethnicFood = [[NSMutableArray alloc] initWithObjects:recipe1, recipe4, nil];
            healthyFood = [[NSMutableArray alloc] initWithObjects:recipe2, recipe3, recipe4, nil];
            meats = [[NSMutableArray alloc] initWithObjects:recipe4, nil];
            seafood = [[NSMutableArray alloc] initWithObjects:recipe1, nil];
            snack = [[NSMutableArray alloc] initWithObjects:recipe2, nil];
            dessert = [[NSMutableArray alloc] initWithObjects:recipe3, nil];
            userAddedRecipes = [[NSMutableArray alloc] init];
            
            self.recipes = [[NSMutableArray alloc] initWithObjects:ethnicFood, healthyFood, meats, seafood, snack, dessert, userAddedRecipes, nil];
            
        }
    }
    return self;
}

- (NSUInteger) numberOfRecipes: (NSNumber *) styleIndex {
    
    NSUInteger tempStyleIndex = [styleIndex intValue];

    NSMutableArray *tempRecipeSet = [[NSMutableArray alloc]initWithArray:self.recipes[tempStyleIndex]];
    return [tempRecipeSet count];
}

- (NSDictionary *) recipeAtIndex:(NSUInteger) recipeIndex
                         styleIndex:(NSNumber *) styleIndex {
    
    NSUInteger tempStyleIndex = [styleIndex intValue];

    NSMutableArray *tempRecipeSet = [[NSMutableArray alloc]initWithArray:self.recipes[tempStyleIndex]];
    return tempRecipeSet[recipeIndex];

                              
}

- (void) insertRecipe:(NSDictionary *)recipeObj
           styleIndex:(NSNumber *)styleIndex
              atIndex:(NSUInteger)recipeIndex{
    
    if (recipeIndex <= [self numberOfRecipes: styleIndex]) {
        
        NSUInteger tempStyleIndex = [styleIndex intValue];

        [self.recipes[tempStyleIndex] insertObject: recipeObj atIndex: recipeIndex];
        [self saveRecipe];
    }
}
- (void) insertRecipe:(NSDictionary *)recipeObj
           styleIndex:(NSNumber *)styleIndex {
    
    NSUInteger tempStyleIndex = [styleIndex intValue];
    [self.recipes[tempStyleIndex] addObject: recipeObj];
    [self saveRecipe];
}

- (void) insertRecipe:(NSString *)recipeName
          recipeImage: (NSString *)image
        cookPrepServe:(NSMutableArray *)cookPrepServe
    recipeIngredients:(NSMutableArray *)ingredients
     recipeDirections:(NSMutableArray *)directions
           styleIndex:(NSNumber *)styleIndex {
                 
    NSDictionary *newRecipe = [[NSDictionary alloc] initWithObjectsAndKeys:recipeName, kRecipeName, image, kImage, cookPrepServe, kCookPrepServe, ingredients, kIngredients, directions, kRecipeDirections, styleIndex, kStyleIndex, nil];
    
    [self insertRecipe: newRecipe styleIndex:styleIndex];
    //[self saveRecipe];
}

- (void) insertRecipe:(NSString *)recipeName
          recipeImage: (NSString *)image
        cookPrepServe:(NSMutableArray *)cookPrepServe
    recipeIngredients:(NSMutableArray *)ingredients
     recipeDirections:(NSMutableArray *)directions
           styleIndex: (NSNumber *) styleIndex
              atIndex: (NSUInteger) index {
    NSDictionary *newRecipe = [[NSDictionary alloc] initWithObjectsAndKeys:recipeName, kRecipeName, image, kImage, cookPrepServe, kCookPrepServe, ingredients, kIngredients, directions, kRecipeDirections, styleIndex, kStyleIndex, nil];
    
    [self insertRecipe: newRecipe styleIndex: styleIndex atIndex: index];
    //[self saveRecipe];
}



- (void) removeRecipeAtIndex:(NSUInteger) recipeIndex
                     styleIndex: (NSNumber *) styleIndex{
    if (recipeIndex < [self numberOfRecipes:styleIndex]) {
        NSUInteger tempStyleIndex = [styleIndex intValue];
        [self.recipes[tempStyleIndex] removeObjectAtIndex: recipeIndex];
        [self saveRecipe];
    }
}


- (NSDictionary *) nextRecipe {
    self.currentIndex ++;
    return self.recipes[self.currentIndex];
}

- (NSDictionary *) prevRecipe {
    self.currentIndex --;
    return self.recipes[self.currentIndex];
}
 
@end
