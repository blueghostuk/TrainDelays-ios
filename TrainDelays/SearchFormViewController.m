//
//  SearchFormViewController.m
//  TrainDelays
//
//  Created by Michael Pritchard on 27/02/2014.
//  Copyright (c) 2014 Michael Pritchard. All rights reserved.
//

#import "SearchFormViewController.h"
#import "StationSearchViewController.h"
#import "SearchResultsViewController.h"

@interface SearchFormViewController ()

@end

@implementation SearchFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.hidesBackButton = YES;
    
    [self.toStationBtn setTitle:[NSString stringWithFormat:@"To Station:%@", self.toStationText] forState:UIControlStateNormal];
    [self.fromStationBtn setTitle:[NSString stringWithFormat:@"From Station:%@", self.fromStationText] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"fromStationSegue"]){
        StationSearchViewController *fromViewController = segue.destinationViewController;
        fromViewController.mode = 0;
    }else if ([segue.identifier isEqualToString:@"toStationSegue"]){
        StationSearchViewController *toViewController = segue.destinationViewController;
        toViewController.mode = 1;
    }else if ([segue.identifier isEqualToString:@"doSearchSegue"]){
        SearchResultsViewController *transferViewController = segue.destinationViewController;
        transferViewController.fromStationCRS = self.fromStationCRS;
        transferViewController.toStationCRS = self.toStationCRS;
        transferViewController.searchTime = self.datePicker.date;
    }
}

@end
