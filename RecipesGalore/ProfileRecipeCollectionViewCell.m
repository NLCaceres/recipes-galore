//
//  ProfileRecipeCollectionViewCell.m
//  RecipesGalore
//
//  Created by Nick Caceres on 7/27/19.
//  Copyright © 2019 Nicholas Caceres. All rights reserved.
//

#import "ProfileRecipeCollectionViewCell.h"
#import "RecipeModel.h"

@interface ProfileRecipeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileRecipeImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileRecipeLabel;
@property (weak, nonatomic) IBOutlet UIButton *profileRecipeDeleteButton;
@property BOOL isDeleteMode;

@end

@implementation ProfileRecipeCollectionViewCell
@synthesize delegate;

- (void) setUpCell:(NSDictionary *) recipeDictionary {
    
    NSString *imageFileName = [recipeDictionary valueForKey:kImage];
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageFileName options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *fullImage = [UIImage imageWithData:imageData];
    if (fullImage) {
        self.profileRecipeImageView.image = fullImage;
    } else {
        self.profileRecipeImageView.image = [UIImage imageNamed:imageFileName];
    }
    self.profileRecipeImageView.layer.cornerRadius = 5.0;
    self.profileRecipeImageView.layer.masksToBounds = YES;
    
    NSString *recipeName = [recipeDictionary valueForKey:kRecipeName];
    self.profileRecipeLabel.text = recipeName;
        
    self.isDeleteMode = NO;
    [self.profileRecipeDeleteButton setHidden:YES];
}

- (void) setDeleteMode {
    self.isDeleteMode = !self.isDeleteMode;
    [self.profileRecipeDeleteButton setHidden:!self.profileRecipeDeleteButton.isHidden];
}

- (IBAction)deleteButtonTapped:(id)sender {
    [self.delegate deleteCell:self];
}

@end
