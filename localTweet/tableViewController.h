//
//  tableViewController.h
//  localTweet
//
//  Created by zuzu on 12/05/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface tableViewController : UITableViewController <CLLocationManagerDelegate>{
    CLLocationManager *man;
    NSMutableArray *points;
}
@property(nonatomic, retain)   CLLocationManager *man;
@property (nonatomic, retain) NSMutableArray *points;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
