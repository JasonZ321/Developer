//
//  ListViewController.m
//  Flickr
//
//  Created by Jason Zhou on 13-10-18.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()
@property (strong, nonatomic)NSMutableData * myData;
@property (strong, nonatomic)NSMutableArray *locations;


@property (strong, nonatomic)NSMutableArray *flickrs;
@end

@implementation ListViewController
static NSString *key = @"310f4953f25455596724be4f8e779d64";


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setDelegate:self];
    self.flickrs = [[NSMutableArray alloc]init];
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
    [self.myData appendData:data];
    
}
// create annotation using photo id
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
        
        
        NSString *tmp = [[NSString alloc]init];
        NSString *neighbourhood = [[loc objectForKey:@"neighbourhood"] objectForKey:@"_content"];
        NSString *locality = [[loc objectForKey:@"locality"] objectForKey:@"_content"];
        NSString *region = [[loc objectForKey:@"region"] objectForKey:@"_content"];
        NSString *country = [[loc objectForKey:@"country"] objectForKey:@"_content"];
        
        // if any of the address is null, set address to "unknown"
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

// set photo information for annotation
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
        NSLog(@"%@",dic);
        NSArray *size = [[dic objectForKey:@"sizes"] objectForKey:@"size"];
        // the url of image
        annotation.thumImage = [[size objectAtIndex:2] objectForKey:@"source"];
        annotation.bigImage = [[size lastObject] objectForKey:@"source"];
      
        
        // read thumb image's data
        annotation.thumImageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:annotation.thumImage]];
        
        
    }];
    
    [task resume];
    
    
    [mySession finishTasksAndInvalidate];
    
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *e = nil;
    NSDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData: self.myData options: NSJSONReadingMutableContainers error: &e];
    
    NSArray *photos = [[jsonArray objectForKey:@"photos"] objectForKey:@"photo"];
    
    for (NSDictionary *photo in photos) {
        
        Annotation *ann = [self getPhotoWithId:[photo objectForKey:@"id"] andTitle:[photo objectForKey:@"title"]];
        if(ann != nil){
            [self setPhotoForAnnotation:ann WithId:[photo objectForKey:@"id"]];
            [self.flickrs addObject:ann];
            
        }
    }
    
    
    [self.tableView reloadData];
    
    
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.flickrs count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Annotation *ann = [self.flickrs objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = ann.title;
    NSLog(@"%@",ann.title);
    
    
    // asynchrously adding thumb image to cell
    if(!ann.thumImageData)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:ann.thumImage]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIImage * img = [[UIImage alloc]initWithData:imageData];
                UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
                imgView.frame = CGRectMake(0, 0, 65, 65);
                [cell addSubview:imgView];
                
                [self.tableView beginUpdates];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [self.tableView endUpdates];
                
            });
        });
    }else{
        UIImage * img = [[UIImage alloc]initWithData:ann.thumImageData];
        UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
        imgView.frame = CGRectMake(0, 0, 65, 65);
        [cell addSubview:imgView];
    }
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Annotation *ann = [self.flickrs objectAtIndex:indexPath.row];
    
    AnnotationViewController *annVC = [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"annVC"];
    annVC.annotation = ann;
    [self.navigationController pushViewController:annVC animated:YES];
}

@end
