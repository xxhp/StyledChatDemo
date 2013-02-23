//
//  ViewController.h
//  StyledChatDemo
//
//  Created by xiaohaibo on 13-2-23.
//  Copyright (c) 2013年 xiaohaibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSArray *styleArray;

}
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UITextField *msgTextField;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITableView *settingTableView;
@property (strong, nonatomic) IBOutlet UIView *settingView;

@end
