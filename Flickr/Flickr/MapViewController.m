//
//  MapViewController.m
//  Flickr
//
//  Created by Jason Zhou on 13-10-18.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "MapViewController.h"
#import "GetPhoto.h"
#import "AnnotationViewController.h"

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic)NSDictionary *jsonArray;
@property (strong, nonatomic)NSMutableArray *requestsArray;
@property (strong, nonatomic)NSMutableData * myData;
@property (strong, nonatomic)NSMutableArray *locations;
//@property (strong, nonatomic)NSMutableArray *connnections;

@end

@implementation MapViewController
static NSString *key = @"310f4953f25455596724be4f8e779d64";
int indexOfConn = 0;
bool isFirst = true;
int size = 0;
- (void)viewDidLoad
{

    [super viewDidLoad];
    [self focusOnMap];
    [self.myMapView setDelegate:self];
    //NSLog(@"wwww: %@",self.woeid);
    self.locations = [[NSMutableArray alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&place_id=%@&has_geo=1&format=json&nojsoncallback=1",key,self.tags,self.placeId];
    NSLog(@"%@",urlString);
    //NSURL *url = [NSURL URLWithString:urlString];
    // Create NSURL string from formatted string
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
											 cachePolicy:NSURLRequestUseProtocolCachePolicy
										 timeoutInterval:60.0];
    // Setup and start async download
    // NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [self.connection start];
    
    
	// Do any additional setup after loading the view.
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	assert(self.myData==nil);
	self.myData = [[NSMutableData alloc] init];
}
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
{
    //self.recieved = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self.myData appendData:data];
   // NSError *e = nil;
    //self.jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
   // NSLog(@"array: %@",self.jsonArray);
   
    
}
- (Annotation *)getPhotoWithId:(NSString *)p_id andTitle:(NSString *)title
{
     Annotation *ann = [[Annotation alloc]init];
    
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=%@&photo_id=%@&format=json&nojsoncallback=1",key,p_id];
    //NSLog(@"%@",urlString);
    
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //NSLog(@"here");
    //Session object with no delegate
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                            delegate:nil
                                                       delegateQueue:[NSOperationQueue mainQueue]];
    
    //URL with the Pi website
    NSURL *myURL = [NSURL URLWithString:urlString];
    
    //Task with url and completionBlock
    NSURLSessionDataTask* task = [mySession dataTaskWithURL:myURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &error];
       // NSLog(@"%@",dic);
        CLLocationCoordinate2D location;
        NSDictionary *loc = [[dic objectForKey:@"photo"] objectForKey:@"location"];
        location.latitude = [[loc objectForKey:@"latitude"] doubleValue];
        location.longitude = [[loc objectForKey:@"longitude"] doubleValue];
       // NSLog(@"%.2f    %.2f",location.latitude,location.longitude);
       
        ann.coordinate = location;
        ann.title = title;
        [self.myMapView addAnnotation:ann];
        //NSLog(@"%@",[[loc objectForKey:@"neighbourhood"] objectForKey:@"_content"]);
        
        NSString *tmp = [[NSString alloc]init];
        NSString *neighbourhood = [[loc objectForKey:@"neighbourhood"] objectForKey:@"_content"];
        NSString *locality = [[loc objectForKey:@"locality"] objectForKey:@"_content"];
        NSString *region = [[loc objectForKey:@"region"] objectForKey:@"_content"];
        NSString *country = [[loc objectForKey:@"country"] objectForKey:@"_content"];
        
        if (neighbourhood != nil && region != nil && locality != nil && country != nil) {
            tmp = [tmp stringByAppendingString:neighbourhood];
            tmp = [tmp stringByAppendingString:@","];
            tmp = [tmp stringByAppendingString:locality];
            tmp = [tmp stringByAppendingString:@","];
            tmp = [tmp stringByAppendingString:region];
            tmp = [tmp stringByAppendingString:@","];
            tmp = [tmp stringByAppendingString:country];
        }else
            tmp = @"Unknown";

        ann.address = tmp;
        
       
        
        //[self.locations addObject:ann];
       // MKAnnotationView *annView = [MKAnnotationView alloc]initWithAnnotation:ann reuseIdentifier:(NSString *)
        
    }];
    
    //Must use resume to start the task
    [task resume];
    
    //If we set the delegate, the delegate is strongly references and is released using the below call
    [mySession finishTasksAndInvalidate];
    return ann;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    Annotation *ann = (Annotation *)view.annotation;
    
    AnnotationViewController *annVC = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"annVC"];
    annVC.annotation = ann;
    [self.navigationController pushViewController:annVC animated:YES];
    
    
}


