//
//  DateCountdownTableViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/27/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "DateCountdownTableViewController.h"
#import "OrderedDictionary.h"

@interface DateCountdownTableViewController ()
@property (nonatomic) OrderedDictionary *specialDates;
@end

@implementation DateCountdownTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultPresets];
}

- (void)setupDefaultPresets {
    self.specialDates = [[OrderedDictionary alloc] init];
    
    NSArray *keys = @[@"CD Player Day",
                      @"International Day for Failure",
                      @"Push-Button Phone Day",
                      @"International Shareware Day",
                      @"International Programmer's Day",
                      @"Macintosh Computer Day"];
    
    NSArray *values = @[@[@"10 01 2015"],
                        @[@"10 13 2015"],
                        @[@"11 18 2015"],
                        @[@"12 13 2015"],
                        @[@"01 07 2016"],
                        @[@"01 24 2016"]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM dd yyyy"];
    
    for (int i = 0; i < [keys count]; i++) {
        NSDate *event = [formatter dateFromString:values[i]];
        [self.specialDates setObject:event forKey:keys[i]];
    }
    
    NSLog(@"%@", self.specialDates);
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.specialDates count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dateIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.specialDates keyAtIndex:indexPath.row]];
    return cell;
}

@end