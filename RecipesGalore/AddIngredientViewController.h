//
//  AddQuoteViewController.h
//  AddQuote
//
//  Created by Nicholas Caceres on 10/14/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import <UIKit/UIKit.h>

// First parentheses can be named anything just as with a code block
// Second parentheses can insert anything just like block (argument)
typedef void (^AddIngredientCompletionHandler)(NSString *ingredientName,
                                          NSString *amount, NSString *measurement);

@interface AddIngredientViewController : UIViewController

// public property since in header file
@property (copy, nonatomic) AddIngredientCompletionHandler completionHandler;

@end

