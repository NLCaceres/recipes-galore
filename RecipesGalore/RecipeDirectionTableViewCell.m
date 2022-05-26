//
//  RecipeDirectionTableViewCell.m
//  RecipesGalore
//
//  Created by Nick Caceres on 8/7/19.
//  Copyright © 2019 Nicholas Caceres. All rights reserved.
//

#import "RecipeDirectionTableViewCell.h"

@interface RecipeDirectionTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *recipeStepLabel;

@end

@implementation RecipeDirectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUpCell:(NSString *)direction {
    self.recipeStepLabel.text = direction;
}

@end
