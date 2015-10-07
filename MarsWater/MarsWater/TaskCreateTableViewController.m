//
//  TaskCreateTableViewController.m
//  MarsWater
//
//  Created by Jamaal Sedayao on 10/6/15.
//  Copyright © 2015 Jamaal Sedayao. All rights reserved.
//

#import "TaskCreateTableViewController.h"
#import "AppDelegate.h"
#import "Task.h"
#import <CoreData/CoreData.h>


@interface TaskCreateTableViewController ()

@property (nonatomic) Task *task;
@property (strong, nonatomic) IBOutlet UITextField *taskTitleTextField;
@property (nonatomic) NSMutableOrderedSet *taskForList;

@end

@implementation TaskCreateTableViewController

- (void) setupNavBar {
    
    self.navigationItem.title = @"New Task";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"List: %@",self.list);
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    self.task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:delegate.managedObjectContext];
    
    [self setupNavBar];
}

- (void) cancel{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) save{
    
    self.task.taskDescription = self.taskTitleTextField.text;
    self.task.createdAt = [NSDate date];
    
    self.taskForList = [[NSMutableOrderedSet alloc]init];
    
    self.taskForList = [self.list.tasks mutableCopy];
    
    [self.taskForList addObject:self.task];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    
    [delegate.managedObjectContext save:nil];

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

@end
