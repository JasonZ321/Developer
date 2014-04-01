//
//  StatsViewController.m
//  LiveTrip
//
//  Student Id: 4022828
//  Student Name: Jiasheng Zhou

#import "StatsViewController.h"
#import "DLPieChart.h"
#import "AppDelegate.h"
#import "LiveTrip.h"
@interface StatsViewController ()
@property (retain, nonatomic) IBOutlet  DLPieChart *piechartView;  
@property (strong, nonatomic) NSManagedObjectContext* context;
@property (strong,nonatomic) NSNumber* business;             // the proportion of business trip out of 100
@property (strong,nonatomic) NSNumber* personal;             // the proportion of personal trip out of 100
@end

@implementation StatsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    self.context = [appdelegate managedObjectContext];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [self getPersentage];
    NSMutableArray *dataArray = [[NSMutableArray alloc]initWithObjects:self.business,self.personal, nil];
    [self.piechartView renderInLayer:self.piechartView dataArray:dataArray];

}
// go through the database to get the proportion of business trip and personal trip
- (void)getPersentage
{
    NSError *error;
    double totalOdoForBusiness = 0;
    double totalOdoForPersonal = 0;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LiveTrip" inManagedObjectContext:self.context];
    [request setEntity:entity];
    NSArray *objects = [self.context executeFetchRequest:request error:&error];
    for(LiveTrip *live in objects){
        if([live.tripType intValue] == 1){
            double start = [live.startOdometer doubleValue];
            double end = [live.endOdometer doubleValue];
            totalOdoForBusiness += end - start;
        }
        else{
            double start = [live.startOdometer doubleValue];
            double end = [live.endOdometer doubleValue];
            totalOdoForPersonal += end - start;
        }
    }
    self.business = [NSNumber numberWithInt: round((totalOdoForBusiness/(totalOdoForBusiness+totalOdoForPersonal))*100)];
    
    self.personal = [NSNumber numberWithInt: round((totalOdoForPersonal/(totalOdoForBusiness+totalOdoForPersonal))*100)];
}



- (void)dealloc {
    [_piechartView release];
    [super dealloc];
}
@end
