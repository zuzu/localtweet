//
//  TweetTimeline.h
//  TestTwitterClient
//
//  Created by Akabeko on 11/09/24.
//  Copyright 2011, Akabeko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Tweet;

/**
 * タイムラインを表します。
 */
@interface TweetTimeline : NSObject
{
@private
    NSString*       _userId; //! ユーザー識別子
    NSMutableArray* _tweets; //! つぶやきのコレクション
}

/** つぶやきの総数を取得します。 */
@property (nonatomic, readonly) NSInteger count;

- (Tweet*)tweetAtIndex:(NSInteger)index;
- (id)initWithUser:(NSString*)userId;
- (void)reload;

@end
