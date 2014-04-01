//
//  LiveCellViewController.m
//  LiveTrip
//
//  Student Id: 4022828
//  Student Name: Jiasheng Zhou

#import "LiveCellViewController.h"

@interface LiveCellViewController ()

@end

@implementation LiveCellViewController

@synthesize aTrip;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    // change the cell background color with different types
    if ([aTrip.tripType intValue] == 1) {
        cell.backgroundColor = [UIColor orangeColor];
    }else if ([aTrip.tripType intValue] == 2){
        cell.backgroundColor = [UIColor yellowColor];
    }
    
    NSDateFormatter *aDateFormatter;
    
    // display information in different sections
    switch(indexPath.section)
    {
        case 0:
            if([aTrip.tripType intValue] == 1)
                cell.textLabel.text = @"Business";
            else
                cell.textLabel.text = @"Personal";
            break;
        case 1:
            if(indexPath.row == 0)
            {
                cell.textLabel.text = [NSString stringWithFormat: @"Start: %d",[aTrip.startOdometer intValue]];
            }
            if(indexPath.row == 1)
            {
                cell.textLabel.text = [NSString stringWithFormat: @"End: %d",[aTrip.endOdometer intValue]];
            }
            break;
        case 2:
            aDateFormatter = [[NSDateFormatter alloc] init];
            
            [aDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
            [aDateFormatter setDateFormat:@"dd:MM:yyyy   HH:mm:ss"];
            
            if(indexPath.row == 0)
            {
                cell.textLabel.text = [NSString stringWithFormat: @"Start: %@",[aDateFormatter stringFromDate:aTrip.startTime]];
            }
            if(indexPath.row == 1)
            {
                cell.textLabel.text = [NSString stringWithFormat: @"End: %@",[aDateFormatter stringFromDate:aTrip.endTime]];
            }
            break;
        case 3:
            if(indexPath.row == 0)
            {
                if ([aTrip.startLatitude intValue] >= 0) {
                    cell.textLabel.text = [NSString stringWithFormat: @"Latitude: %.4fS",[aTrip.startLatitude doubleValue]];
                }else{
                     cell.textLabel.text = [NSString stringWithFormat: @"Latitude: %.4fN",-[aTrip.startLatitude doubleValue]];
                }
                
            }
            if(indexPath.row == 1)
            {
                
                if ([aTrip.startLongtitude intValue] >= 0) {
                    cell.textLabel.text = [NSString stringWithFormat: @"Latitude: %.4fW",[aTrip.startLongtitude doubleValue]];
                }else{
                    cell.textLabel.text = [NSString stringWithFormat: @"Latitude: %.4fE",-[aTrip.startLongtitude doubleValue]];
                }
            }
            break;
        case 4:
            if(indexPath.row == 0)
            {
                if ([aTrip.startLatitude intValue] >= 0) {
                    cell.textLabel.text = [NSString stringWithFormat: @"Latitude: %.4fS",[aTrip.endLatitude doubleValue]];
                }else{
                    cell.textLabel.text = [NSString stringWithFormat: @"Latitude: %.4fN",-[aTrip.endLatitude doubleValue]];
                }
                
            }
            if(indexPath.row == 1)
            {
                
                if ([aTrip.startLongtitude intValue] >= 0) {
                    cell.textLabel.text = [NSString stringWithFormat: @"Latitude: %.4fW",[aTrip.endLongtitude doubleValue]];
                }else{
                    cell.textLabel.text = [NSString stringWithFormat: @"Latitude: %.4fE",-[aTrip.endLongtitude doubleValue]];
                }
            }
            break;
    }
    
    return cell;
}
// the first section has one row and others have two.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(section == 0){
        return 1;
    }else
    {
        return 2;
    }
}
// set title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Trip Type";
            break;
        case 1:
            return @"Odometer";
            break;
        case 2:
            return @"Time";
            break;
        case 3:
            return @"Start Position";
            break;
        case 4:
            return @"End Position";
            break;
        default:
            return @"";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // it is a static table so the sections number is five
    return 5;
}
@end
