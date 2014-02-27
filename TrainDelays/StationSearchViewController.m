//
//  StationSearchViewController.m
//  TrainDelays
//
//  Created by Michael Pritchard on 26/02/2014.
//  Copyright (c) 2014 Michael Pritchard. All rights reserved.
//

#import "StationSearchViewController.h"

@interface StationSearchViewController ()

@end

@implementation StationSearchViewController

NSMutableArray *myObject;
NSDictionary *dictionary;

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
    
    myObject = [[NSMutableArray alloc] init];
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:@"http://api.trainnotifier.co.uk/Station/?apiName=td-ios"]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:Nil];
    
    for(NSDictionary *dataDict in jsonObjects){
        NSString * stationName = [dataDict objectForKey:@"StationName"];
        NSString * crsCode = [dataDict objectForKey:@"CRS"];
        
        NSLog(@"Station Name: %@",stationName);
        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      stationName, @"stationName",
                      crsCode, @"crsCode",
                      Nil];
        
        [myObject addObject:dictionary];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return myObject.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellID = @"StationCellId";
    
    // dequeue a cell from self's table view
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellID];
    
    NSDictionary *tmDict = [myObject objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [tmDict objectForKeyedSubscript:@"stationName"];
    
    return cell;
}



@end
