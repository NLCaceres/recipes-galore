//
//  AddRecipeViewController.m
//  RecipesGalore
//
//  Created by Lionel Caceres on 12/11/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import "AddRecipeViewController.h"
#import "RecipeModel.h"
#import "ProfileViewController.h"
#import "RecipeDirectionTableViewCell.h"

@interface AddRecipeViewController () 

@property (weak, nonatomic) IBOutlet UITextField *recipeNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cookTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *prepTimeTextField;
@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;
@property (weak, nonatomic) IBOutlet UITextField *servingSizeTextField;
@property (weak, nonatomic) IBOutlet UITextField *ingredientNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *ingredientNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *recipeDirectionTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIPickerView *measurementPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *foodCategoryPicker;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) RecipeModel *recipeSet;
@property (strong, nonatomic) NSString *recipeName;
@property (strong, nonatomic) NSString *cookTime;
@property (strong, nonatomic) NSString *prepTime;
@property (strong, nonatomic) NSString *servingSize;
@property (strong, nonatomic) NSString *recipePic;
@property (strong, nonatomic) NSArray *measurementNames;
@property (strong, nonatomic) NSArray *foodCategoryNames;
@property (strong, nonatomic) NSString *measurementFromPicker;
@property (strong, nonatomic) NSString *foodCategoryFromPicker;
@property (strong, nonatomic) NSMutableArray *ingredientList;
@property (strong, nonatomic) NSMutableArray *directionList;
@end

@implementation AddRecipeViewController

static NSString * const ingredientCellIdentifier = @"IngredientCell";
static NSString * const recipeStepCellIdentifier = @"RecipeStepCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.measurementNames = @[@"Whole", @"Dozen", @"Cup", @"Tbsp", @"Kg", @"Lb", @"mL", @"Oz", @"Pint", @"Quart", @"Gallon", @"Package", @"Slice", @"Can"];
    self.measurementFromPicker = self.measurementNames[0];
    self.foodCategoryNames = @[@"Ethnic Food", @"Health Food", @"Meats", @"Seafood", @"Snacks", @"Dessert"];
    self.foodCategoryFromPicker = self.foodCategoryNames[0];
    
    self.ingredientList = [[NSMutableArray alloc] init];
    self.directionList = [[NSMutableArray alloc] init];
    
    self.recipeDirectionTextView.layer.cornerRadius = 5.0;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.recipeNameTextField becomeFirstResponder];
}

//- (void) enableSaveButton: (NSString *) recipeNameText
//                   cookTime: (NSString *) cookTimeText
//                 prepTime: (NSString *) prepTimeText
//              servingSize: (NSString *) servingSizeText
//          ingredientsList: (NSMutableArray *) ingredients
//               recipeSteps: (NSMutableArray *) directions
//               foodPicker: (NSString *) categoryPicked
//{
//
//    self.saveButton.enabled = (recipeNameText.length > 0 &&
//                               cookTimeText.length > 0 && prepTimeText.length > 0 && servingSizeText.length > 0 && [ingredients count] > 0 && [directions count] > 0 && categoryPicked.length > 0);
//    self.saveButton.enabled = (self.recipeNameTextField.text.length > 0 &&
//                               self.cookTimeTextField.text.length > 0 && self.prepTimeTextField.text.length > 0 && self.servingSizeTextField.text.length > 0 && [ingredients count] > 0 && [directions count] > 0);
//}
-(void) enableSave {
    self.saveButton.enabled = (self.recipeName.length > 0 && self.recipePic.length > 0 && self.cookTime.length > 0 && self.prepTime.length > 0 && self.servingSize.length > 0 && [self.ingredientList count] > 0 && [self.directionList count] > 0);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.recipeNameTextField resignFirstResponder];
    [self.cookTimeTextField resignFirstResponder];
    [self.prepTimeTextField resignFirstResponder];
    [self.servingSizeTextField resignFirstResponder];
    [self.ingredientNumberTextField resignFirstResponder];
    [self.ingredientNameTextField resignFirstResponder];
    [self.recipeDirectionTextView resignFirstResponder];
}


