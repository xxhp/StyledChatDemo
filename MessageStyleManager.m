//
//  MessageStyleManager.m
//  StyledChatDemo
//
//  Created by xiao haibo on 13-2-23.
//  Copyright (c) 2013年 xiao haibo. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//


#import "MessageStyleManager.h"

#define APPEND_MESSAGE					@"appendMessage(\"%@\");"


static MessageStyleManager* sharedInstance = nil;

@implementation MessageStyleManager
@synthesize baseHTML,baseURL;
-(void)loadTemplate{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"Template" ofType:@"html"];
     
    NSString *htm = [NSString stringWithContentsOfFile:path2 encoding:NSUTF8StringEncoding error:nil];
    baseURL = [NSURL fileURLWithPath:path];
    baseHTML = [NSString stringWithFormat:htm,						//Template
                [[NSBundle mainBundle] bundlePath],					//Base path
                @"@import url( \"Renkoo/Styles/main.css\" );",		//Import main.css for new enough styles
                @"Renkoo/Variants/Green on Red Alternating.css",	//Variant path
                @"",
                (@"")];
    NSString * contentOutHTMLpath =  [[NSBundle mainBundle] pathForResource:@"Content" ofType:@"html" inDirectory:@"Renkoo/Outgoing"];
    contentOutHTML =  [NSString stringWithContentsOfFile:contentOutHTMLpath encoding:NSUTF8StringEncoding error:nil];
    NSString * contentInHTMLpath =  [[NSBundle mainBundle] pathForResource:@"Content" ofType:@"html" inDirectory:@"Renkoo/Incoming"];
    contentInHTML =  [NSString stringWithContentsOfFile:contentInHTMLpath encoding:NSUTF8StringEncoding error:nil];
}
- (NSString *)pathForVariant:(NSString *)variant
{
	 return [NSString stringWithFormat:@"Renkoo/Variants/%@.css",variant];
	 
}
- (NSString *)scriptForChangingVariant:(NSString *)variant
{
	return [NSString stringWithFormat:@"setStylesheet(\"mainStyle\",\"%@\");",[self pathForVariant:variant]];
}
- (NSArray *)availableVariants
{
	NSMutableArray	*availableVariants = [NSMutableArray array];
	for (NSString *path in [[NSBundle mainBundle] pathsForResourcesOfType:@"css" inDirectory:@"Renkoo/Variants"]) {
		[availableVariants addObject:[[path lastPathComponent] stringByDeletingPathExtension]];
	}
	//Alphabetize the variants
	[availableVariants sortUsingSelector:@selector(localizedStandardCompare:)];
	
	return availableVariants;
}

- (NSString *)_escapeStringForPassingToScript:(NSString *)inString
{
	inString =[inString stringByReplacingOccurrencesOfString:@"\\"
                                                  withString:@"\\\\"];
    
	inString= [inString stringByReplacingOccurrencesOfString:@"\""
                                                  withString:@"\\\""
               ];
    
	inString =[inString stringByReplacingOccurrencesOfString:@"\n"
                                                  withString:@""
               ];
    
	inString = [inString stringByReplacingOccurrencesOfString:@"\r"
                                                   withString:@"<br>"
                ];
    
	return inString;
}

-(NSString *)appendScriptForMessage:(Message *)msg{
  
    NSString * newHTML= nil;
    if (!msg.isOut) {
        newHTML = [contentInHTML copy];
        newHTML = [newHTML stringByReplacingOccurrencesOfString:@"%messageClasses%" withString:@"incoming message"];
        newHTML = [newHTML stringByReplacingOccurrencesOfString:@"%userIconPath%" withString:@"Renkoo/incoming_icon.png"];
    }else{
        newHTML = [contentOutHTML copy];
        newHTML = [newHTML stringByReplacingOccurrencesOfString:@"%messageClasses%" withString:@"outgoing message"];
        newHTML = [newHTML stringByReplacingOccurrencesOfString:@"%userIconPath%" withString:@"Renkoo/outgoing_icon.png"];
    }

    newHTML = [newHTML stringByReplacingOccurrencesOfString:@"%sender%" withString:msg.sender];
    newHTML = [newHTML stringByReplacingOccurrencesOfString:@"%time%" withString:msg.timeStamp];
    newHTML = [newHTML stringByReplacingOccurrencesOfString:@"%message%" withString:msg.content];
    
    return [NSString stringWithFormat:APPEND_MESSAGE, [self _escapeStringForPassingToScript:newHTML]];
    
}
+ (MessageStyleManager*)sharedInstance {
    if (!sharedInstance)
    {
        sharedInstance = [[MessageStyleManager alloc] init];
    }
    return sharedInstance;
}
@end
