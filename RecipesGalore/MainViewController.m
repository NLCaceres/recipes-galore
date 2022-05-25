//
//  ViewController.m
//  RecipesGalore
//
//  Created by Lionel Caceres on 12/10/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import "MainViewController.h"
#import "CollectionViewController.h"
#import "MainViewCollectionViewCell.h"
#import "RecipeModel.h"
#import "RefrigeratorModel.h"
#import "LoginViewController.h"

//#import <FBSDKCoreKit/FBSDKCoreKit.h>
//#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface MainViewController () <UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation MainViewController

static NSString * const foodStyleIdentifier = @"FoodStyleSegue";

static UIEdgeInsets const sectionInsets = { .left = 50.0, .right = 50.0, .top = 25.0, .bottom = 25.0}; // designated inits technique
static CGFloat const itemsPerRow = 2;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Swap in Google Login
    //FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    //loginButton.center = self.view.center;
    //[self.view addSubview:loginButton];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    if (!GIDSignIn.sharedInstance.hasPreviousSignIn) { // If NOT logged in
        [self.loginButton setHidden:NO];
        [self.tabBarController.tabBar setHidden:YES];
    } else { // Is Logged In
        [self.loginButton setHidden:YES];
        [self.tabBarController.tabBar setHidden:NO];
        //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        //UITabBarController *tabBarController = (UITabBarController *) [storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
        //[self presentViewController:tabBarController animated:YES completion:nil];
    }
    
    // If required, reload tables, etc. here
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Modify this segue into a single one with identifiers based on collectionView - PROBABLY
- (void) prepareForSegue:(UIStoryboardSegue *)segue
                  sender:(id)sender {
    if ([segue.identifier isEqualToString:foodStyleIdentifier]) {
        UINavigationController *navVC = segue.destinationViewController;
        CollectionViewController *recipeVC = (CollectionViewController *) navVC.topViewController;
        MainViewCollectionViewCell *clickedCell = (MainViewCollectionViewCell *) sender;
        NSString *foodType = clickedCell.getFoodType;
        recipeVC.navigationItem.title = foodType;
        
        if ([foodType isEqualToString: @"Ethnic Food"]) { recipeVC.recipeStyleIndex = [NSNumber numberWithInt:0]; }
        else if ([foodType isEqualToString: @"Health Food"]) { recipeVC.recipeStyleIndex = [NSNumber numberWithInt:1]; }
        else if ([foodType isEqualToString: @"Meats"]) { recipeVC.recipeStyleIndex = [NSNumber numberWithInt:2]; }
        else if ([foodType isEqualToString: @"Seafood"]) { recipeVC.recipeStyleIndex = [NSNumber numberWithInt:3]; }
        else if ([foodType isEqualToString: @"Snack"]){ recipeVC.recipeStyleIndex = [NSNumber numberWithInt:4]; }
        else if ([foodType isEqualToString: @"Desserts"]) { recipeVC.recipeStyleIndex = [NSNumber numberWithInt:5]; }
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    // placeSet is the data model class with the following public method to set up the Collection View
    return 6;
}

- (MainViewCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MainViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FoodTypeCell"
                                                                         forIndexPath:indexPath];
    
    [cell setUpCell: indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    MainViewCollectionViewCell *clickedCell = (MainViewCollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    [self performSegueWithIdentifier:foodStyleIdentifier sender:clickedCell];
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
