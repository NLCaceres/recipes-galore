//
//  ProfileViewController.m
//  RecipesGalore
//
//  Created by Lionel Caceres on 12/11/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileRecipeCollectionViewCell.h"
#import "RecipeModel.h"
#import "AddRecipeViewController.h"

@interface ProfileViewController () <UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) RecipeModel *recipeSet;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
//@property (weak, nonatomic) IBOutlet UIView *userRecipesView;
//@property (weak, nonatomic) IBOutlet UIImageView *userRecipeImage1;
//@property (weak, nonatomic) IBOutlet UIImageView *userRecipeImage2;
//@property (weak, nonatomic) IBOutlet UIImageView *userRecipeImage3;
//@property (weak, nonatomic) IBOutlet UILabel *userRecipeLabel1;
//@property (weak, nonatomic) IBOutlet UILabel *userRecipeLabel2;
//@property (weak, nonatomic) IBOutlet UILabel *userRecipeLabel3;
//@property  NSUInteger currentRecipeIndex0;
//@property NSUInteger currentRecipeIndex1;
//@property NSUInteger currentRecipeIndex2;
@end

@implementation ProfileViewController

static UIEdgeInsets const sectionInsets = { .top = 15.0, .left = 20.0, .bottom = 50.0, .right = 20.0}; // designated inits technique
static CGFloat const itemsPerRow = 2;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = backButton;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userEmail = (NSMutableString *) [defaults stringForKey:@"UserEmail"];
    if (userEmail) {
        NSArray *seperatedStrings = [userEmail componentsSeparatedByString:@"@"];
        self.userNameLabel.text = [self.userNameLabel.text stringByAppendingString: seperatedStrings[0]];
    }
    
    self.recipeSet = [RecipeModel sharedModel];
    self.userProfileImageView.layer.cornerRadius = 5.0;
    
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressRecognizer.delaysTouchesBegan = YES;
    [self.collectionView addGestureRecognizer:longPressRecognizer];
    
    //    self.currentRecipeIndex0 = 0;
    //    self.currentRecipeIndex1 = 1;
    //    self.currentRecipeIndex2 = 2;
    //
    //    // set up recipes image
    //    if ([self.recipeSet numberOfRecipes:[NSNumber numberWithInt:6]] > self.currentRecipeIndex0) {
    //        NSDictionary *tempRecipe1 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex0 styleIndex:[NSNumber numberWithInt:6]]];
    //
    //        NSString *tempImage1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey:kImage]];
    //        self.userRecipeImage1.image = tempImage1;
    //        self.userRecipeImage2.image = nil;
    //        self.userRecipeImage3.image = nil;
    //
    //        NSString *tempName1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey: kRecipeName]];
    //        self.userRecipeLabel1.text = tempName1;
    //        self.userRecipeLabel2.text = nil;
    //        self.userRecipeLabel3.text = nil;
    //
    //    }
    //    else if ([self.recipeSet numberOfRecipes:[NSNumber numberWithInt:6]] > self.currentRecipeIndex1) {
    //        NSDictionary *tempRecipe1 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex0 styleIndex:[NSNumber numberWithInt:6]]];
    //
    //        NSString *tempImage1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey:kImage]];
    //
    //        self.userRecipeImage1.image = tempImage1;
    //        self.userRecipeImage3.image = nil;
    //
    //        NSString *tempName1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey: kRecipeName]];
    //        self.userRecipeLabel1.text = tempName1;
    //        self.userRecipeLabel3.text = nil;
    //
    //        NSDictionary *tempRecipe2 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex1 styleIndex:[NSNumber numberWithInt:6]]];
    //        NSString *tempImage2 = [[NSString alloc] initWithString:[tempRecipe2 valueForKey:kImage]];
    //        NSString *tempName2 = [[NSString alloc] initWithString:[tempRecipe2 valueForKey:kRecipeName]];
    //
    //        self.userRecipeImage2.image = tempImage2;
    //        self.userRecipeLabel2.text = tempName2;
    //
    //    }
    //    else if ([self.recipeSet numberOfRecipes:[NSNumber numberWithInt:6]] > self.currentRecipeIndex2) {
    //        NSDictionary *tempRecipe1 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex0 styleIndex:[NSNumber numberWithInt:6]]];
    //        NSString *tempImage1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey:kImage]];
    //        NSString *tempName1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey: kRecipeName]];
    //
    //        self.userRecipeImage1.image = tempImage1;
    //        self.userRecipeLabel1.text = tempName1;
    //
    //        NSDictionary *tempRecipe2 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex1 styleIndex:[NSNumber numberWithInt:6]]];
    //        NSString *tempImage2 = [[NSString alloc] initWithString:[tempRecipe2 valueForKey:kImage]];
    //        NSString *tempName2 = [[NSString alloc] initWithString:[tempRecipe2 valueForKey: kRecipeName]];
    //
    //        self.userRecipeImage2.image = tempImage2;
    //        self.userRecipeLabel2.text = tempName2;
    //
    //        NSDictionary *tempRecipe3 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex2 styleIndex:[NSNumber numberWithInt:6]]];
    //        NSString *tempImage3 = [[NSString alloc] initWithString:[tempRecipe3 valueForKey:kImage]];
    //        NSString *tempName3 = [[NSString alloc] initWithString:[tempRecipe3 valueForKey: kRecipeName]];
    //
    //        self.userRecipeImage3.image = tempImage3;
    //        self.userRecipeLabel3.text = tempName3;
    //    }
    //
    //    UISwipeGestureRecognizer *leftSwipeUserRecipes =
    //    [[UISwipeGestureRecognizer alloc]
    //     initWithTarget:self.userRecipesView
    //     action:@selector(leftSwipeRecognized:)];
    //    leftSwipeUserRecipes.direction = UISwipeGestureRecognizerDirectionLeft;
    //
    //    UISwipeGestureRecognizer *rightSwipeUserRecipes =
    //    [[UISwipeGestureRecognizer alloc]
    //     initWithTarget:self.userRecipesView
    //     action:@selector(rightSwipeRecognized:)];
    //    rightSwipeUserRecipes.direction = UISwipeGestureRecognizerDirectionRight;
    //
    //    [self.view addGestureRecognizer:leftSwipeUserRecipes];
    //    [self.view addGestureRecognizer:rightSwipeUserRecipes];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.deleteButton setTitle:@"-" forState:UIControlStateNormal];
}

