//
//  StationSearchViewController.m
//  TrainDelays
//
//  Created by Michael Pritchard on 26/02/2014.
//  Copyright (c) 2014 Michael Pritchard. All rights reserved.
//

#import "StationSearchViewController.h"
#import "SearchFormViewController.h"
#import "TrainDelayedCell.h"

@interface StationSearchViewController ()

@property (nonatomic) NSArray *searchResults;

@end

@implementation StationSearchViewController

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
    
    self.searchResults = [[NSMutableArray alloc] init];
    self.stations = [[NSMutableArray alloc] init];
    
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
        
        [self.stations addObject:dictionary];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView){
        return self.searchResults.count;
    }else{
        return self.stations.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellID = @"StationCellId";
    
    // dequeue a cell from self's table view
    TrainDelayedCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kCellID];
    
    if (tableView == self.searchDisplayController.searchResultsTableView){
        NSDictionary *tmDict = [self.searchResults objectAtIndex:indexPath.row];
        cell.textLabel.text = [tmDict objectForKeyedSubscript:@"stationName"];
        cell.crsCode = [tmDict objectForKeyedSubscript:@"crsCode"];
    }else{
        NSDictionary *tmDict = [self.stations objectAtIndex:indexPath.row];
        cell.textLabel.text = [tmDict objectForKeyedSubscript:@"stationName"];
        cell.crsCode = [tmDict objectForKeyedSubscript:@"crsCode"];
    }
    
    return cell;
}
                  
-(void)filterContetnForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultsPredicate = [NSPredicate predicateWithFormat:@"stationName contains[c] %@ OR crsCode contains[c] %@", searchText, searchText];
    self.searchResults = [self.stations filteredArrayUsingPredicate:resultsPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    [self filterContetnForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    TrainDelayedCell *cell = (TrainDelayedCell *) sender;
    SearchFormViewController *transferController = segue.destinationViewController;
    switch(self.mode){
            // to
        case 1:
            transferController.toStationCRS = cell.crsCode;
            transferController.toStationText = cell.textLabel.text;
            break;
        // from
        case 0:
            transferController.fromStationCRS = cell.crsCode;
            transferController.fromStationText = cell.textLabel.text;
            break;
    }
}



@end
