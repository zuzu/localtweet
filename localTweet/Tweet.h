//
//  Tweet.h
//  TestTwitterClient
//
//  Created by Akabeko on 11/09/24.
//  Copyright 2011, Akabeko. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * タイムライン上のつぶやきを表します。
 */
@interface Tweet : NSObject
{
@private
    NSString* _name;    //! ユーザー名
    NSString* _text;    //! つぶやきの内容
    UIImage*  _icon;    //! アイコン画像
    NSString* _created; //! つぶやかれた日時
}

/** ユーザー名を取得します。 */
@property (nonatomic, readonly) NSString* name;

/** つぶやきの内容を取得します。 */
@property (nonatomic, readonly) NSString* text;

/** アイコン画像を取得します。 */
@property (nonatomic, readonly) UIImage* icon;

/** つぶやかれた日時を取得します。 */
@property (nonatomic, readonly) NSString* created;

- (id)initWithTweet:(NSDictionary*)tweet;

@end