- (IBAction)addIngredientButton:(id)sender {
    NSString *tempIngredientNum = self.ingredientNumberTextField.text;
    NSInteger row = [self.measurementPicker selectedRowInComponent:0];
    NSString *tempSelected = self.measurementNames[row];
    self.measurementFromPicker = [[NSString alloc] initWithString:tempSelected];
    NSString *tempIngredientName = self.ingredientNameTextField.text;
    
    if ([tempIngredientNum length] > 0 && [tempIngredientName length] > 0) {
        NSString *tempIngredient = [NSString stringWithFormat:@"%@ %@ %@", tempIngredientNum, self.measurementFromPicker, tempIngredientName];
        [self.ingredientList addObject:tempIngredient];
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.ingredientList.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    
    self.measurementFromPicker = nil;
    self.ingredientNumberTextField.text = nil;
    self.ingredientNameTextField.text = nil;
    
    [self enableSave];
    //[self enableSaveButton:self.recipeNameTextField.text cookTime:self.cookTimeTextField.text prepTime:self.prepTimeTextField.text servingSize:self.servingSizeTextField.text ingredientsList: self.ingredientList recipeSteps: self.directionList foodPicker: self.foodCategoryFromPicker];
}
- (IBAction)addDirectionButton:(id)sender {
    NSString *tempRecipeStep = self.recipeDirectionTextView.text;
    if ([tempRecipeStep length] > 0) {
        [self.directionList addObject:tempRecipeStep];
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.directionList.count-1 inSection:1] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    
    self.recipeDirectionTextView.text = nil;
    
    [self enableSave];
    //[self enableSaveButton:self.recipeNameTextField.text cookTime:self.cookTimeTextField.text prepTime:self.prepTimeTextField.text servingSize:self.servingSizeTextField.text ingredientsList: self.ingredientList recipeSteps: self.directionList foodPicker: self.foodCategoryFromPicker];
}

- (IBAction)cancelButtonTapped:(id)sender {
    // Don't forget to add keyboard go away code
    [self.recipeNameTextField resignFirstResponder];
    [self.cookTimeTextField resignFirstResponder];
    [self.prepTimeTextField resignFirstResponder];
    [self.servingSizeTextField resignFirstResponder];
    [self.ingredientNumberTextField resignFirstResponder];
    [self.ingredientNameTextField resignFirstResponder];
    [self.recipeDirectionTextView resignFirstResponder];
    
    if (self.completionHandler) {
        self.completionHandler(nil, nil, nil, nil, nil, nil, nil, nil);
    }
    
    [self resetProps];
}
- (IBAction)saveButtonTapped:(id)sender {
    // Don't forget to add keyboard go away code
    [self.recipeNameTextField resignFirstResponder];
    [self.cookTimeTextField resignFirstResponder];
    [self.prepTimeTextField resignFirstResponder];
    [self.servingSizeTextField resignFirstResponder];
    [self.ingredientNumberTextField resignFirstResponder];
    [self.ingredientNameTextField resignFirstResponder];
    [self.recipeDirectionTextView resignFirstResponder];
    
    if (self.completionHandler) {
        self.completionHandler(self.recipeName, self.recipePic, self.cookTime, self.prepTime, self.servingSize, self.ingredientList, self.directionList, self.foodCategoryFromPicker);
    }
    
    [self resetProps];
}

- (void) resetProps {
    self.recipeNameTextField.text = self.recipeName = nil;
    self.cookTimeTextField.text = self.cookTime = nil;
    self.prepTimeTextField.text = self.prepTime = nil;
    self.servingSizeTextField.text = self.servingSize = nil;
    self.ingredientNumberTextField.text = nil;
    self.ingredientNameTextField.text = nil;
    self.recipeDirectionTextView.text = nil;
    self.measurementFromPicker = nil;
    self.foodCategoryFromPicker = nil;
    //[self.ingredientList removeAllObjects];
    //[self.directionList removeAllObjects];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

//- (IBAction)foodCategoryButtonPressed:(id)sender {
//    NSInteger row = [self.foodCategoryPicker selectedRowInComponent:0];
//    NSString *tempSelected = self.foodCategoryNames[row];
//    self.foodCategoryFromPicker = [[NSString alloc] initWithString:tempSelected];
//}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length == 1 && [string isEqualToString:@""]) {
        if (textField == self.recipeNameTextField) { self.recipeName = @""; }
        else if (textField == self.cookTimeTextField) { self.cookTime = @""; }
        else if (textField == self.prepTimeTextField) { self.prepTime = @""; }
        else if (textField == self.servingSizeTextField) { self.servingSize = @""; }
    } else {
        NSString *fullString = [textField.text stringByAppendingString:string];
        if (textField == self.recipeNameTextField) { self.recipeName = fullString; }
        else if (textField == self.cookTimeTextField) { self.cookTime = fullString; }
        else if (textField == self.prepTimeTextField) { self.prepTime = fullString; }
        else if (textField == self.servingSizeTextField){ self.servingSize = fullString; }
    }
    
    [self enableSave];
    return true;
}

