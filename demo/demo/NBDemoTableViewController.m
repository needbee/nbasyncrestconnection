//
//  NBDemoTableViewController.m
//  demo
//
//  Created by Josh Justice on 8/2/14.
//  Copyright (c) 2014 NeedBee. All rights reserved.
//

#import "NBDemoTableViewController.h"
#import "Geoname.h"

@interface NBDemoTableViewController ()

@property (nonatomic,retain) NBDemoRestConnection *conn;
@property (nonatomic,retain) NSArray *cities;

@end

@implementation NBDemoTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.conn = [[NBDemoRestConnection alloc] initWithBaseUrl:@"http://api.geonames.org/"
                                                     username:@"needbee"];
    [_conn getCitiesWithinNorth:44.1 south:-9.9 east:-22.4 west:55.2 withDelegate:self];
}

#pragma mark - demo rest connection delegate

- (void)operationFailedWithStatusCode:(int)code
                              message:(NSString *)msg
{
    [[[UIAlertView alloc] initWithTitle:@"Error"
                                message:@"Could not connect to server."
                               delegate:nil
                      cancelButtonTitle:@"Drat"
                      otherButtonTitles:nil] show];
}

-(void)getCitiesOperationFinishedWithCities:(NSArray *)cities
{
    self.cities = cities;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Geoname *city = [_cities objectAtIndex:indexPath.row];
    cell.textLabel.text = city.name;
    cell.detailTextLabel.text = city.countryCode;
    
    return cell;
}

@end
