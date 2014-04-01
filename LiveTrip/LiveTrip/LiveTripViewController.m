//
//  LiveTripViewController.m
//  LiveTrip
//
//  Student Id: 4022828
//  Student Name: Jiasheng Zhou

#import "LiveTripViewController.h"
#import "AppDelegate.h"
@interface LiveTripViewController ()

@property (retain,nonatomic) IBOutlet UIAlertView *inputOdometer;
@property (strong,nonatomic) CLLocation *oldlocation;
@property (strong,nonatomic) CLLocation* currentlocation;
@property (strong, nonatomic) NSNumber* latestOdometer;     
@property (retain, nonatomic) IBOutlet UILabel *distanceLabel;
@property (retain, nonatomic) IBOutlet UILabel *startOdoLabelText;
@property (retain, nonatomic) IBOutlet UILabel *currentOdoLabelText;
@property (retain, nonatomic) IBOutlet UILabel *currentOdoLabelNum;
@property (retain, nonatomic) IBOutlet UILabel *startOdoLabelNum;
@property (retain, nonatomic) IBOutlet UIButton *mainButton; // button for start or stop

@property (nonatomic) BOOL justStart;       // to determin if the start button is just clicked
@property (nonatomic) BOOL justStop;        // to determin if the stop button is just clicked
@property double distance;                  // the distance in a single drive
- (IBAction) startOrStop:(UIButton*)sender; 
@end

