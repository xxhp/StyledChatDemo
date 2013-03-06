//
//  CustomTextFiled.h
//  StyledChatDemo
//
//  Created by xiaohaibo on 13-3-1.
//  Copyright (c) 2013年 xiaohaibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextFiled : UITextField<UITextFieldDelegate>{

    NSMutableString *storedString;
}
@property(nonatomic,strong) NSMutableString *storedString;;

@end