- (void) beginEditMode {
    if ([self.deleteButton.titleLabel.text isEqualToString:@"-"]) {
        [self.deleteButton setTitle:@"X" forState:UIControlStateNormal];
    } else {
        [self.deleteButton setTitle:@"-" forState:UIControlStateNormal];
    }
    NSArray *collectionViewCells = [self.collectionView visibleCells];
    for (ProfileRecipeCollectionViewCell* cvCell in collectionViewCells) {
        [cvCell setDeleteMode];
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];

    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    if (indexPath == nil){
        NSLog(@"Did not click cell");
    } else {
        [self beginEditMode];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddNewRecipe : (id)sender {
    [self performSegueWithIdentifier:@"AddNewRecipe" sender:sender];
}

- (IBAction)logoutButtonClicked:(id)sender {
    [GIDSignIn.sharedInstance signOut];
    [self.tabBarController setSelectedIndex:1];
}
//- (void) leftSwipeRecognized : (UIGestureRecognizer *) recognizer {
//    self.currentRecipeIndex0 += 3;
//    self.currentRecipeIndex1 += 3;
//    self.currentRecipeIndex2 += 3;
//    if ([self.recipeSet numberOfRecipes:[NSNumber numberWithInt:6]] > self.currentRecipeIndex0) {
//        NSDictionary *tempRecipe1 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex0 styleIndex:[NSNumber numberWithInt:6]]];
//
//        NSString *tempImage1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey:kImage]];
//        self.userRecipeImage1.image = tempImage1;
//        self.userRecipeImage2.image = nil;
//        self.userRecipeImage3.image = nil;
//
//        NSString *tempName1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey: kRecipeName]];
//        self.userRecipeLabel1.text = tempName1;
//        self.userRecipeLabel2.text = nil;
//        self.userRecipeLabel3.text = nil;
//
//    }
//    else if ([self.recipeSet numberOfRecipes:[NSNumber numberWithInt:6]] > self.currentRecipeIndex1) {
//        NSDictionary *tempRecipe1 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex0 styleIndex:[NSNumber numberWithInt:6]]];
//
//        NSString *tempImage1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey:kImage]];
//
//        self.userRecipeImage1.image = tempImage1;
//        self.userRecipeImage3.image = nil;
//
//        NSString *tempName1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey: kRecipeName]];
//        self.userRecipeLabel1.text = tempName1;
//        self.userRecipeLabel3.text = nil;
//
//        NSDictionary *tempRecipe2 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex1 styleIndex:[NSNumber numberWithInt:6]]];
//        NSString *tempImage2 = [[NSString alloc] initWithString:[tempRecipe2 valueForKey:kImage]];
//        NSString *tempName2 = [[NSString alloc] initWithString:[tempRecipe2 valueForKey:kRecipeName]];
//
//        self.userRecipeImage2.image = tempImage2;
//        self.userRecipeLabel2.text = tempName2;
//
//    }
//    else if ([self.recipeSet numberOfRecipes:[NSNumber numberWithInt:6]] > self.currentRecipeIndex2) {
//        NSDictionary *tempRecipe1 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex0 styleIndex:[NSNumber numberWithInt:6]]];
//        NSString *tempImage1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey:kImage]];
//        NSString *tempName1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey: kRecipeName]];
//
//        self.userRecipeImage1.image = tempImage1;
//        self.userRecipeLabel1.text = tempName1;
//
//        NSDictionary *tempRecipe2 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex1 styleIndex:[NSNumber numberWithInt:6]]];
//        NSString *tempImage2 = [[NSString alloc] initWithString:[tempRecipe2 valueForKey:kImage]];
//        NSString *tempName2 = [[NSString alloc] initWithString:[tempRecipe2 valueForKey: kRecipeName]];
//
//        self.userRecipeImage2.image = tempImage2;
//        self.userRecipeLabel2.text = tempName2;
//
//        NSDictionary *tempRecipe3 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex2 styleIndex:[NSNumber numberWithInt:6]]];
//        NSString *tempImage3 = [[NSString alloc] initWithString:[tempRecipe3 valueForKey:kImage]];
//        NSString *tempName3 = [[NSString alloc] initWithString:[tempRecipe3 valueForKey: kRecipeName]];
//
//        self.userRecipeImage3.image = tempImage3;
//        self.userRecipeLabel3.text = tempName3;
//    }
//}
//- (void) rightSwipeRecognized : (UIGestureRecognizer *) recognizer {
//    self.currentRecipeIndex0 -= 3;
//    self.currentRecipeIndex1 -= 3;
//    self.currentRecipeIndex2 -= 3;
//    if ([self.recipeSet numberOfRecipes:[NSNumber numberWithInt:6]] > self.currentRecipeIndex0) {
//        NSDictionary *tempRecipe1 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex0 styleIndex:[NSNumber numberWithInt:6]]];
//
//        NSString *tempImage1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey:kImage]];
//        self.userRecipeImage1.image = tempImage1;
//        self.userRecipeImage2.image = nil;
//        self.userRecipeImage3.image = nil;
//
//        NSString *tempName1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey: kRecipeName]];
//        self.userRecipeLabel1.text = tempName1;
//        self.userRecipeLabel2.text = nil;
//        self.userRecipeLabel3.text = nil;
//
//    }
//    else if ([self.recipeSet numberOfRecipes:[NSNumber numberWithInt:6]] > self.currentRecipeIndex1) {
//        NSDictionary *tempRecipe1 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex0 styleIndex:[NSNumber numberWithInt:6]]];
//
//        NSString *tempImage1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey:kImage]];
//
//        self.userRecipeImage1.image = tempImage1;
//        self.userRecipeImage3.image = nil;
//
//        NSString *tempName1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey: kRecipeName]];
//        self.userRecipeLabel1.text = tempName1;
//        self.userRecipeLabel3.text = nil;
//
//        NSDictionary *tempRecipe2 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex1 styleIndex:[NSNumber numberWithInt:6]]];
//        NSString *tempImage2 = [[NSString alloc] initWithString:[tempRecipe2 valueForKey:kImage]];
//        NSString *tempName2 = [[NSString alloc] initWithString:[tempRecipe2 valueForKey:kRecipeName]];
//
//        self.userRecipeImage2.image = tempImage2;
//        self.userRecipeLabel2.text = tempName2;
//
//    }
//    else if ([self.recipeSet numberOfRecipes:[NSNumber numberWithInt:6]] > self.currentRecipeIndex2) {
//        NSDictionary *tempRecipe1 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex0 styleIndex:[NSNumber numberWithInt:6]]];
//        NSString *tempImage1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey:kImage]];
//        NSString *tempName1 = [[NSString alloc] initWithString:[tempRecipe1 valueForKey: kRecipeName]];
//
//        self.userRecipeImage1.image = tempImage1;
//        self.userRecipeLabel1.text = tempName1;
//
//        NSDictionary *tempRecipe2 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex1 styleIndex:[NSNumber numberWithInt:6]]];
//        NSString *tempImage2 = [[NSString alloc] initWithString:[tempRecipe2 valueForKey:kImage]];
//        NSString *tempName2 = [[NSString alloc] initWithString:[tempRecipe2 valueForKey: kRecipeName]];
//
//        self.userRecipeImage2.image = tempImage2;
//        self.userRecipeLabel2.text = tempName2;
//
//        NSDictionary *tempRecipe3 = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:self.currentRecipeIndex2 styleIndex:[NSNumber numberWithInt:6]]];
//        NSString *tempImage3 = [[NSString alloc] initWithString:[tempRecipe3 valueForKey:kImage]];
//        NSString *tempName3 = [[NSString alloc] initWithString:[tempRecipe3 valueForKey: kRecipeName]];
//
//        self.userRecipeImage3.image = tempImage3;
//        self.userRecipeLabel3.text = tempName3;
//    }
//}

- (IBAction)deleteRecipesMode:(id)sender {
    [self beginEditMode];
}
#pragma mark - DeletableCellProtocol
- (void) deleteCell:(ProfileRecipeCollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    [self.recipeSet removeRecipeAtIndex:indexPath.row styleIndex:[NSNumber numberWithInt:6]];
    [self.collectionView deleteItemsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil]];
    if (self.collectionView.visibleCells.count == 0) {
        [self.deleteButton setTitle:@"-" forState:UIControlStateNormal];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UINavigationController *navVC = segue.destinationViewController;
    AddRecipeViewController *addRecipeVC = (AddRecipeViewController *) navVC.topViewController;
    
    addRecipeVC.completionHandler = ^(NSString *recipeName, NSString *recipeImage, NSString *cookTime, NSString *prepTime, NSString *servingSize, NSMutableArray *ingredientList, NSMutableArray *direcionList, NSString *category) {
        if (recipeName != nil) {
            NSString *tempCookTime = [NSString stringWithFormat:@"Cook Time: %@ minutes", cookTime];
            NSString *tempPrepTime = [NSString stringWithFormat:@"Prep Time: %@ minutes", prepTime];
            NSString *tempServingSize = [NSString stringWithFormat:@" Serves: %@ people", servingSize];
            NSMutableArray *tempCookPrepServe = [[NSMutableArray alloc] initWithObjects:tempPrepTime, tempCookTime, tempServingSize, nil];
            NSNumber *tempCategoryIndex;
            if ([category isEqualToString:@"Ethnic Food"]) {
                tempCategoryIndex = [NSNumber numberWithInt:0];
            }
            else if ([category isEqualToString:@"Health Food"]) {
                tempCategoryIndex = [NSNumber numberWithInt:1];
            }
            else if ([category isEqualToString:@"Meats"]) {
                tempCategoryIndex = [NSNumber numberWithInt:2];
            }
            else if ([category isEqualToString:@"Seafood"]) {
                tempCategoryIndex = [NSNumber numberWithInt:3];
            }
            else if ([category isEqualToString:@"Snacks"]) {
                tempCategoryIndex = [NSNumber numberWithInt:4];
            }
            else if ([category isEqualToString:@"Dessert"]) {
                tempCategoryIndex = [NSNumber numberWithInt:5];
            }
            [self.recipeSet insertRecipe:recipeName recipeImage:recipeImage cookPrepServe:tempCookPrepServe recipeIngredients:ingredientList recipeDirections:direcionList styleIndex:tempCategoryIndex]; // Add to big list
            [self.recipeSet insertRecipe:recipeName recipeImage:recipeImage cookPrepServe:tempCookPrepServe recipeIngredients:ingredientList recipeDirections:direcionList styleIndex:[NSNumber numberWithInt:6]]; // Add to user's list of recipes
            [self.collectionView reloadData];
        }
    };
    // [self.view setNeedsLayout];
}

#pragma mark - CollectionViewDataSource
- (ProfileRecipeCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfileRecipeCollectionViewCell *cell = (ProfileRecipeCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileRecipeCell" forIndexPath:indexPath];
    
    NSDictionary *tempRecipe = [[NSDictionary alloc] initWithDictionary:[self.recipeSet recipeAtIndex:indexPath.row styleIndex:[NSNumber numberWithInt:6]]]; // Index 6 should be User Recipes
    
    [cell setUpCell:tempRecipe];
    cell.delegate = self;
    
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.recipeSet numberOfRecipes:[NSNumber numberWithInt:6]];
}

#pragma mark - CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Should tap on recipe and take you to recipeViewController
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat paddingSpace = sectionInsets.left * (itemsPerRow + 1);
    CGFloat availableWidth = self.view.frame.size.width - paddingSpace;
    CGFloat widthPerItem = availableWidth / itemsPerRow;
    
    return CGSizeMake(widthPerItem, widthPerItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return sectionInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return sectionInsets.bottom;
}

@end
