//
//  IIIViewController.m
//  IIILocalizedIndexDemo
//
//  Created by sehone on 1/23/13.
//  Copyright (c) 2013 sehone. All rights reserved.
//

#import "IIIViewController.h"
#import "IIILocalizedIndex.h"

@interface IIIViewController ()
@property (strong, nonatomic) NSArray *keys;
@property (strong, nonatomic) NSDictionary *data;
@end

@implementation IIIViewController
@synthesize data = _data;

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        NSArray *arr = [self getData];
        self.data = [IIILocalizedIndex indexed:arr];
        self.keys = [self.data.allKeys sortedArrayUsingSelector:@selector(compare:)];
        
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }
    return self;
}



#pragma mark - Table view controller data source & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [self.keys objectAtIndex:section];
    NSArray *arr = [self.data objectForKey:key];
    return arr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.keys objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = indexPath.section;
    int row = indexPath.row;
    static NSString *CellIdentifier = @"commonCell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSArray *arr = [self.data objectForKey:[self.keys objectAtIndex:section]];
    cell.textLabel.text = [arr objectAtIndex:row];
    
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.keys;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}




# pragma mark - Data source

- (NSArray *)getData {
    NSArray *arr = [NSArray arrayWithObjects:
                    @"Nuovo cinema Paradiso",
                    @"12 Angry Men",
                    @"The Dark Knight",
                    @"Inception",
                    @"The Godfather",
                    @"3 Idiots",
                    @"Les choristes",
                    @"となりのトトロ",
                    @"Léon",
                    @"ラピュタ",
                    @"活着",
                    @"The Sound Of Music",
                    @"Toy Story",
                    @"Up",
                    @"B计划",
                    @"Singin' in the Rain",
                    @"A Beautiful Mind",
                    @"让子弹飞",
                    @"Gone with the Wind",
                    @"One Flew Over the Cuckoo's Nest",
                    @"七人の侍",
                    @"无间道",
                    @"Wreck-It Ralph",
                    @"Big Fish",
                    @"Braveheart",
                    @"阳光灿烂的日子",
                    @"Le grand bleu",
                    @"The Matrix",
                    @"东成西就",
                    @"羅生門",
                    @"緃横四海",
                    @"東邪西毒",
                    @"Öko",
                    nil];
    
    return arr;
}

@end