#pragma mark - ImageViewPicker
- (IBAction)selectImageButton:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

- (void) imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary *)info {
    UIImage *selectedImage = info[UIImagePickerControllerOriginalImage];
    
    NSData *imageData = UIImagePNGRepresentation(selectedImage);
    
    self.recipePic = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    [self.selectImageButton setTitle:@"Image Chosen" forState:UIControlStateNormal];
    
    [self enableSave];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    [self.selectImageButton setTitle:@"Select Image" forState:UIControlStateNormal];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UIPickerViewDataSource
- (NSInteger) numberOfComponentsInPickerView: (UIPickerView *) pickerView {
    return 1;
}
- (NSInteger) pickerView: (UIPickerView *) pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:self.measurementPicker]) {
        return[self.measurementNames count];
    } else if ([pickerView isEqual:self.foodCategoryPicker]) {
        return[self.foodCategoryNames count];
    } else {
        return 0;
    }
}
- (NSString *) pickerView: (UIPickerView *) pickerView
              titleForRow:(NSInteger)row
             forComponent:(NSInteger)component {
    if ([pickerView isEqual:self.measurementPicker]) {
        return self.measurementNames[row];
    }
    else if ([pickerView isEqual:self.foodCategoryPicker]) {
        return self.foodCategoryNames[row];
    }
    else {
        return 0;
    }
}

#pragma mark - UIPickerViewDelegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.measurementPicker) {
        self.measurementFromPicker = self.measurementNames[row];
    } else { // FoodCategoryPicker
        self.foodCategoryFromPicker = self.foodCategoryNames[row];
    }
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor colorWithRed:0.13 green:1.0 blue:0.98 alpha:1.0];
    UITableViewHeaderFooterView *headerView = (UITableViewHeaderFooterView *) view;
    headerView.textLabel.font = [UIFont fontWithName:@"Noteworthy-Bold" size:16];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0 && self.ingredientList.count > 0) {
        return @"Ingredients";
    } else if (section == 1 && self.directionList.count > 0) {
        return @"Recipe Steps";
    }
    return nil;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) { // Ingredients Section
        return [self.ingredientList count];
    } else { // Recipe Steps Section
        return [self.directionList count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) { // Ingredients
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ingredientCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ingredientCellIdentifier];
        }
        cell.textLabel.text = self.ingredientList[indexPath.row];
        return cell;
    } else { // Recipe Steps
        RecipeDirectionTableViewCell *cell = (RecipeDirectionTableViewCell *) [tableView dequeueReusableCellWithIdentifier:recipeStepCellIdentifier];
        
        [cell setUpCell:self.directionList[indexPath.row]];
        return cell;
    }
}

@end
