//
//  RecipeViewController.m
//  RecipesGalore
//
//  Created by Lionel Caceres on 12/11/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import "RecipeViewController.h"
#import "RecipeModel.h"
#import "RefrigeratorModel.h"

#import <MessageUI/MFMessageComposeViewController.h>

@interface RecipeViewController () <MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *prepTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cookTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *servingSizeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *recipePic;
@property (weak, nonatomic) IBOutlet UILabel *recipeDirectionsLabel;
@property (strong, nonatomic) NSDictionary *recipeDictionary;
@property NSUInteger currentRecipeStep;
@property (strong, nonatomic) NSMutableArray *tempRecipeSteps;
@property (strong, nonatomic) NSMutableArray *tempIngredients;
@property (weak, nonatomic) IBOutlet UITableView *ingredientTableView;
//@property (weak, nonatomic) IBOutlet UIView *ingredientsView;
//@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel1;
//@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel2;
//@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel3;
//@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel4;
//@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel7;
//@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel10;
//@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel5;
//@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel6;
//@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel8;
//@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel9;
//@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel11;
//@property (weak, nonatomic) IBOutlet UILabel *ingredientLabel12;

@end

@implementation RecipeViewController
- (IBAction)shareButtonPressed:(id)sender {
    NSString *tempName = [self.recipeDictionary valueForKey:kRecipeName];
    [self sendSMS:@"I found an awesome new recipe! I have to tell you about it soon!" recipientList: [NSArray arrayWithObjects: @"213-867-5309", nil]];
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) sendSMS:(NSString *) messageBody recipientList: (NSArray *) recipients
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = messageBody;
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void) messageComposeViewController:(MFMessageComposeViewController *)controller
                  didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 if (result == MessageComposeResultCancelled) {
                                     NSLog(@"Message cancelled");
                                 }
                                 else if (result == MessageComposeResultSent) {
                                     NSLog(@"Message sent");
                                 }
                                 else {
                                     NSLog(@"Message failed");
                                 }
                             }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // set up nav bar
    self.navigationItem.title = [self.recipeDictionary valueForKey:kRecipeName];
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = backButton;
    
    // set up recipes image
    //self.recipePic.image = [UIImage imageNamed:[self.recipeDictionary valueForKey:kImage]];
    NSString *imageFileName = [self.recipeDictionary valueForKey:kImage];
    NSData *imageData = [[NSData alloc] initWithBase64EncodedString:imageFileName options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *fullImage = [UIImage imageWithData:imageData];
    if (fullImage) {
        self.recipePic.image = fullImage;
    } else {
        self.recipePic.image = [UIImage imageNamed:imageFileName];
    }
    self.recipePic.layer.cornerRadius = 5.0;
    self.recipePic.layer.masksToBounds = YES;
    
    // set up cook time, prep time, and serving size
    NSMutableArray *tempCookPrepServe = [[NSMutableArray alloc] initWithArray:[self.recipeDictionary valueForKey:kCookPrepServe]];
    self.prepTimeLabel.text = tempCookPrepServe[0];
    self.cookTimeLabel.text = tempCookPrepServe[1];
    self.servingSizeLabel.text = tempCookPrepServe[2];
    
    // set up ingredients
    self.tempIngredients = [[NSMutableArray alloc] initWithArray:[self.recipeDictionary valueForKey:kIngredients]];
//    if ([self.tempIngredients count] > 0) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//    }
//    if ([self.tempIngredients count] > 1) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//    }
//    if ([self.tempIngredients count] > 2) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//    }
//    if ([self.tempIngredients count] > 3) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//    }
//    if ([self.tempIngredients count] > 4) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//    }
//    if ([self.tempIngredients count] > 5) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//    }
//    if ([self.tempIngredients count] > 6) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//        self.ingredientLabel7.text = self.tempIngredients[6];
//    }
//    if ([self.tempIngredients count] > 7) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//        self.ingredientLabel7.text = self.tempIngredients[6];
//        self.ingredientLabel8.text = self.tempIngredients[7];
//    }
//    if ([self.tempIngredients count] > 8) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//        self.ingredientLabel7.text = self.tempIngredients[6];
//        self.ingredientLabel8.text = self.tempIngredients[7];
//        self.ingredientLabel9.text = self.tempIngredients[8];
//    }
//    if ([self.tempIngredients count] > 9) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//        self.ingredientLabel7.text = self.tempIngredients[6];
//        self.ingredientLabel8.text = self.tempIngredients[7];
//        self.ingredientLabel9.text = self.tempIngredients[8];
//        self.ingredientLabel10.text = self.tempIngredients[9];
//    }
//    if ([self.tempIngredients count] > 10) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//        self.ingredientLabel7.text = self.tempIngredients[6];
//        self.ingredientLabel8.text = self.tempIngredients[7];
//        self.ingredientLabel9.text = self.tempIngredients[8];
//        self.ingredientLabel10.text = self.tempIngredients[9];
//        self.ingredientLabel11.text = self.tempIngredients[10];
//    }
//    if ([self.tempIngredients count] > 11) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//        self.ingredientLabel7.text = self.tempIngredients[6];
//        self.ingredientLabel8.text = self.tempIngredients[7];
//        self.ingredientLabel9.text = self.tempIngredients[8];
//        self.ingredientLabel10.text = self.tempIngredients[9];
//        self.ingredientLabel11.text = self.tempIngredients[10];
//        self.ingredientLabel12.text = self.tempIngredients[11];
//    }

    // set up for recipe direction changing and ingredients viewing
    // Tap Gesture Recognizer
    
//    UISwipeGestureRecognizer *leftSwipeIngredients =
//    [[UISwipeGestureRecognizer alloc]
//     initWithTarget:self //.ingredientsView
//     action:@selector(leftSwipeRecognized:)];
//    leftSwipeIngredients.direction = UISwipeGestureRecognizerDirectionLeft;
//
//    UISwipeGestureRecognizer *rightSwipeIngredients =
//    [[UISwipeGestureRecognizer alloc]
//     initWithTarget:self //.ingredientsView
//     action:@selector(rightSwipeRecognized:)];
//    rightSwipeIngredients.direction = UISwipeGestureRecognizerDirectionRight;
//
//    [self.ingredientsView addGestureRecognizer:leftSwipeIngredients];
//    [self.ingredientsView addGestureRecognizer:rightSwipeIngredients];

    self.currentRecipeStep = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setRecipeDict:(NSDictionary *)recipeDict {
    
    NSString *tempRecipeName = [[NSString alloc] initWithString:[recipeDict valueForKey:kRecipeName]];
    NSString *tempRecipeImage = [[NSString alloc] initWithString:[recipeDict valueForKey:kImage]];
    NSMutableArray *tempCookPrepServe = [[NSMutableArray alloc] initWithArray:[recipeDict valueForKey:kCookPrepServe]];
    NSMutableArray *tempIngredients = [[NSMutableArray alloc] initWithArray:[recipeDict valueForKey:kIngredients]];
    NSMutableArray *tempRecipeDirections = [[NSMutableArray alloc] initWithArray:[recipeDict valueForKey:kRecipeDirections]];
    self.recipeDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:tempRecipeName, kRecipeName, tempRecipeImage, kImage, tempCookPrepServe, kCookPrepServe, tempIngredients, kIngredients, tempRecipeDirections, kRecipeDirections, nil];
}

