//
//  KVOTest1ViewController.m
//  KVOTest1
//
//  Created by Michael Nachbaur on 11-07-28.
//  Copyright 2011 Decaf Ninja Software. All rights reserved.
//

#import "KVOTest1ViewController.h"
#import "AppStoreItemView.h"

#define CELL_COUNT 20
#define CELL_HEIGHT 57

@implementation KVOTest1ViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return CELL_COUNT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const ReuseIdentifier = @"AppStoreCell";
    
    AppStoreItemView *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (nil == cell) {
        cell = [[[AppStoreItemView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseIdentifier] autorelease];
    }
    
    // Set the app icon for this cell
    int iconNumber = indexPath.row % 4;
    NSString *iconName = [NSString stringWithFormat:@"Icon%d", iconNumber];
    cell.icon = [UIImage imageNamed:iconName];

    // Arbitrarily decide which icons need gloss effects
    BOOL showsGloss = indexPath.row < 10;
    cell.iconNeedsGlossEffect = showsGloss;
    
    // Set some text labels
    cell.textLabel.text = [NSString stringWithFormat:@"Title %d", indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"By Company %d", indexPath.row];
    
    return (UITableViewCell*)cell;
}

@end
