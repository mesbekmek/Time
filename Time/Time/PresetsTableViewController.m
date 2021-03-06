//
//  PresetsTableViewController.m
//  Time
//
//  Created by Elber Carneiro on 8/23/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "PresetsTableViewController.h"
#import "NewPresetViewController.h"
#import "OrderedDictionary.h"
#import "DataSingleton.h"

@interface PresetsTableViewController ()
@property (nonatomic) DataSingleton *sharedSingleton;
@property (nonatomic) NSArray *selectedPreset;
@property (nonatomic) NSUInteger chosenIndex;
@property (nonatomic) UIColor *pink;
@end

@implementation PresetsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharedSingleton = [DataSingleton sharedDataSingleton];
    
    self.pink = [UIColor colorWithRed:255.0/255 green:128.0/255 blue:169.0/255 alpha:1.0];
    [self.navigationItem setTitle:@"Select Presets"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didSelectTimer)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    [self.navigationItem.leftBarButtonItem setEnabled:NO];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [[self.navigationController navigationBar] setBarTintColor:[UIColor colorWithRed:63.0/255 green:81.0/255 blue:181.0/255 alpha:1.0]];
    
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.navigationItem.leftBarButtonItem.enabled == NO) {
        [self.navigationItem.leftBarButtonItem setEnabled:YES];
    }
    self.selectedPreset = [self.sharedSingleton.presetTimers objectForKey:[self.sharedSingleton.presetTimers keyAtIndex:indexPath.row]];
}

- (void)didSelectTimer {
    
    NSString *key = [self.sharedSingleton.presetTimers getKeyForObject:self.selectedPreset];
    
    [self.delegate presetTime:self.selectedPreset withName:key];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)newPresetButtonPressed:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NewPresetViewController *newPresetVC = [storyboard instantiateViewControllerWithIdentifier:@"newPresetVC"];
    newPresetVC.delegate = self;
    
    [self presentViewController:newPresetVC animated:YES completion:nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sharedSingleton.presetTimers count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"presetIdentifier"];
    
    if (cell == nil) {
        cell =
        [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                               reuseIdentifier:@"presetIdentifier"];
    }
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:198.0/255 green:230.0/255 blue:204.0/255 alpha:1.0];
    cell.selectedBackgroundView = selectionColor;
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = self.pink;
    cell.textLabel.highlightedTextColor = self.pink;
    cell.detailTextLabel.textColor = self.pink;
    
    [cell.textLabel setFont:[UIFont fontWithName:@"Orbitron-Regular" size:20]];
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"DigitalReadoutExpUpright" size:20]];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.sharedSingleton.alphabeticalKeys[indexPath.row]];
    NSArray *presetTime = [self.sharedSingleton.presetTimers objectForKey:self.sharedSingleton.alphabeticalKeys[indexPath.row]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%@:%@", presetTime[0], presetTime[1], presetTime[2]];
    
    return cell;
}

#pragma mark - NewPresetViewControllerDelegate implementation
-(void)presetCreated:(NSArray *)countdownTime withName:(NSString *)timerName {
    [self.sharedSingleton setTimer:countdownTime withName:timerName];
}

@end
