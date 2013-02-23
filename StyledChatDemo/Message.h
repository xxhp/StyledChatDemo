//
//  Message.h
//  StyledChatDemo
//
//  Created by xiaohaibo on 13-2-23.
//  Copyright (c) 2013年 xiaohaibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject{
    NSString *content;
    NSString *timeStamp;
    NSString *sender;
    BOOL isOut;
}
@property(nonatomic,assign)BOOL isOut;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString	*sender;
@property(nonatomic,strong)NSString	*timeStamp;
@end
