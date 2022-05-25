//
//  LoginViewController.m
//  RecipesGalore
//
//  Created by Nick Caceres on 7/30/19.
//  Copyright © 2019 Nicholas Caceres. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@property (strong, nonatomic) GIDConfiguration *signInConfig;

@property (weak, nonatomic) IBOutlet GIDSignInButton *loginButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Following ClientID should ALSO be included into UrlTypes (but in reverse)
    self.signInConfig = [[GIDConfiguration alloc] initWithClientID:@"232628018883-27hcdprf6mgtp9vlepfeg418va5qbv09.apps.googleusercontent.com"];
    self.loginButton.style = kGIDSignInButtonStyleWide;
    self.loginButton.colorScheme = kGIDSignInButtonColorSchemeDark;
}

- (IBAction)signIn:(id)sender {
    // Call sign in on login button tap
    [GIDSignIn.sharedInstance signInWithConfiguration:self.signInConfig
                           presentingViewController:self
                                           callback:^(GIDGoogleUser * _Nullable user,
                                                      NSError * _Nullable error) {
    if (error) {
      return;
    }

    // If sign in succeeded, segue to the actual content of the app
  }];
}

- (IBAction)signOut:(id)sender {
  [GIDSignIn.sharedInstance signOut];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