/*
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if([annotation isKindOfClass:[Annotation class]])
    {
        NSString *annotationIdentifier = @"CustomViewAnnotation";
       
        
        MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationIdentifier];
        
        if (annotationView)
        {
            annotationView.annotation = annotation;
        }
        else
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:annotationIdentifier];
        }
        
        annotationView.canShowCallout= NO;
        /*
        NSURL *url = [NSURL URLWithString:((Annotation *)annotation).thumImage];
        NSData *data = [NSData dataWithContentsOfURL:url];
        annotationView.image = [[UIImage alloc] initWithData:data];
        
        //NSLog(@"%@",((Annotation *)annotation).title);
        */
/*
         return annotationView;

    }
    else
        return nil;
    
    
        
        //UIImageView *houseIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar.jpg"]];
        //annotationView.leftCalloutAccessoryView = houseIconView;
    

    
   
    
   
}*/
- (void) setPhotoForAnnotation:(Annotation *)annotation WithId:(NSString *)p_id
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=%@&photo_id=%@&format=json&nojsoncallback=1",key,p_id];
    //NSLog(@"%@",urlString);
    
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //NSLog(@"here");
    //Session object with no delegate
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                            delegate:nil
                                                       delegateQueue:[NSOperationQueue mainQueue]];
    
    //URL with the Pi website
    NSURL *myURL = [NSURL URLWithString:urlString];
    
    //Task with url and completionBlock
    NSURLSessionDataTask* task = [mySession dataTaskWithURL:myURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &error];
       // NSLog(@"%@",dic);
         NSArray *size = [[dic objectForKey:@"sizes"] objectForKey:@"size"];
        annotation.thumImage = [[size objectAtIndex:2] objectForKey:@"source"];
        annotation.bigImage = [[size lastObject] objectForKey:@"source"];
        annotation.width = [[size lastObject] objectForKey:@"width"];
        annotation.height = [[size lastObject] objectForKey:@"height"];
        
    
        
    }];
    
    //Must use resume to start the task
    [task resume];
    
    //If we set the delegate, the delegate is strongly references and is released using the below call
    [mySession finishTasksAndInvalidate];

}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *e = nil;
    self.jsonArray = [NSJSONSerialization JSONObjectWithData: self.myData options: NSJSONReadingMutableContainers error: &e];
    
    NSArray *photos = [[self.jsonArray objectForKey:@"photos"] objectForKey:@"photo"];
    //NSLog(@"%@",photos);
    //NSMutableArray *connectionArray = [[NSMutableArray alloc]init];
    self.requestsArray = [[NSMutableArray alloc]init];
    for (NSDictionary *photo in photos) {
        
        Annotation *ann = [self getPhotoWithId:[photo objectForKey:@"id"] andTitle:[photo objectForKey:@"title"]];
        if(ann != nil){
            [self setPhotoForAnnotation:ann WithId:[photo objectForKey:@"id"]];
            
        }
       
        
    }
 
}
- (void) handle:(NSData *)data
{
   
    NSError *e = nil;
     NSDictionary *tmp = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"hahah :%@",tmp);
}


- (void)focusOnMap
{
    MKCoordinateRegion region;
    CLLocationCoordinate2D center;
    center.latitude = [self.latitude floatValue];
    center.longitude = [self.longitude floatValue];
    MKCoordinateSpan span;
    span.latitudeDelta = 0.30f;
    span.longitudeDelta = 0.30f;
    region.center = center;
    region.span = span;
    [self.myMapView setRegion:region animated:YES];
}


@end
