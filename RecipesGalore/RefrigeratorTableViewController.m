//
//  ExampleTableViewController.m
//  TableView
//
//  Created by Nicholas Caceres on 10/29/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import "AddIngredientViewController.h"
#import "RefrigeratorTableViewController.h"
#import "RefrigeratorModel.h"
#import "MainViewController.h"


@interface RefrigeratorTableViewController ()
@property (strong, nonatomic) RefrigeratorModel *ingredientSet;
@end

@implementation RefrigeratorTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ingredientSet = [RefrigeratorModel sharedModel];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.ingredientSet numberOfIngredients];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    NSDictionary *ingredients = [self.ingredientSet ingredientAtIndex:indexPath.row];
    NSString *ingredientName = ingredients[kIngredientName];
    NSString *ingredientAmount = ingredients[kAmount];
    NSString *ingredientMeasurement = ingredients[kMeasurement];
    NSString *newIngredient = [NSString stringWithFormat:@"%@ %@ %@", ingredientAmount, ingredientMeasurement, ingredientName];
    cell.textLabel.text = newIngredient;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete from the model
        [self.ingredientSet removeIngredientAtIndex:indexPath.row];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UINavigationController *navVC = segue.destinationViewController;
    AddIngredientViewController *addIngredientVC = (AddIngredientViewController *) navVC.topViewController;
    addIngredientVC.completionHandler = ^(NSString *ingredientName,
                                     NSString *amount, NSString *measurement) {
        if (ingredientName != nil) {
            [self.ingredientSet insertIngredient:ingredientName amount:amount measurement:measurement];
            [self.tableView reloadData];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
}


@end
