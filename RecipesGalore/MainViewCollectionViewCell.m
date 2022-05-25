//
//  MainViewCollectionViewCell.m
//  RecipesGalore
//
//  Created by Nick Caceres on 7/25/19.
//  Copyright © 2019 Nicholas Caceres. All rights reserved.
//

#import "MainViewCollectionViewCell.h"
#import "MainViewController.h"

@interface MainViewCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *foodTypeImage;
@property (weak, nonatomic) IBOutlet UILabel *foodTypeLabel;

@end

@implementation MainViewCollectionViewCell

- (void) setUpCell:(NSInteger)collectionViewCellTag {
    int cvCellTag = (int) collectionViewCellTag;
    switch (cvCellTag) {
        case 0: // Ethnic
            self.foodTypeImage.image = [UIImage imageNamed:@"ethnicFood"];
            self.foodTypeLabel.text = @"Ethnic Food";
            break;
        case 1: // Health
            self.foodTypeImage.image = [UIImage imageNamed:@"diet"];
            self.foodTypeLabel.text = @"Health Food";
            break;
        case 2: // Meats
            self.foodTypeImage.image = [UIImage imageNamed:@"meats"];
            self.foodTypeLabel.text = @"Meats";
            break;
        case 3: // Seafood
            self.foodTypeImage.image = [UIImage imageNamed:@"seafood"];
            self.foodTypeLabel.text = @"Seafood";
            break;
        case 4: // Snack
            self.foodTypeImage.image = [UIImage imageNamed:@"yogurt"];
            self.foodTypeLabel.text = @"Snack";
            break;
        case 5: // Dessert
            self.foodTypeImage.image = [UIImage imageNamed:@"dessert"];
            self.foodTypeLabel.text = @"Desserts";
            break;
        default:
            self.foodTypeImage.image = [UIImage imageNamed:@"diet"];
            self.foodTypeLabel.text = @"Diet Food";
            break;
    }
}

- (NSString *) getFoodType { return self.foodTypeLabel.text; }

@end
