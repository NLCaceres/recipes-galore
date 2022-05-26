//
//  CollectionViewController.m
//  Lab7
//
//  Created by Nicholas Caceres on 11/26/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import "CollectionViewController.h"
#import "RecipeModel.h"
#import "CollectionViewCell.h"
#import "RefrigeratorModel.h"
#import "RecipeViewController.h"

/* CollectionView that displays recipes based on type clicked from previous MainViewController */

@interface CollectionViewController () <UICollectionViewDelegateFlowLayout>
//@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) RecipeModel *recipeSet;
@property (strong, nonatomic) RefrigeratorModel *ingredientSet;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"RecipeCell";
static NSString * const segueIdentifier = @"RecipeDetailSegue";

static UIEdgeInsets const sectionInsets = { .left = 20.0, .right = 20.0, .top = 15.0, .bottom = 50.0}; // designated inits technique
CGFloat const cellsPerRow = 2;

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    self.recipeSet = [RecipeModel sharedModel];
//    self.ingredientSet = [RefrigeratorModel sharedModel];
//    if (self.recipeStyleIndex == 0 ) {
//        self.navigationController.navigationBar.topItem.title = @"Ethnic Food";
//    }
//    else if (self.recipeStyleIndex == [NSNumber numberWithInt:1]) {
//        self.navigationController.navigationBar.topItem.title = @"Health Food";
//    }
//    else if (self.recipeStyleIndex == [NSNumber numberWithInt:2]) {
//        self.navigationController.navigationBar.topItem.title = @"Meat";
//    }
//    else if (self.recipeStyleIndex == [NSNumber numberWithInt:3]) {
//        self.navigationController.navigationBar.topItem.title = @"Seafood";
//    }
//    else if (self.recipeStyleIndex == [NSNumber numberWithInt:4]) {
//        self.navigationController.navigationBar.topItem.title = @"Snack";
//    }
//    else if (self.recipeStyleIndex == [NSNumber numberWithInt:5]) {
//        self.navigationController.navigationBar.topItem.title = @"Dessert";
//    }
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = backButton;

}

//- (void) viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    self.recipeSet = [RecipeModel sharedModel];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:segueIdentifier]) {
        
        NSArray *arrayOfIndexPath = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *chosenIndexPath = arrayOfIndexPath.firstObject;
        NSUInteger indexRow = chosenIndexPath.row;
        NSLog(@"%lu", indexRow);
        
        UINavigationController *navVC = segue.destinationViewController;
        RecipeViewController *recipeVC = (RecipeViewController *) [navVC topViewController];
        //[recipeVC.navigationController setTitle:self];
        [recipeVC setRecipeDict:[self.recipeSet recipeAtIndex:chosenIndexPath.row styleIndex: self.recipeStyleIndex]];
    }
}

- (IBAction)setDeleteMode:(id)sender {
    if ([self.editButton.title isEqualToString:@"Edit"]) {
        self.editButton.title = @"Done";
    } else {
        self.editButton.title = @"Edit";
    }
    NSArray *collectionViewCells = [self.collectionView visibleCells];
    for (CollectionViewCell* cvCell in collectionViewCells) {
        [cvCell setDeleteMode];
    }
//    for (int i=0; i <= [cellIndexPaths count]; i++) {
//        CollectionViewCell *currentCell = (CollectionViewCell *) cellIndexPaths
//        [currentCell setDeleteMode];
//    }
}
#pragma mark <DeletableCellProtocol>
- (void) deleteCell:(CollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    [self.recipeSet removeRecipeAtIndex:indexPath.row styleIndex:self.recipeStyleIndex];
    [self.collectionView deleteItemsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil]];
}

#pragma mark <UICollectionViewDataSource>

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    // placeSet is the data model class with the following public method to set up the Collection View
    return [self.recipeSet numberOfRecipes: self.recipeStyleIndex];
}

- (CollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                  forIndexPath:indexPath];
    
    NSDictionary *recipeSetUp = [self.recipeSet recipeAtIndex:indexPath.row styleIndex: self.recipeStyleIndex];
    [cell setUpCell: recipeSetUp];
    cell.delegate = self;
    
    return cell;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) [self.collectionView collectionViewLayout];
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        UIInterfaceOrientation orientation = UIApplication.sharedApplication.statusBarOrientation;
        if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        } else {
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
    } completion:nil];
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *clickedCell = (CollectionViewCell *) [collectionView cellForItemAtIndexPath:indexPath];
    if (clickedCell.isDeleteMode) {
        return;
    }
    [self performSegueWithIdentifier:segueIdentifier sender:clickedCell];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat paddingSpace = sectionInsets.left * (cellsPerRow + 1);
    CGFloat availableWidth = self.view.frame.size.width - paddingSpace;
    CGFloat widthPerItem = availableWidth / cellsPerRow;
    
    return CGSizeMake(widthPerItem, widthPerItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return sectionInsets;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return sectionInsets.bottom;
}

@end
