//
//  FlickerPhotoTVC.m
//  scrollview
//
//  Created by Jason Zhou on 13-9-13.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "FlickerPhotoTVC.h"

@interface FlickerPhotoTVC ()

@end

@implementation FlickerPhotoTVC





#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 50;
}
- (NSString *)titleForRow:(NSInteger*)row
{
    return @"hehe";
}

- (NSString *)subtitleForRow:(NSInteger*)row
{
    return @"haha";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Flicker Photo";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow: indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