@implementation LiveTripViewController
@synthesize livetrip;
@synthesize location;
@synthesize managedContext;

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation* newlocation = [locations lastObject];
    
    NSDate* eventDate = newlocation.timestamp;
    if(self.justStart == YES){
        // if just start then store the start information to NSManagedObject livetrip
        self.justStart = NO;
        livetrip.startLatitude = [NSNumber numberWithDouble:newlocation.coordinate.latitude];
        livetrip.startLongtitude = [NSNumber numberWithDouble:newlocation.coordinate.longitude];
        livetrip.startTime = newlocation.timestamp;
    }
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        CLLocationDistance distance;
        
        if(self.oldlocation != nil)
        {
            // calculate distance between old and new location, and convert to kilo unit
            distance = [newlocation distanceFromLocation:self.oldlocation]/1000.0;
                
        }
        // update old location
        self.oldlocation = newlocation;
        self.distance += distance;
        self.distanceLabel.text = [NSString stringWithFormat:@"%.1f",self.distance];
        double tmp = [self.latestOdometer doubleValue] + distance;
        int cur = round(tmp);
        // always show the decimal value for odometer on screen but store it as double
        self.latestOdometer = [[NSNumber alloc]initWithDouble:tmp];
      
        self.currentOdoLabelNum.text = [NSString stringWithFormat:@"%d",cur];
        
        self.currentlocation = newlocation;         // every time keep current location
    }
       
    
    
}
- (IBAction)startOrStop:(UIButton*)sender
{
    
    
    if ([self.mainButton.titleLabel.text isEqualToString:@"Start"])
    {
        // initialize alert view
        self.inputOdometer = [[UIAlertView alloc]initWithTitle:@"Confirm Start Odometer" message:NULL delegate:self cancelButtonTitle:@"Start Trip" otherButtonTitles:NULL, nil];
        self.inputOdometer.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *alertTextView = [self.inputOdometer textFieldAtIndex:0];
        self.latestOdometer = [self getLatestOdometer];
        alertTextView.placeholder = [NSString stringWithFormat:@"%d",[self.latestOdometer intValue]];
        
        alertTextView.keyboardType = UIKeyboardTypeNumberPad;
        alertTextView.clearsOnBeginEditing = YES;
        alertTextView.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.justStart = YES;
        [self.inputOdometer show];
    }else
    {
        // clear distance
        self.distance = 0;
        // stop updating location
        [location stopUpdatingLocation];
        // store information to NSManagedObject livetrip
        livetrip.endLatitude = [NSNumber numberWithDouble:self.currentlocation.coordinate.latitude];
        livetrip.endLongtitude = [NSNumber numberWithDouble:self.currentlocation.coordinate.longitude];
        livetrip.endOdometer = self.latestOdometer;
        livetrip.endTime = [NSDate date];
        NSError *error;
        // save to core data
        if(![self.managedContext save:&error]){
            NSLog(@"couldn't save");
        }
        // change the mainbutton title to start and the image
        [self.mainButton setTitle:@"Start" forState:UIControlStateNormal];
        UIImage *img = [UIImage imageNamed:@"circle2.png"];
       
        [self.mainButton setBackgroundImage:img forState:UIControlStateNormal];
        
    }
    
    
 
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
   
    // show the alert view
    
    if(buttonIndex == 0){
        UITextField *alertTextView = [alertView textFieldAtIndex:0];
        // if nothing has been input then keep the latest Odometer as start Odometer
        // otherwise keep the input value as start Odometer
        if(alertTextView.text.length == 0)
        {
                        
            self.startOdoLabelNum.text = [NSString stringWithFormat:@"%d",[self.latestOdometer intValue]];
            self.currentOdoLabelNum.text = [NSString stringWithFormat:@"%d",[self.latestOdometer intValue]];
        }else{
           
            self.startOdoLabelNum.text = alertTextView.text;
            self.currentOdoLabelNum.text = alertTextView.text;
            NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
            [f setNumberStyle:NSNumberFormatterDecimalStyle];
            NSNumber * myNumber = [f numberFromString:alertTextView.text];
            [f release];
            self.latestOdometer = myNumber;
        }
        // prepare to insert a new row into core data
        livetrip = [NSEntityDescription insertNewObjectForEntityForName:@"LiveTrip" inManagedObjectContext:managedContext];
        livetrip.startOdometer = self.latestOdometer;
        // show action sheet
        UIActionSheet *actionsheet = [[UIActionSheet alloc]initWithTitle:@"Pick a trip type" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Business",@"Personal",nil];
        [actionsheet showInView:self.tabBarController.view];
          
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int type;
    if (buttonIndex == 0) {
        type = 1;
    }else if(buttonIndex == 1){
        type = 2;
    }
    
    livetrip.tripType = [NSNumber numberWithInt:type];
    
    
    [self.mainButton setTitle:@"Stop" forState:UIControlStateNormal];
    UIImage *img = [UIImage imageNamed:@"circle1.png"];
    [self.mainButton setBackgroundImage:img forState:UIControlStateNormal];
    // set the hidden display labels unhidden
    self.startOdoLabelText.hidden = NO;
    self.currentOdoLabelText.hidden = NO;
    self.startOdoLabelNum.hidden = NO;
    self.currentOdoLabelNum.hidden = NO;
    // start updating location
    [location startUpdatingLocation];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    location = [[CLLocationManager alloc]init];
    location.delegate = self;
    location.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    managedContext = [appdelegate managedObjectContext];
    //[self cleanData];
	// Do any additional setup after loading the view.
}

- (NSNumber *)getLatestOdometer
{
    AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appdelegate managedObjectContext];
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LiveTrip" inManagedObjectContext:context];
    [request setEntity:entity];
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    LiveTrip *live = [result lastObject];
    return live.endOdometer;
}

- (void)dealloc {
    
    [_distanceLabel release];
    [_startOdoLabelText release];
    [_currentOdoLabelText release];
    [_currentOdoLabelNum release];
    [_startOdoLabelNum release];
    [_mainButton release];
    [super dealloc];
}
/* stuff for debug
 - (void) cleanData
 {
 AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
 NSManagedObjectContext *context = [appdelegate managedObjectContext];
 NSError *error;
 NSFetchRequest *request = [[NSFetchRequest alloc] init];
 NSEntityDescription *entity = [NSEntityDescription entityForName:@"LiveTrip" inManagedObjectContext:context];
 [request setEntity:entity];
 NSArray *result = [context executeFetchRequest:request error:&error];
 for(LiveTrip *obj in result){
 [self.managedContext deleteObject:obj];
 }
 
 if(![self.managedContext save:&error]){
 NSLog(@"couldn't save");
 }
 
 }
 
 - (void) showData
 {
 NSError *error;
 NSFetchRequest *request = [[NSFetchRequest alloc] init];
 NSEntityDescription *entity = [NSEntityDescription entityForName:@"LiveTrip" inManagedObjectContext:managedContext];
 [request setEntity:entity];
 NSArray *objects = [managedContext executeFetchRequest:request error:&error];
 for(LiveTrip *info in objects){
 NSLog(@"Start o: %@",info.startOdometer);
 NSLog(@"End o: %@",info.endOdometer);
 NSLog(@"Start lati:%@",info.startLatitude);
 NSLog(@"Start long:%@",info.startLongtitude);
 NSLog(@"Start Time:%@",info.startTime);
 NSLog(@"End lati: %@",info.endLatitude);
 NSLog(@"End long: %@",info.endLongtitude);
 NSLog(@"End Time: %@",info.endTime);
 }
 }
 */
@end
