//
//  TweetTimeline.m
//  TestTwitterClient
//
//  Created by Akabeko on 11/09/24.
//  Copyright 2011, Akabeko. All rights reserved.
//

#import "TweetTimeline.h"
#import "Tweet.h"

@implementation TweetTimeline

@synthesize count;

/**
 * インスタンスを初期化します。
 *
 * @return 初期化後のインスタンス。
 */
- (id)init
{
    self = [super init];
    if( self )
    {
    }
    
    return self;
}

/**
 * インスタンスを初期化します。
 *
 * @param userId ユーザー識別子。
 *
 * @return 初期化後のインスタンス。
 */
-(id)initWithUser:(NSString *)userId
{
    self = [self init];
    if( self )
    {
        [_userId release];
        _userId = [userId copy];        
        
        [self reload];
    }
    
    return self;
}

/**
 * メモリを解放します。
 */
- (void)dealloc
{
    [_userId release];
    [_tweets release];
    
    [super dealloc];
}

/**
 * つぶやきを取得します。
 *
 * @param index つぶやきのインデックス。
 *
 * @return つぶやき。範囲外のインデックスが指定された場合は nil。
 */
- (Tweet *)tweetAtIndex:(NSInteger)index
{
    return [_tweets objectAtIndex:index];
}

/**
 * タイムラインを読み込みます。
 */
- (void)reload
{
    [_tweets release];
    _tweets = [[NSMutableArray alloc] init];
    
    NSString* str  = [NSString stringWithFormat:@"http://twitter.com/statuses/user_timeline/%@.json", _userId];
    NSURL*    url  = [NSURL URLWithString:str];
    NSString* json = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSArray*  data = [json JSONValue];
    
    for( NSDictionary* dic in data )
    {
        Tweet* tweet = [[Tweet alloc] initWithTweet:dic];
        [_tweets addObject:tweet];
        [tweet release];
    }
}

#pragma mark - Property methods

/**
 * つぶやきの総数を取得します。
 */
- (NSInteger)count
{
    return [_tweets count];
}

@end
