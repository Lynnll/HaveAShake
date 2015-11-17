//
//  ViewController.m
//  HaveAShake
//
//  Created by lynnjinglei on 15/9/11.
//  Copyright (c) 2015年 XiaoLei. All rights reserved.
//

#import "ViewController.h"
#import "LZAudioTool.h"

@interface ViewController ()
{
    UIView *circleBgView;
    
    UIImageView *shakeImageView;
    
    UILabel *tipLabel;
}

@end

@implementation ViewController
- (id)init
{
    if(self == [super init])
    {
        
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Have a shake";
    
    [self loadDetailView];
}
- (void)loadDetailView
{
    circleBgView = [[UIView alloc]init];
    circleBgView.frame = CGRectMake(70, 100, self.view.frame.size.width - 140, self.view.frame.size.width - 140);
    circleBgView.backgroundColor = [UIColor colorWithRed:204 / 255.0f green:204 / 255.0f blue:204 / 255.0f alpha:1];
    circleBgView.layer.masksToBounds = YES;
    circleBgView.layer.cornerRadius = (self.view.frame.size.width - 140) / 2;
    circleBgView.layer.borderWidth = 2;
    circleBgView.layer.borderColor = [UIColor colorWithRed:225 / 255.0f green:225 / 255.0f blue:225 / 255.0f alpha:1].CGColor;
    [self.view addSubview:circleBgView];
    
    shakeImageView = [[UIImageView alloc]init];
    shakeImageView.frame = CGRectMake(0, 0, circleBgView.frame.size.width, circleBgView.frame.size.height);
    shakeImageView.image = [UIImage imageNamed:@"performance_shake.png"];
    shakeImageView.layer.masksToBounds = YES;
    shakeImageView.layer.cornerRadius = (self.view.frame.size.width - 140) / 2;
    [circleBgView addSubview:shakeImageView];
    
    tipLabel = [[UILabel alloc]init];
    tipLabel.frame = CGRectMake(0, circleBgView.frame.origin.y + circleBgView.frame.size.height + 15, self.view.frame.size.width, 20);
    tipLabel.font = [UIFont systemFontOfSize:18];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.text = @"Hold the phone,let's shake!";
    tipLabel.textColor = [UIColor colorWithRed:255 / 255.0f green:153 / 255.0f blue:0 / 255.0f alpha:1];
    [self.view addSubview:tipLabel];
}
- (void)resetColor
{
    circleBgView.backgroundColor = [UIColor colorWithRed:204 / 255.0f green:204 / 255.0f blue:204 / 255.0f alpha:1];
}
/**
 *   If a responder object returns YES from this method, it becomes the first responder and can receive touch events and action messages. Subclasses must override this method to be able to become first responder.
 *
 *  @return Returns NO by default
 */
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [LZAudioTool playMusic:@"shake.mp3"];
        [self shakeAnimation];
        NSLog(@"motionBegan ~~~");
    }
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(motion != UIEventSubtypeMotionShake) return;
    NSLog(@"motionEnded ~~~");
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    NSLog(@"motionCancelled ~~~");
}
- (void)shakeAnimation
{
    [self performSelector:@selector(resetColor) withObject:nil afterDelay:2.5];

    [UIView beginAnimations:nil context:nil];
    [UIView    setAnimationCurve: UIViewAnimationCurveLinear];
    [UIView    setAnimationDelegate:self];
    [UIView    setAnimationDuration:0.2];
    circleBgView.backgroundColor = [UIColor colorWithRed:255 / 255.0f green:153 / 255.0f blue:0 / 255.0f alpha:1];
    [UIView commitAnimations];
    
    
//    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
//    
//    //1.315
//    keyAnimation.values = @[@(0.0),@(0.0),@(1.315),@(-1.315),@(0.789),@(-0.789),@(0.526),@(-0.526),@(0.263),@(-0.263),@(0.123),@(-0.123),@(0.053),@(-0.053),@(0.0),@(0.0)];
//    keyAnimation.keyTimes = @[@(0.0),@(0.096),@(0.132),@(0.204),@(0.276),@(0.348),@(0.420),@(0.492),@(0.564),@(0.636),@(0.708),@(0.780),@(0.852),@(0.924),@(0.996),@(1.0)];
//    
//    keyAnimation.duration = 10;
//    keyAnimation.calculationMode = kCAAnimationLinear;
//    
//    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    basicAnimation.duration = 10;
//    basicAnimation.fromValue = [NSNumber numberWithInt:1];
//    basicAnimation.toValue = [NSNumber numberWithInt:0];
//    
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    group.animations = [NSArray arrayWithObjects:keyAnimation,nil];
//    group.duration = 10;//2.075
//    group.fillMode = kCAFillModeForwards;
//    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    [shakeImageView.layer addAnimation:group forKey:@"group"];

    CAKeyframeAnimation *keyAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CATransform3D rotation0 = CATransform3DMakeRotation(0 * M_PI/180, 0, 0, -1);
    CATransform3D rotation1 = CATransform3DMakeRotation(0 * M_PI/180, 0, 0, -1);
    CATransform3D rotation2 = CATransform3DMakeRotation(-75 * M_PI/180, 0, 0, -1);
    CATransform3D rotation3 = CATransform3DMakeRotation(75 * M_PI/180, 0, 0, -1);
    CATransform3D rotation4 = CATransform3DMakeRotation(-45 * M_PI/180, 0, 0, -1);
    CATransform3D rotation5 = CATransform3DMakeRotation(45 * M_PI/180, 0, 0, -1);
    CATransform3D rotation6 = CATransform3DMakeRotation(-30 * M_PI/180, 0, 0, -1);
    CATransform3D rotation7 = CATransform3DMakeRotation(30 * M_PI/180, 0, 0, -1);
    CATransform3D rotation8 = CATransform3DMakeRotation(-20 * M_PI/180, 0, 0, -1);
    CATransform3D rotation9 = CATransform3DMakeRotation(20 * M_PI/180, 0, 0, -1);
    CATransform3D rotation10 = CATransform3DMakeRotation(-10 * M_PI/180, 0, 0, -1);
    CATransform3D rotation11 = CATransform3DMakeRotation(10 * M_PI/180, 0, 0, -1);
    CATransform3D rotation12 = CATransform3DMakeRotation(0 * M_PI/180, 0, 0, -1);
    CATransform3D rotation13 = CATransform3DMakeRotation(0 * M_PI/180, 0, 0, -1);
    
   
    [keyAnim setValues:[NSArray arrayWithObjects:
                        [NSValue valueWithCATransform3D:rotation0],
                        [NSValue valueWithCATransform3D:rotation1],
                        [NSValue valueWithCATransform3D:rotation2],
                        [NSValue valueWithCATransform3D:rotation3],
                        [NSValue valueWithCATransform3D:rotation4],
                        [NSValue valueWithCATransform3D:rotation5],
                        [NSValue valueWithCATransform3D:rotation6],
                        [NSValue valueWithCATransform3D:rotation7],
                        [NSValue valueWithCATransform3D:rotation8],
                        [NSValue valueWithCATransform3D:rotation9],
                        [NSValue valueWithCATransform3D:rotation10],
                        [NSValue valueWithCATransform3D:rotation11],
                        [NSValue valueWithCATransform3D:rotation12],
                        [NSValue valueWithCATransform3D:rotation13],
                        nil]];
    [keyAnim setKeyTimes:[NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0f],
                          [NSNumber numberWithFloat:0.1039f],
                          [NSNumber numberWithFloat:0.1396f],
                          [NSNumber numberWithFloat:0.2110f],
                          [NSNumber numberWithFloat:0.2824f],
                          [NSNumber numberWithFloat:0.3538f],
                          [NSNumber numberWithFloat:0.4252f],
                          [NSNumber numberWithFloat:0.4966f],
                          [NSNumber numberWithFloat:0.5680f],
                          [NSNumber numberWithFloat:0.6394f],
                          [NSNumber numberWithFloat:0.7108f],
                          [NSNumber numberWithFloat:0.7822f],
                          [NSNumber numberWithFloat:0.8536f],
                          [NSNumber numberWithFloat:1.0f],
                          nil]];
    [keyAnim setDuration:1.925f];
    [keyAnim setFillMode:kCAFillModeForwards];
    [keyAnim setRemovedOnCompletion:NO];
    [shakeImageView.layer addAnimation:keyAnim forKey:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
