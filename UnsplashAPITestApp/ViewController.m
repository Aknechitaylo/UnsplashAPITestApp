//
//  ViewController.m
//  UnsplashAPITestApp
//
//  Created by Андрей on 29.07.2019.
//  Copyright © 2019 Андрей. All rights reserved.
//

#import "ViewController.h"
#import "SearchResultsCollectionViewController.h"



@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)nextButtonTouchUpInside {
    if (![self.searchTextField.text isEqualToString:@""])
        [self performSegueWithIdentifier:@"ShowCollectionViewSegueID" sender:self.searchTextField.text];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SearchResultsCollectionViewController *searchResultsCollectionViewController = [segue destinationViewController];
    searchResultsCollectionViewController.headerText = sender;
}

@end
