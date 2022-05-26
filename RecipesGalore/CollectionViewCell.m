//
//  CollectionViewCell.m
//  Lab7
//
//  Created by Nicholas Caceres on 11/26/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import "CollectionViewCell.h"
#import "RecipeModel.h"
#import "CollectionViewController.h"

/* CollectionViewCell that displays recipes */

@interface CollectionViewCell ()
// IBOutlets
@property (weak, nonatomic) IBOutlet UIImageView *recipeImageView;
@property (weak, nonatomic) IBOutlet UILabel *recipeLabel;
@property (weak, nonatomic) IBOutlet UIButton *recipeDeleteButton;

@end

@implementation CollectionViewCell
@synthesize delegate;
@synthesize isDeleteMode;

- (void) setUpCell:(NSDictionary *) recipeDictionary {
    
    // Set up the image in the cell
    NSString *imageFileName = [recipeDictionary valueForKey:kImage];
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageFileName options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *fullImage = [UIImage imageWithData:imageData];
    if (fullImage) {
        self.recipeImageView.image = fullImage;
    } else {
        self.recipeImageView.image = [UIImage imageNamed:imageFileName];
    }
    self.recipeImageView.layer.cornerRadius = 5.0;
    self.recipeImageView.layer.masksToBounds = YES;
    
    // Set up the label for the cell
    NSString *recipeName = [recipeDictionary valueForKey:kRecipeName];
    self.recipeLabel.text = recipeName;
    
    self.isDeleteMode = NO;
    [self.recipeDeleteButton setHidden:YES];
}

- (void) setDeleteMode {
    self.isDeleteMode = !self.isDeleteMode;
    [self.recipeDeleteButton setHidden:!self.recipeDeleteButton.isHidden];
}

- (IBAction)deleteButtonTapped:(id)sender {
    [self.delegate deleteCell:self];
}

@end
