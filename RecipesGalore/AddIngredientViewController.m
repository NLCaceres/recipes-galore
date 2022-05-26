//
//  AddQuoteViewController.m
//  AddQuote
//
//  Created by Nicholas Caceres on 10/14/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import "AddIngredientViewController.h"
#import "RefrigeratorTableViewController.h"
#import "RefrigeratorModel.h"
#import "MainViewController.h"

@interface AddIngredientViewController ()


@property (weak, nonatomic) IBOutlet UITextField *numberAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *ingredientNameTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *measurementPicker;
@property (strong, nonatomic) NSString *numberAmount;
@property (strong, nonatomic) NSString *ingredientName;
@property (strong, nonatomic) NSArray *measurementNames;
@property (strong, nonatomic) NSString *measurementFromPicker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (strong, nonatomic) RefrigeratorModel *ingredientSet;

@end

@implementation AddIngredientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ingredientSet = [RefrigeratorModel sharedModel];
    
    self.measurementNames = @[@"Whole", @"Dozen", @"Cup", @"Tbsp", @"Kg", @"Lb", @"mL", @"Oz", @"Pint", @"Quart", @"Gallon", @"Package", @"Slice", @"Can"];
    self.measurementFromPicker = self.measurementNames[0];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.numberAmountTextField becomeFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) enableSaveButton: (NSString *) nameText
//                   amount: (NSString *) amountText {
//
//    self.saveButton.enabled = (nameText.length > 0 &&
//                               amountText.length > 0);
//}
- (void) enableSave {
    self.saveButton.enabled = (self.ingredientName.length > 0 && self.numberAmount.length > 0);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.numberAmountTextField resignFirstResponder];
    [self.ingredientNameTextField resignFirstResponder];
}

- (IBAction)cancelButtonTapped:(id)sender {
    // Don't forget to add keyboard go away code
    [self.ingredientNameTextField resignFirstResponder];
    [self.numberAmountTextField resignFirstResponder];
    
    if (self.completionHandler) {
        self.completionHandler(nil, nil, nil);
    }
    
    self.ingredientNameTextField.text = nil;
    self.numberAmountTextField.text = nil;
    self.measurementFromPicker = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)saveButtonTapped:(id)sender {
    // Don't forget to add keyboard go away code
    [self.ingredientNameTextField resignFirstResponder];
    [self.numberAmountTextField resignFirstResponder];
    
    if (self.completionHandler) {
        self.completionHandler(self.ingredientNameTextField.text,
                               self.numberAmountTextField.text, self.measurementFromPicker);
    }
    
    self.ingredientNameTextField.text = nil;
    self.numberAmountTextField.text = nil;
    self.measurementFromPicker = nil;
    
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length == 1 && [string isEqualToString:@""]) {
        if (textField == self.ingredientNameTextField) { self.ingredientName = @""; }
        else { self.numberAmount = @""; }
    } else {
        NSString *fullString = [textField.text stringByAppendingString:string];
        if (textField == self.ingredientNameTextField) { self.ingredientName = fullString; }
        else { self.numberAmount = fullString; }
    }
    [self enableSave];
    return YES;
}
- (BOOL) textFieldShouldReturn: (UITextField *) textField {
    
    [textField resignFirstResponder];
    
    NSLog(@"%@", textField.text);
    if (self.completionHandler) {
        self.completionHandler(self.ingredientNameTextField.text,
                               self.numberAmountTextField.text, self.measurementFromPicker);
    }
    
    // set text to nothing
    self.ingredientNameTextField.text = nil;
    self.numberAmountTextField.text = nil;
    self.measurementFromPicker = nil;
    return YES;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger) numberOfComponentsInPickerView: (UIPickerView *) pickerView {
    return 1;
}
- (NSInteger) pickerView: (UIPickerView *) pickerView numberOfRowsInComponent:(NSInteger)component {
    return[self.measurementNames count];
}
- (NSString *) pickerView: (UIPickerView *) pickerView
              titleForRow:(NSInteger)row
             forComponent:(NSInteger)component {
    return self.measurementNames[row];
}

#pragma mark - UIPickerViewDelegate
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.measurementFromPicker = self.measurementNames[row];
}

//- (IBAction)buttonPressed:(id)sender {
//    NSInteger row = [self.measurementPicker selectedRowInComponent:0];
//    NSString *tempSelected = self.measurementNames[row];
//    self.selectedFromPicker = [[NSString alloc] initWithString:tempSelected];
//}

@end
