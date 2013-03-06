//
//  EmotionPicker.m
//  StyledChatDemo
//
//  Created by xiao haibo on 13-3-6.
//  Copyright (c) 2013年 xiaohaibo. All rights reserved.
//

#import "EmotionPicker.h"
static NSDictionary *dic = nil;
@implementation EmotionPicker
@synthesize delegate;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Initialization code
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"plist"];
    dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    dataSource = [[NSArray alloc] initWithArray:[dic allKeys]];
    tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, [UIScreen mainScreen].bounds.size.height - 44-20)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                   style:UIBarButtonItemStylePlain target:self action:@selector(cancel:)];
   
    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@"Emiotns"];
    
    [bar pushNavigationItem:title animated:YES];
    
    title.leftBarButtonItem = leftButton;
    [bar setItems:[NSArray arrayWithObject:title]];

    
    [self.view addSubview:bar];
    
}
-(void)cancel:(id)sender{
    [delegate emotionPickerCancelled];
}
#pragma mark - UITableView dataSource & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [dataSource count];
}
// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.imageView.image =[UIImage imageNamed:[dic valueForKey:[dataSource objectAtIndex:indexPath.row]]];
    cell.textLabel.text = [dataSource objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *selected = [dataSource objectAtIndex:indexPath.row];
    [delegate emotionPicker:self didSelectedEmotion:selected];
}



@end
