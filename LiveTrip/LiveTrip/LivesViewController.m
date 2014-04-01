//
//  LivesViewController.m
//  LiveTrip
//
//  Student Id: 4022828
//  Student Name: Jiasheng Zhou

#import "LivesViewController.h"
#import "AppDelegate.h"
#import "LiveCellViewController.h"
@interface LivesViewController ()
@property (retain, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSArray* lives;     // for storing all the information in live trip entity
@end

@implementation LivesViewController

@synthesize managedContext;
@synthesize startLatitudeArray;
@synthesize startLongtitudeArray;
@synthesize startOdometerArray;
@synthesize startTimeArray;
@synthesize endLatitudeArray;
@synthesize endLongtitudeArray;
@synthesize endOdometerArray;
@synthesize endTimeArray;
@synthesize tripType;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUp];
    
    self.tableview.delegate = self;
    self.tableview.dataSource =self;

}
- (void)setUp
{
   
    tripType = [[NSMutableArray alloc]init];
    startOdometerArray = [[NSMutableArray alloc]init];
    endOdometerArray = [[NSMutableArray alloc]init];
    startTimeArray = [[NSMutableArray alloc]init];
    endTimeArray = [[NSMutableArray alloc]init];
    startLatitudeArray = [[NSMutableArray alloc]init];
    endLongtitudeArray = [[NSMutableArray alloc]init];
    startLongtitudeArray = [[NSMutableArray alloc]init];
    endLatitudeArray = [[NSMutableArray alloc]init];
    
    

}
- (void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    managedContext = [appdelegate managedObjectContext];
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LiveTrip" inManagedObjectContext:managedContext];
    [request setEntity:entity];
    self.lives = [managedContext executeFetchRequest:request error:&error];
    // go through array lives and store informations to these 9 arrays
    for(LiveTrip *info in self.lives){
        [startOdometerArray addObject:info.startOdometer];
        [endOdometerArray addObject:info.endOdometer];
        [tripType addObject:info.tripType];
        [startLongtitudeArray addObject:info.startLongtitude];
        [endLongtitudeArray addObject:info.endLongtitude];
        [startLatitudeArray addObject:info.startLatitude];
        [endLatitudeArray addObject:info.endLatitude];
        [startTimeArray addObject:info.startTime];
        [endTimeArray addObject:info.endTime];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // each cell keeps the type of trip with different color to identify.
    NSNumber *type = [tripType objectAtIndex:[indexPath section]];
    if([type intValue] == 1){
        cell.textLabel.text = @"Business";
        cell.backgroundColor = [UIColor orangeColor];
    }else{
        cell.textLabel.text = @"Personal";
        cell.backgroundColor = [UIColor yellowColor];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault
                 reuseIdentifier:@"MyCell"] autorelease];
    }
    
    return cell;
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    int odo = [[startOdometerArray objectAtIndex:section] intValue];
    NSString *tmp = [NSString stringWithFormat:@"Start Odometer: %d",odo];
    return tmp;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    int odo = [[endOdometerArray objectAtIndex:section] intValue];
    NSString *tmp = [NSString stringWithFormat:@"End Odometer: %d",odo];
    return tmp;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [tripType count];
}
// for setting the label of header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    int odo = [[startOdometerArray objectAtIndex:section] intValue];
    NSString *tmp = [NSString stringWithFormat:@"Start Odometer: %d",odo];
    
    UILabel *lbl = [[[UILabel alloc] init] autorelease];
    lbl.textAlignment = UITextAlignmentCenter;
    lbl.font =  [UIFont systemFontOfSize:15.0];
    lbl.text = tmp;
    lbl.textColor = [UIColor colorWithRed:0.298 green:0.337 blue:0.423 alpha:1.000];
    [lbl setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    lbl.shadowOffset = CGSizeMake(0,1);
    lbl.alpha = 0.9;
    return lbl;
}
// for setting the label of footer
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    int odo = [[endOdometerArray objectAtIndex:section] intValue];
    NSString *tmp = [NSString stringWithFormat:@"End Odometer: %d",odo];
    
    UILabel *lbl = [[[UILabel alloc] init] autorelease];
    lbl.textAlignment = UITextAlignmentCenter;
    lbl.font =  [UIFont systemFontOfSize:15.0];
    lbl.text = tmp;
    lbl.textColor = [UIColor colorWithRed:0.298 green:0.337 blue:0.423 alpha:1.000];
    [lbl setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    lbl.shadowOffset = CGSizeMake(0,1);
    lbl.alpha = 0.9;
    return lbl;
}
// there are three height of cell depending on the value of distance
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int index = [indexPath section];
    double distance = [[endOdometerArray objectAtIndex:index] doubleValue] - [[startOdometerArray objectAtIndex:index] doubleValue];
    if(distance < 10){
        return 50.0;
    }else if(distance >= 10 && distance < 100){
        return 100.0;
    }else{
        return 150.0;
    }
    
}

// when user click a cell, it link to a liveCellViewController and get the detail information
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LiveCellViewController *liveCell = [[LiveCellViewController alloc]initWithStyle:UITableViewStyleGrouped];
    int index = [indexPath section];
    liveCell.aTrip = [self.lives objectAtIndex:index];
    [self.navigationController pushViewController:liveCell animated:YES];
    
}

- (void)dealloc {
    [_tableview release];
    [super dealloc];
}
@end
