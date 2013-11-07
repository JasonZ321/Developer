//
//  MainViewController.m
//  Flickr
//
//  Created by Jason Zhou on 13-10-18.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (strong, nonatomic)NSURLConnection *connection;
@property (strong, nonatomic)UIAlertView *getLocation;
@property (strong, nonatomic)UIAlertView *getTags;
@property (strong, nonatomic)NSString *locationString;
@property (strong, nonatomic)NSString *tagsString;
@property (strong, nonatomic)NSString *locationId;
@property (strong, nonatomic)NSString *placeId;
@property (strong, nonatomic)NSNumber *longitude;
@property (strong, nonatomic)NSNumber *latitude;



@end

@implementation MainViewController
#define TAG_LOCATION 0
#define TAG_TAGS 1

bool isFirstConnection;
static NSString *key = @"310f4953f25455596724be4f8e779d64";
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    isFirstConnection = true;
    [self initLocationFromInput];
   
}
- (void)initLocationFromInput
{
    self.getLocation = [[UIAlertView alloc]initWithTitle:@"Please input a location" message:NULL delegate:self cancelButtonTitle:@"Confirm" otherButtonTitles:NULL, nil];
    self.getLocation.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *alertTextView = [self.getLocation textFieldAtIndex:0];
    
    alertTextView.placeholder = @"Address/City/State/Country";
    
    alertTextView.keyboardType = UIKeyboardAnimationCurveUserInfoKey;
    alertTextView.clearsOnBeginEditing = YES;
    alertTextView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.getLocation.tag = TAG_LOCATION;
    [self.getLocation show];
    
    
    
}
- (void) initTagsFromInput
{
    self.getTags = [[UIAlertView alloc]initWithTitle:@"Please input several tags seperated with comma" message:NULL delegate:self cancelButtonTitle:@"Confirm" otherButtonTitles:NULL, nil];
    self.getTags.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *alertTextView = [self.getLocation textFieldAtIndex:0];
    
    alertTextView.placeholder = @"Tag1,Tag2,Tag3";
    
    alertTextView.keyboardType = UIKeyboardAnimationCurveUserInfoKey;
    alertTextView.clearsOnBeginEditing = YES;
    alertTextView.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.getTags.tag = TAG_TAGS;
    [self.getTags show];
}
- (void) searchFlickrPhotosWithLocation:(NSString *)location{
     //NSLog(@"%@",location);
    location = [location stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    location = [location stringByAppendingString:@"+"];
        //NSLog(@"%@",location);
    NSString *urlString =  [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.places.find&api_key=%@&query=%@&format=json&nojsoncallback=1",key,location];
    NSLog(@"%@",urlString);
     NSURL *url = [NSURL URLWithString:urlString];
    // Create NSURL string from formatted string
   
   // NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
											 //cachePolicy:NSURLRequestUseProtocolCachePolicy
										// timeoutInterval:60.0];
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.connection start];
   // NSLog(@"123124");
    
}
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
{
    //self.recieved = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
   
    
        NSError *e = nil;
        NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
        NSArray *places = [[jsonArray objectForKey:@"places"] objectForKey:@"place"];
        NSDictionary *place = [places objectAtIndex:0];
        NSLog(@"woeid: %@",[place objectForKey:@"woeid"]);
        self.placeId =[place objectForKey:@"place_id"];
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    
        self.latitude = [f numberFromString:[place objectForKey:@"latitude"]];
        self.longitude = [f numberFromString:[place objectForKey:@"longitude"]];
        NSLog(@"%.4f",[self.latitude floatValue]);
        NSLog(@"%.4f",[self.longitude floatValue]);
    
    
    
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"toMap"]){
        if ([segue.destinationViewController isKindOfClass:[MapViewController class]]) {
             MapViewController *controller = (MapViewController *)segue.destinationViewController;
             controller.placeId = self.placeId;
            NSString *tags = [self.tagsString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
            tags = [tags stringByAppendingString:@"+"];
            controller.tags = tags;
            controller.longitude = self.longitude;
            controller.latitude = self.latitude;
        }
    }
    if([segue.identifier isEqualToString:@"toList"]){
        if ([segue.destinationViewController isKindOfClass:[ListViewController class]]) {
            ListViewController *controller = (ListViewController *)segue.destinationViewController;
            controller.placeId = self.placeId;
            NSString *tags = [self.tagsString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
            tags = [tags stringByAppendingString:@"+"];
            controller.tags = tags;
            controller.longitude = self.longitude;
            controller.latitude = self.latitude;
        }
    }

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (alertView.tag == TAG_LOCATION) {
        UITextField *alertTextView = [alertView textFieldAtIndex:0];
        self.locationString = alertTextView.text;
       // NSLog(@"%@",self.locationString);
        [self initTagsFromInput];
    }else{
        UITextField *alertTextView = [alertView textFieldAtIndex:0];
        self.tagsString = alertTextView.text;
       //NSLog(@"%@",self.tagsString);
         [self searchFlickrPhotosWithLocation:self.locationString];
    }
   
}
@end
