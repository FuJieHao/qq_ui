//
//  ViewController.m
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/20.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJBaseViewController.h"
#import "UIView_extra.h"
#import "FJSliderManager.h"

#define vSpeedFloat 0.7 //滑动速度
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height

#define kLeftCenterX -50    //左侧初始偏移量
#define kLeftAlpha 0.9  //左侧蒙版的最大值
#define kMainPageCenter  CGPointMake(kScreenWidth + kScreenWidth * 1.0 / 2.0 - kMainPageDistance, kScreenHeight / 2)  //打开左侧窗时，中视图中心点
#define vCouldChangeDeckStateDistance  (kScreenWidth - kMainPageDistance) / 2.0 - 40 //滑动距离大于此数时，状态改变（关--》开，或者开--》关）

#define kMainPageDistance   100   //打开左侧窗时，中视图(右视图)露出的宽度

@interface FJBaseViewController () <UITabBarControllerDelegate,UIGestureRecognizerDelegate>
{
    CGFloat _scalef;  //记录滑动速度
}

@property (nonatomic,strong) UITableView *leftTableView;
@property (nonatomic,weak) UIView *modeView;


@end

@implementation FJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //快要显示的时候，就不再隐藏侧边栏
    self.leftVC.view.hidden = NO;
}

//定义一个添加其两个子类控制器的方法
- (instancetype)initWithLeftViewController:(UIViewController *)leftVC andMainController:(UITabBarController *)mainVC
{
    if (self = [super init]) {
        
        self.speed = vSpeedFloat;
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        mainVC.delegate = self;
        [self addChildViewController:self.leftVC];
        [self addChildViewController:self.mainVC];
        
        [self setPanAndAdd];
        
        [self setModeView];
        
        [self getLeftTableView];
        
        //往单例中存入两个控制器
        [FJSliderManager sharedSliderInstance].leftSliderVC = self;
        [FJSliderManager sharedSliderInstance].mainNavigationController = mainVC.viewControllers.firstObject;
        
        [self setFirstObject];
    }
    return self;
}

//添加滑动手势
- (void)setPanAndAdd
{
    self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.mainVC.view addGestureRecognizer:self.pan];
    
    //可点击
    [self.pan setCancelsTouchesInView:YES];
    self.pan.delegate = self;
    self.leftVC.view.hidden = YES;
    [self.view addSubview:self.leftVC.view];
}

//蒙版的设置
- (void)setModeView
{
    UIView *mengBanView = [[UIView alloc]init];
    mengBanView.frame = self.leftVC.view.bounds;
    mengBanView.backgroundColor = [UIColor blackColor];
    mengBanView.alpha = 0.5;
    
    [self.leftVC.view addSubview:mengBanView];
    
    self.modeView = mengBanView;
}

//得到侧滑栏的tableView并设置
- (void)getLeftTableView
{
    for (UIView *tableView in self.leftVC.view.subviews) {
        if ([tableView isKindOfClass:[UITableView class]]) {
            self.leftTableView = (UITableView *)tableView;
        }
    }
    
    self.leftTableView.backgroundColor = [UIColor clearColor];
    self.leftTableView.frame = CGRectMake(kMainPageDistance - 30, (kScreenHeight - 200)/2, kScreenWidth - kMainPageDistance*1.5, 300);
    
    //缩放比例，暂时不设置
    
    [self.view addSubview:self.leftVC.view];
    [self.view addSubview:self.mainVC.view];
    self.isClosed = YES;
}

- (void)setFirstObject
{
    //获得第一个导航控制器的第一个controller
//    UINavigationController *navVC = (UINavigationController *)self.mainVC.viewControllers.firstObject;
    
    for (UINavigationController *navVc in self.mainVC.viewControllers) {
        UIViewController *firVC = navVc.viewControllers.firstObject;
        
        UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me"]];
        image.layer.cornerRadius = 34 * 0.5;
        image.layer.masksToBounds = YES;
        
        image.userInteractionEnabled = YES;
        
        image.frame = CGRectMake(0, 0, 34, 34);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openOrCloseLeftList)];
        [image addGestureRecognizer:tap];
        
        firVC.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:image];
    }

    //    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    menuBtn.frame = CGRectMake(0, 0, 20, 18);
