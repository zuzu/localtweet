//
//  Tweet.m
//  TestTwitterClient
//
//  Created by Akabeko on 11/09/24.
//  Copyright 2011, Akabeko. All rights reserved.
//

#import "Tweet.h"

@interface Tweet()
- (NSString*)convertCreated:(NSString*)date;
@end

@implementation Tweet

@synthesize name    = _name;
@synthesize text    = _text;
@synthesize icon    = _icon;
@synthesize created = _created;

/**
 * インスタンスを初期化します。
 *
 * @return 初期化後のインスタンス。
 */
- (id)init
{
    self = [super init];
    if( self ) { }
    
    return self;
}

/**
 * インスタンスを初期化します。
 *
 * @param tweet つぶやき情報を表すディクショナリ。
 *
 * @return 初期化後のインスタンス。
 */
-(id)initWithTweet:(NSDictionary *)tweet
{
    self = [self init];
    if( self && tweet )
    {
        NSDictionary* user = [tweet objectForKey:@"user"];

        NSString* url = [user objectForKey:@"profile_image_url"];
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        _name    = [[user objectForKey:@"screen_name"] copy];
        _text    = [[tweet objectForKey:@"text"] copy];
        _icon    = [[UIImage alloc] initWithData:data];
        _created = [[self convertCreated:[tweet objectForKey:@"created_at"]] copy];
    }
    
    return self;
}

/**
 * メモリを解放します。
 */
- (void)dealloc
{
    [_name    release];
    [_text    release];
    [_icon    release];
    [_created release];
    
    [super dealloc];
}

#pragma mark Private methods

/**
 * Twitter から返されたつぶやきの作成日時テキストを読みやすい形に変換します。
 *
 * @param created つぶやきの作成日時
 *
 * @return テキスト。
 */
- (NSString*)convertCreated:(NSString*)created
{
    NSDateFormatter* format = [[NSDateFormatter alloc] init];

    [format setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSDate* date = [format dateFromString:created];
    [format release]; 
    
    format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    
    NSString* text = [format stringFromDate:date];
    [format release];
    
    return text;
}

@end
