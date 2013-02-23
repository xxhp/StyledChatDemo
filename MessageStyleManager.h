//
//  MessageStyleManager.h
//  StyledChatDemo
//
//  Created by xiaohaibo on 13-2-23.
//  Copyright (c) 2013年 xiaohaibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Message.h"
@interface MessageStyleManager : NSObject{
    NSURL		*baseURL;
	NSString	*headerHTML;
	NSString	*footerHTML;
	NSString	*baseHTML;
	NSString	*contentHTML;
	NSString	*contentInHTML;
	NSString	*nextContentInHTML;
	NSString	*contextInHTML;
	NSString	*nextContextInHTML;
	NSString	*contentOutHTML;
	NSString	*nextContentOutHTML;
	NSString	*contextOutHTML;
	NSString	*nextContextOutHTML;
	NSString	*statusHTML;
	NSString	*fileTransferHTML;
	NSString	*topicHTML;

}
@property(nonatomic,strong)NSURL *baseURL;
@property(nonatomic,strong)NSString	*baseHTML;
+ (MessageStyleManager*)sharedInstance;
- (void)loadTemplate;
- (NSString *)appendScriptForMessage:(Message *)content;
- (NSString *)scriptForChangingVariant:(NSString *)variant;
- (NSArray *)availableVariants;

@end