//    [menuBtn setBackgroundImage:image.image forState:UIControlStateNormal];
//    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
//    firVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
//    UIButton *btn = [[UIButton alloc]init];
//    btn setImage:[UIImage imageNamed:] forState:<#(UIControlState)#>
    
}

- (void)openOrCloseLeftList
{
    if ([FJSliderManager sharedSliderInstance].leftSliderVC.isClosed) {
        [[FJSliderManager sharedSliderInstance].leftSliderVC openLeftViewController];
    } else {
        [[FJSliderManager sharedSliderInstance].leftSliderVC closeLeftViewController];
    }
}

//关闭和打开侧栏的方法
- (void)closeLeftViewController
{
    //通过块动画设置关闭的动画(两个子控制器都要改变）
    [UIView beginAnimations:nil context:nil];
    
    self.mainVC.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
    self.isClosed = YES;
    
    self.leftVC.view.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
    self.modeView.alpha = kLeftAlpha;
    
    [self removeSingleTap];
}

- (void)openLeftViewController
{
    [UIView beginAnimations:nil context:nil];
    
    self.mainVC.view.center = kMainPageCenter;
    self.isClosed = NO;
    
    
    self.leftVC.view.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5, kScreenHeight * 0.5);
    self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.modeView.alpha = 0;
    
    [UIView commitAnimations];
    [self disableTapButton];
}

//当侧滑栏打开的时候，关闭button的交互功能，就是我在弹出侧滑栏的时候，会有个过程，但是如果此时你点击了别的button，进行别的操作，就会出现混乱，所以要关闭无关的按钮
- (void)disableTapButton
{
    for (UIButton *tempButton in self.mainVC.view.subviews) {
        //关闭所有button的交互功能
        //        user events (touch, keys) are ignored and removed from the event queue.
        //        这句话的意思是用户的事件 将被 忽略 和 移除 从 事件 进程中
        [tempButton setUserInteractionEnabled:NO];
    }
    
    if (!self.sideslipTapGes) {
        //给手势添加方法
        self.sideslipTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handTap:)];
        [self.sideslipTapGes setNumberOfTapsRequired:1];
        
        //添加手势
        [self.mainVC.view addGestureRecognizer:self.sideslipTapGes];
        
        //因为你弹出的时候，侧护栏打开后，这时候再次点击后应该滚回去，但是又因为我这个效果不能盖住其他的按钮的事件，所以我在这上面把按钮的交互的功能关了
        self.sideslipTapGes.cancelsTouchesInView = YES;
    }
}

//这个是在关闭侧滑栏的时候调用的
- (void)removeSingleTap
{
    for (UIButton *tempButton in self.mainVC.view.subviews) {
        [tempButton setUserInteractionEnabled:YES];
    }
    
    [self.mainVC.view removeGestureRecognizer:self.sideslipTapGes];
    self.sideslipTapGes = nil;
}

//是否开启滑动手势的功能 手势pan
- (void)setPanEnabled:(BOOL)enabled
{
    [self.pan setEnabled:enabled];
}

