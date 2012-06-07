//
//  tableViewController.m
//  localTweet
//
//  Created by zuzu on 12/05/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "tableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "AFHTTPClient.h";
#import "AFJSONRequestOperation.h"
#import "Tweet.h"

@interface tableViewController ()
@end

@implementation tableViewController
@synthesize man;
@synthesize points;
@synthesize tableView;

static NSString *CellIdentifier = @"Cell";

UILabel *label;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    man = [[CLLocationManager alloc] init];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //端末でロケーションサービスが利用できる場合
    if([man locationServicesEnabled]){	
        //イベントを受け取るインスタンス
        man.delegate = self;    
        //イベントを発生させる最小の距離（デフォルトは距離指定なし）
        man.distanceFilter = 100.0;
        //精度 (デフォルトはBest)
        man.desiredAccuracy = kCLLocationAccuracyBest;
        //測位開始
        [man startUpdatingLocation];
    }
    
    self.points = [[NSMutableArray alloc] initWithObjects:nil];

}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.points count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {  
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //ラベルを作成
		label = [[UILabel alloc] initWithFrame:CGRectZero];
		label.backgroundColor = [UIColor clearColor];
		label.tag = 1;
		label.numberOfLines = 0;
		label.lineBreakMode = UILineBreakModeWordWrap;
		label.font = [UIFont systemFontOfSize:14.0];

        //名前用ラベルを作成
        
        //土台Viewを作成
        UIView *message = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, cell.frame.size.width, cell.frame.size.height)];
		message.tag = 0;
        //それぞれAddする
        [message addSubview:label];
        [cell.contentView addSubview:message];

    }else{
        label = (UILabel *)[[cell.contentView viewWithTag:0] viewWithTag:1];
    }
     NSLog(@"%d", [self.points count]);
    if ([self.points count] == 0) {
        return cell;
    }
    
    //self.points配列からTweetクラスのインスタンスを取得。
    Tweet *tweet = (Tweet *)[self.points objectAtIndex:indexPath.row];
    NSString *text = tweet.text;
    NSLog(text);
   
    //文章のサイズを取得
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0f, 480.0f) lineBreakMode:UILineBreakModeWordWrap];
    //ラベルのサイズを設定
    label.frame = CGRectMake(20, 11, size.width + 5, size.height);
    label.text = text;

    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = [self.points objectAtIndex:indexPath.row];
	NSString *body = tweet.text;
	CGSize size = [body sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(240.0, 480.0) lineBreakMode:UILineBreakModeWordWrap];
	return size.height +25;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
- (void) error{}
// GPS測位が成功した場合に呼ばれる
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{

    // 緯度経度取得
    CLLocationCoordinate2D coordinate = newLocation.coordinate;

    //URL作成
    
    NSURL *url = [NSURL URLWithString:
                    [NSString stringWithFormat:@"http://search.twitter.com/search.json?geocode=%f,%f,1km", 
                        coordinate.latitude, 
                        coordinate.longitude
                    ]
                  ];

    //AFHTTPを利用した通信処理。Blocksもといクロージャを利用して簡潔に記述
    //TweetAPIからの検索結果をJSONで受け取りTweetクラスの配列へ追加
    //追加した結果は[self.tableView reloadData]時に実行される、cellForRowAtIndexPathにて利用。
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            if ([JSON respondsToSelector:@selector(objectForKey:)]) {
                for (NSDictionary *tw in [JSON objectForKey:@"results"]) {
                    if ([tw objectForKey:@"geo"] != NULL) {
                        Tweet* tweet = [[Tweet alloc] initWithTweet: tw];
                        //tweet.text = [tw objectForKey:@"text"];
                        [self.points insertObject:tweet atIndex:0];
                        //NSLog(@"points: %@", [points objectAtIndex:0 ;
                    }
                }
            }
           //NSLog(@"Tweet: %@",self.points );
            [self.tableView reloadData];
        } failure:nil];
    [operation start];

    
/*    
    // 緯度経度取得
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    CLLocationDegrees latitude = coordinate.latitude;
    CLLocationDegrees longitude = coordinate.longitude;
    // 精度取得
    CLLocationAccuracy horizontal = newLocation.horizontalAccuracy;
    CLLocationAccuracy vertical = newLocation.verticalAccuracy;
    // 高度取得
    CLLocationDistance altitude = newLocation.altitude;
    // 時刻取得
    NSDate *timestamp = [newLocation timestamp];
    
    // 情報をまとめて出力 format: <latitude>, <longitude>> +/- <accuracy>m @ <date-time>
    NSLog([newLocation description]);
    [self.points addObject:[newLocation description]];
    
    // 前回地点からの距離
    if(oldLocation != nil){
        CLLocationDistance d = [newLocation getDistanceFrom:oldLocation];	
        NSLog([NSString stringWithFormat:@"%f", d]);	
    }
 
    [self.tableView reloadData];

*/
}
@end