//- (void) leftSwipeRecognized : (UIGestureRecognizer *) recognizer {
//    if ([self.tempIngredients count] > 12) {
//        self.ingredientLabel1.text = self.tempIngredients[12];
//        self.ingredientLabel2.text = nil;
//        self.ingredientLabel3.text = nil;
//        self.ingredientLabel4.text = nil;
//        self.ingredientLabel5.text = nil;
//        self.ingredientLabel6.text = nil;
//        self.ingredientLabel7.text = nil;
//        self.ingredientLabel8.text = nil;
//        self.ingredientLabel9.text = nil;
//        self.ingredientLabel10.text = nil;
//        self.ingredientLabel11.text = nil;
//        self.ingredientLabel12.text = nil;
//    }
//    if ([self.tempIngredients count] > 13) {
//        self.ingredientLabel1.text = self.tempIngredients[12];
//        self.ingredientLabel2.text = self.tempIngredients[13];
//        self.ingredientLabel3.text = nil;
//        self.ingredientLabel4.text = nil;
//        self.ingredientLabel5.text = nil;
//        self.ingredientLabel6.text = nil;
//        self.ingredientLabel7.text = nil;
//        self.ingredientLabel8.text = nil;
//        self.ingredientLabel9.text = nil;
//        self.ingredientLabel10.text = nil;
//        self.ingredientLabel11.text = nil;
//        self.ingredientLabel12.text = nil;
//    }
//    if ([self.tempIngredients count] > 14) {
//        self.ingredientLabel1.text = self.tempIngredients[12];
//        self.ingredientLabel2.text = self.tempIngredients[13];
//        self.ingredientLabel3.text = self.tempIngredients[14];
//        self.ingredientLabel4.text = nil;
//        self.ingredientLabel5.text = nil;
//        self.ingredientLabel6.text = nil;
//        self.ingredientLabel7.text = nil;
//        self.ingredientLabel8.text = nil;
//        self.ingredientLabel9.text = nil;
//        self.ingredientLabel10.text = nil;
//        self.ingredientLabel11.text = nil;
//        self.ingredientLabel12.text = nil;
//    }
//    if ([self.tempIngredients count] > 15) {
//        self.ingredientLabel1.text = self.tempIngredients[12];
//        self.ingredientLabel2.text = self.tempIngredients[13];
//        self.ingredientLabel3.text = self.tempIngredients[14];
//        self.ingredientLabel4.text = self.tempIngredients[15];
//        self.ingredientLabel5.text = nil;
//        self.ingredientLabel6.text = nil;
//        self.ingredientLabel7.text = nil;
//        self.ingredientLabel8.text = nil;
//        self.ingredientLabel9.text = nil;
//        self.ingredientLabel10.text = nil;
//        self.ingredientLabel11.text = nil;
//        self.ingredientLabel12.text = nil;
//    }
//    if ([self.tempIngredients count] > 16) {
//        self.ingredientLabel1.text = self.tempIngredients[12];
//        self.ingredientLabel2.text = self.tempIngredients[13];
//        self.ingredientLabel3.text = self.tempIngredients[14];
//        self.ingredientLabel4.text = self.tempIngredients[15];
//        self.ingredientLabel5.text = self.tempIngredients[16];
//        self.ingredientLabel6.text = nil;
//        self.ingredientLabel7.text = nil;
//        self.ingredientLabel8.text = nil;
//        self.ingredientLabel9.text = nil;
//        self.ingredientLabel10.text = nil;
//        self.ingredientLabel11.text = nil;
//        self.ingredientLabel12.text = nil;
//    }
//    if ([self.tempIngredients count] > 17) {
//        self.ingredientLabel1.text = self.tempIngredients[12];
//        self.ingredientLabel2.text = self.tempIngredients[13];
//        self.ingredientLabel3.text = self.tempIngredients[14];
//        self.ingredientLabel4.text = self.tempIngredients[15];
//        self.ingredientLabel5.text = self.tempIngredients[16];
//        self.ingredientLabel6.text = self.tempIngredients[17];
//        self.ingredientLabel7.text = nil;
//        self.ingredientLabel8.text = nil;
//        self.ingredientLabel9.text = nil;
//        self.ingredientLabel10.text = nil;
//        self.ingredientLabel11.text = nil;
//        self.ingredientLabel12.text = nil;
//    }
//    if ([self.tempIngredients count] > 18) {
//        self.ingredientLabel1.text = self.tempIngredients[12];
//        self.ingredientLabel2.text = self.tempIngredients[13];
//        self.ingredientLabel3.text = self.tempIngredients[14];
//        self.ingredientLabel4.text = self.tempIngredients[15];
//        self.ingredientLabel5.text = self.tempIngredients[16];
//        self.ingredientLabel6.text = self.tempIngredients[17];
//        self.ingredientLabel7.text = self.tempIngredients[18];
//        self.ingredientLabel8.text = nil;
//        self.ingredientLabel9.text = nil;
//        self.ingredientLabel10.text = nil;
//        self.ingredientLabel11.text = nil;
//        self.ingredientLabel12.text = nil;    }
//    if ([self.tempIngredients count] > 19) {
//        self.ingredientLabel1.text = self.tempIngredients[12];
//        self.ingredientLabel2.text = self.tempIngredients[13];
//        self.ingredientLabel3.text = self.tempIngredients[14];
//        self.ingredientLabel4.text = self.tempIngredients[15];
//        self.ingredientLabel5.text = self.tempIngredients[16];
//        self.ingredientLabel6.text = self.tempIngredients[17];
//        self.ingredientLabel7.text = self.tempIngredients[18];
//        self.ingredientLabel8.text = self.tempIngredients[19];
//        self.ingredientLabel9.text = nil;
//        self.ingredientLabel10.text = nil;
//        self.ingredientLabel11.text = nil;
//        self.ingredientLabel12.text = nil;
//    }
//    if ([self.tempIngredients count] > 20) {
//        self.ingredientLabel1.text = self.tempIngredients[12];
//        self.ingredientLabel2.text = self.tempIngredients[13];
//        self.ingredientLabel3.text = self.tempIngredients[14];
//        self.ingredientLabel4.text = self.tempIngredients[15];
//        self.ingredientLabel5.text = self.tempIngredients[16];
//        self.ingredientLabel6.text = self.tempIngredients[17];
//        self.ingredientLabel7.text = self.tempIngredients[18];
//        self.ingredientLabel8.text = self.tempIngredients[19];
//        self.ingredientLabel9.text = self.tempIngredients[20];
//        self.ingredientLabel10.text = nil;
//        self.ingredientLabel11.text = nil;
//        self.ingredientLabel12.text = nil;
//    }
//    if ([self.tempIngredients count] > 21) {
//        self.ingredientLabel1.text = self.tempIngredients[12];
//        self.ingredientLabel2.text = self.tempIngredients[13];
//        self.ingredientLabel3.text = self.tempIngredients[14];
//        self.ingredientLabel4.text = self.tempIngredients[15];
//        self.ingredientLabel5.text = self.tempIngredients[16];
//        self.ingredientLabel6.text = self.tempIngredients[17];
//        self.ingredientLabel7.text = self.tempIngredients[18];
//        self.ingredientLabel8.text = self.tempIngredients[19];
//        self.ingredientLabel9.text = self.tempIngredients[20];
//        self.ingredientLabel10.text = self.tempIngredients[21];
//        self.ingredientLabel11.text = nil;
//        self.ingredientLabel12.text = nil;
//    }
//    if ([self.tempIngredients count] > 22) {
//        self.ingredientLabel1.text = self.tempIngredients[12];
//        self.ingredientLabel2.text = self.tempIngredients[13];
//        self.ingredientLabel3.text = self.tempIngredients[14];
//        self.ingredientLabel4.text = self.tempIngredients[15];
//        self.ingredientLabel5.text = self.tempIngredients[16];
//        self.ingredientLabel6.text = self.tempIngredients[17];
//        self.ingredientLabel7.text = self.tempIngredients[18];
//        self.ingredientLabel8.text = self.tempIngredients[19];
//        self.ingredientLabel9.text = self.tempIngredients[20];
//        self.ingredientLabel10.text = self.tempIngredients[21];
//        self.ingredientLabel11.text = self.tempIngredients[22];
//        self.ingredientLabel12.text = nil;
//    }
//    if ([self.tempIngredients count] > 23) {
//        self.ingredientLabel1.text = self.tempIngredients[12];
//        self.ingredientLabel2.text = self.tempIngredients[13];
//        self.ingredientLabel3.text = self.tempIngredients[14];
//        self.ingredientLabel4.text = self.tempIngredients[15];
//        self.ingredientLabel5.text = self.tempIngredients[16];
//        self.ingredientLabel6.text = self.tempIngredients[17];
//        self.ingredientLabel7.text = self.tempIngredients[18];
//        self.ingredientLabel8.text = self.tempIngredients[19];
//        self.ingredientLabel9.text = self.tempIngredients[20];
//        self.ingredientLabel10.text = self.tempIngredients[21];
//        self.ingredientLabel11.text = self.tempIngredients[22];
//        self.ingredientLabel11.text = self.tempIngredients[23];
//    }
//}
//
//- (void) rightSwipeRecognized : (UIGestureRecognizer *) recognizer {
//    if ([self.tempIngredients count] > 0) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//    }
//    if ([self.tempIngredients count] > 1) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//    }
//    if ([self.tempIngredients count] > 2) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//    }
//    if ([self.tempIngredients count] > 3) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//    }
//    if ([self.tempIngredients count] > 4) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//    }
//    if ([self.tempIngredients count] > 5) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//    }
//    if ([self.tempIngredients count] > 6) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//        self.ingredientLabel7.text = self.tempIngredients[6];
//    }
//    if ([self.tempIngredients count] > 7) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//        self.ingredientLabel7.text = self.tempIngredients[6];
//        self.ingredientLabel8.text = self.tempIngredients[7];
//    }
//    if ([self.tempIngredients count] > 8) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//        self.ingredientLabel7.text = self.tempIngredients[6];
//        self.ingredientLabel8.text = self.tempIngredients[7];
//        self.ingredientLabel9.text = self.tempIngredients[8];
//    }
//    if ([self.tempIngredients count] > 9) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//        self.ingredientLabel7.text = self.tempIngredients[6];
//        self.ingredientLabel8.text = self.tempIngredients[7];
//        self.ingredientLabel9.text = self.tempIngredients[8];
//        self.ingredientLabel10.text = self.tempIngredients[9];
//    }
//    if ([self.tempIngredients count] > 10) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//        self.ingredientLabel7.text = self.tempIngredients[6];
//        self.ingredientLabel8.text = self.tempIngredients[7];
//        self.ingredientLabel9.text = self.tempIngredients[8];
//        self.ingredientLabel10.text = self.tempIngredients[9];
//        self.ingredientLabel11.text = self.tempIngredients[10];
//    }
//    if ([self.tempIngredients count] > 11) {
//        self.ingredientLabel1.text = self.tempIngredients[0];
//        self.ingredientLabel2.text = self.tempIngredients[1];
//        self.ingredientLabel3.text = self.tempIngredients[2];
//        self.ingredientLabel4.text = self.tempIngredients[3];
//        self.ingredientLabel5.text = self.tempIngredients[4];
//        self.ingredientLabel6.text = self.tempIngredients[5];
//        self.ingredientLabel7.text = self.tempIngredients[6];
//        self.ingredientLabel8.text = self.tempIngredients[7];
//        self.ingredientLabel9.text = self.tempIngredients[8];
//        self.ingredientLabel10.text = self.tempIngredients[9];
//        self.ingredientLabel11.text = self.tempIngredients[10];
//        self.ingredientLabel12.text = self.tempIngredients[11];
//    }
//}

- (IBAction) singleTapRecognized : (UITapGestureRecognizer *) recognizer {
    self.tempRecipeSteps = [[NSMutableArray alloc] initWithArray:[self.recipeDictionary valueForKey:kRecipeDirections]];
    self.recipeDirectionsLabel.text = self.tempRecipeSteps[self.currentRecipeStep];
}

- (IBAction) leftSwipeRecognizedDirections : (UIGestureRecognizer *) recognizer {
    if (self.currentRecipeStep < [self.tempRecipeSteps count] - 1) {
        self.currentRecipeStep++;
        self.recipeDirectionsLabel.text = self.tempRecipeSteps[self.currentRecipeStep];
    }
}

- (IBAction) rightSwipeRecognizedDirections : (UIGestureRecognizer *) recognizer {
    if (self.currentRecipeStep > 0) {
        self.currentRecipeStep--;
        self.recipeDirectionsLabel.text = self.tempRecipeSteps[self.currentRecipeStep];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tempIngredients.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RecipeCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"RecipeCell"];
    }
    
    NSString *ingredient = self.tempIngredients[indexPath.row];
    
    cell.textLabel.text = ingredient;
    
    return cell;
}

@end