#pragma mark - 手势设置
//滑动
- (void)handlePan:(UIPanGestureRecognizer *)rect
{
    //    translation in the coordinate system of the specified view 调节以适应指定的视图(获取当前滑动的点）。获取当前触摸在指定视图上的点【不是获取当前的点，1点和2点的点差】
    CGPoint point = [rect translationInView:self.view];
//    NSLog(@"当前位置%f",point.x);
    _scalef = (point.x * self.speed + _scalef);
//    NSLog(@"位移偏移%f",_scalef);
    BOOL needMoveWithTap = YES;  //是否还需要跟随手指移动
    
    //    _scalef横向位移的值
    //在没侧边栏并且横向位移小于0   或者   已经弹出侧边栏并且横向位移大于0 的时候界面不再跟随手指移动
    if (((self.mainVC.view.x <= 0) && (_scalef <= 0)) || ((self.mainVC.view.x >= (kScreenWidth - kMainPageDistance )) && (_scalef >= 0)))
    {
        //边界值管控
        _scalef = 0;
        needMoveWithTap = NO;
    }
    
    //根据视图位置判断是左滑还是右边滑动
    if (needMoveWithTap && (rect.view.frame.origin.x >= 0) && (rect.view.frame.origin.x <= (kScreenWidth - kMainPageDistance)))
    {
        CGFloat recCenterX = rect.view.center.x + point.x * self.speed;
        
        if (recCenterX < kScreenWidth * 0.5 - 2) {
            recCenterX = kScreenWidth * 0.5;
        }
        
        CGFloat recCenterY = rect.view.center.y;
        
        rect.view.center = CGPointMake(recCenterX,recCenterY);
        
        //scale 1.0~kMainPageScale
        CGFloat scale = 1 - (1 - 1.0) * (rect.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        rect.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,scale, scale);
        [rect setTranslation:CGPointMake(0, 0) inView:self.view];
        
        CGFloat leftTabCenterX = kLeftCenterX + ((kScreenWidth - kMainPageDistance) * 0.5 - kLeftCenterX) * (rect.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        
        CGFloat leftScale = 1.0 + (1 - 1.0) * (rect.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        
        self.leftVC.view.center = CGPointMake(leftTabCenterX, kScreenHeight * 0.5);
        self.leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, leftScale,leftScale);
        
        CGFloat tempAlpha = kLeftAlpha - kLeftAlpha * (rect.view.frame.origin.x / (kScreenWidth - kMainPageDistance));
        self.modeView.alpha = tempAlpha;
        
    }
    else
    {
        //超出范围，
        if (self.mainVC.view.x < 0)
        {
            [self closeLeftViewController];
            _scalef = 0;
        }
        else if (self.mainVC.view.x > (kScreenWidth - kMainPageDistance))
        {
            [self openLeftViewController];
            _scalef = 0;
        }
    }
    
    //手势结束后修正位置,超过约一半时向多出的一半偏移
    if (rect.state == UIGestureRecognizerStateEnded) {
        if (fabs(_scalef) > vCouldChangeDeckStateDistance)
        {
            if (self.isClosed)
            {
                [self openLeftViewController];
            }
            else
            {
                [self closeLeftViewController];
            }
        }
        else
        {
            if (self.isClosed)
            {
                [self closeLeftViewController];
            }
            else
            {
                [self openLeftViewController];
            }
        }
        _scalef = 0;
    }
    
}
//单击
- (void)handTap:(UITapGestureRecognizer *)tap
{
    //当侧滑栏不是关闭并且单击手势是处于这个状态（一旦触动了这个手势，就不能操作，变为UIGestureRecognizerStatePossible状态）（也就是一次性的意思）
    if (!self.isClosed && tap.state == UIGestureRecognizerStateEnded) {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        //给单击手势赋值可执行手势的区域
        tap.view.center = CGPointMake(kScreenWidth / 2, kScreenHeight / 2);
        //关闭侧滑栏
        self.isClosed = YES;
        //改变侧滑栏的位置以及透明度
        self.leftVC.view.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        
        self.modeView.alpha = kLeftAlpha;
        
        [UIView commitAnimations];
        _scalef = 0;
        
        [self removeSingleTap];
    }
}

//这个东西经测试暂时还没有发现有什么用处
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//
//}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [FJSliderManager sharedSliderInstance].mainNavigationController = (UINavigationController *)viewController;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end