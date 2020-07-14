//
//  FJChatTableController.m
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/26.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJChatTableController.h"
#import "FJChatModel.h"
#import "FJMessageModel.h"
#import "Masonry.h"
#import "FJChatOtherTableViewCell.h"
#import "FJChatMeTableViewCell.h"

#define Me_ID @"我"
#define Other_ID  @"你"

@interface FJChatTableController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,weak) UITextField *textFiled;

@property (nonatomic,copy) NSString *lastTime;

@property (nonatomic,copy) NSString *lastText;

/**
 *  将沙盒中的数据再次遍历存储（不知道原因，因为不这样做数据不准）
 */
@property (nonatomic,strong) NSMutableArray *models;

//保存聊天记录
@property (nonatomic,strong) NSMutableArray *chats;
//将每条聊天数据转换成模型
@property (nonatomic,strong) FJChatModel *chatModel;
//聊天记录的存储路径
@property (nonatomic,copy) NSString *chatPath;

@end

@implementation FJChatTableController

- (void)back
{
    if ([self.delegate respondsToSelector:@selector(ChatTableController:andLastText:)]) {
        
        if (self.lastText != nil && self.lastTime != nil) {
            self.model.subTitle = self.lastText;
            self.model.time = self.lastTime;
        }
        
        [self.delegate ChatTableController:self andLastText:self.model];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendMessageWithText:textField.text messageType:@"me"];
    
    NSString *replyText = [self replyWithText:textField.text];
    self.lastText = replyText;
    [self sendMessageWithText:replyText messageType:@"other"];
    
    textField.text = nil;
    
    return YES;
}

- (void)sendMessageWithText:(NSString *)text messageType:(NSString *)identifier
{
    FJChatModel *chatModel = [[FJChatModel alloc]init];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"HH:mm";
    NSString *time = [dateFormatter stringFromDate:date];
//    self.lastTime = time;
    chatModel.text = text;
    chatModel.time = time;
    chatModel.identifier = identifier;
    
    if ([self.lastTime isEqualToString:chatModel.time]) {
        chatModel.time = @"";
    } else {
        self.lastTime = chatModel.time;
        
    }
    
    [self.models addObject:chatModel];
    [self.chats addObject:chatModel];
    
    //同步数据
    [NSKeyedArchiver archiveRootObject:self.chats toFile:self.chatPath];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.chats.count - 1) inSection:0];
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

/*********我想在这里做“智能”回复**************/

- (NSString *)replyWithText:(NSString *)text
{
    return @"傻×";
}

/*********我想在这里做“智能”回复**************/

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.chats.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FJChatModel *model = self.models[indexPath.row];

    if ([model.identifier isEqualToString:@"me"]) {
        FJChatMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Me_ID forIndexPath:indexPath];
        
        cell.model = model;
        return cell;
        
    } else {
        FJChatOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Other_ID forIndexPath:indexPath];
        cell.otherIconName = self.model.icon;
        cell.model = model;
        
        return cell;
    }
}

- (NSString *)chatPath
{
    if (!_chatPath) {
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSString *nameStr = self.model.name;
        
        NSString *pathStr = [nameStr stringByAppendingString:@".data"];
        
        _chatPath = [doc stringByAppendingPathComponent:pathStr];
        
    }
    return _chatPath;
}

- (NSMutableArray *)chats
{
    if (!_chats) {
        //先从沙盒获取数据
        _chats = [NSKeyedUnarchiver unarchiveObjectWithFile:self.chatPath];
        
        if (!_chats) {
            _chats = [NSMutableArray array];
        }
    }
    return _chats;
}

- (NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
        
        for (FJChatModel *model in self.chats) {
            [_models addObject:model];
        }
        
        if (_models.count != 0) {
            self.lastText = ((FJChatModel *)(_models[_models.count - 1])).text;
            for (NSInteger i = _models.count - 1; i >= 0; i--) {
                
                if (![((FJChatModel *)(_models[i])).time isEqualToString:@""] && ((FJChatModel *)(_models[i])).time != nil) {
                    self.lastTime = ((FJChatModel *)(_models[i])).time;
                    continue;
                }
            }
        }
    }
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 44, 0));
    }];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    self.tableView = tableView;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    
    [self.tableView registerClass:[FJChatOtherTableViewCell class] forCellReuseIdentifier:Other_ID];
    [self.tableView registerClass:[FJChatMeTableViewCell class] forCellReuseIdentifier:Me_ID];
    
    //预估行高
    self.tableView.estimatedRowHeight = 200;
    //自动计算行高
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupKeyboard];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)setupKeyboard
{
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *barView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.view addSubview:barView];
    
    UITextField *text = [[UITextField alloc] init];
    text.borderStyle = UITextBorderStyleRoundedRect;
    [barView.contentView addSubview:text];
    text.delegate = self;
    text.returnKeyType = UIReturnKeySend;
    text.enablesReturnKeyAutomatically = YES;
    
    _textFiled = text;
    
    UIButton *send = [UIButton buttonWithType:UIButtonTypeSystem];
    [send setTitle:@"发送" forState:UIControlStateNormal];
    
    [send addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [barView.contentView addSubview:send];
    
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(barView.contentView);
        make.left.offset(8);
    }];
    [send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(text.mas_right).offset(8);
        make.centerY.equalTo(barView.contentView);
        make.right.offset(-8);
    }];
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.offset(44);
    }];
    
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)sendBtnClick {
    [self textFieldShouldReturn:self.textFiled];
}
- (void)keyboardWillChangeFrame:(NSNotification *)note {
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat transformY = keyboardFrame.origin.y - self.view.bounds.size.height - 64;
    self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
