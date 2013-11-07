//
//  MapViewController.m
//  Flickr
//
//  Created by Jason Zhou on 13-10-18.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "MapViewController.h"

#import "AnnotationViewController.h"

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic)NSDictionary *jsonArray;
@property (strong, nonatomic)NSMutableData * myData;
@property (strong, nonatomic)NSMutableArray *locations;
//@property (strong, nonatomic)NSMutableArray *connnections;

@end

@implementation MapViewController
static NSString *key = @"310f4953f25455596724be4f8e779d64";

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self focusOnMap];
    [self.myMapView setDelegate:self];
   
    self.locations = [[NSMutableArray alloc]init];
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&place_id=%@&has_geo=1&format=json&nojsoncallback=1",key,self.tags,self.placeId];
    NSLog(@"%@",urlString);
       NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
											 cachePolicy:NSURLRequestUseProtocolCachePolicy
										 timeoutInterval:60.0];
    
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    [self.connection start];
 
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

    
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
   
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                            delegate:nil
                                                       delegateQueue:[NSOperationQueue mainQueue]];

    NSURL *myURL = [NSURL URLWithString:urlString];

    NSURLSessionDataTask* task = [mySession dataTaskWithURL:myURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &error];
        CLLocationCoordinate2D location;
        NSDictionary *loc = [[dic objectForKey:@"photo"] objectForKey:@"location"];
        location.latitude = [[loc objectForKey:@"latitude"] doubleValue];
        location.longitude = [[loc objectForKey:@"longitude"] doubleValue];
        
        ann.coordinate = location;
        ann.title = title;
        [self.myMapView addAnnotation:ann];
        
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
        

        
    }];
    
    [task resume];
    

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


- (void) setPhotoForAnnotation:(Annotation *)annotation WithId:(NSString *)p_id
{
    NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.getSizes&api_key=%@&photo_id=%@&format=json&nojsoncallback=1",key,p_id];
    
    
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                            delegate:nil
                                                       delegateQueue:[NSOperationQueue mainQueue]];
    
    
    NSURL *myURL = [NSURL URLWithString:urlString];
    
    
    NSURLSessionDataTask* task = [mySession dataTaskWithURL:myURL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &error];
        NSArray *size = [[dic objectForKey:@"sizes"] objectForKey:@"size"];
        annotation.thumImage = [[size objectAtIndex:2] objectForKey:@"source"];
        annotation.bigImage = [[size lastObject] objectForKey:@"source"];
      
        
        
        
    }];

    [task resume];
    
   
    [mySession finishTasksAndInvalidate];
    
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *e = nil;
    self.jsonArray = [NSJSONSerialization JSONObjectWithData: self.myData options: NSJSONReadingMutableContainers error: &e];
    
    NSArray *photos = [[self.jsonArray objectForKey:@"photos"] objectForKey:@"photo"];
    
    for (NSDictionary *photo in photos) {
        
        Annotation *ann = [self getPhotoWithId:[photo objectForKey:@"id"] andTitle:[photo objectForKey:@"title"]];
        if(ann != nil){
            [self setPhotoForAnnotation:ann WithId:[photo objectForKey:@"id"]];
            
        }
        
        
    }
    
}


// focus to the location on map
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
