//
//  settingViewController.m
//  mount
//
//  Created by 江山 on 1/3/15.
//  Copyright (c) 2015 jiangshan. All rights reserved.
//

#import "settingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIGlossyButton.h"
#import "UIView+LayerEffects.h"
#import "settingManagement.h"
#import "enterTheCategoryViewController.h"
@interface settingViewController ()
@property(nonatomic,strong)settingManagement*settingM;
@end

@implementation settingViewController
@synthesize settingM;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"setting.png"]];
    settingM=[[settingManagement alloc]init];
    //-----------------------返回-------------------
    self.navigationItem.hidesBackButton=YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"  style:UIBarButtonItemStylePlain target:self action:@selector(backBtnAction)];//UIBarButtonItem
    //-----------------------返回-------------------

//-----------------------自定义button-------------------
    UIGlossyButton *b;
	b = (UIGlossyButton*) [self.view viewWithTag: 1001];
	[b setActionSheetButtonWithColor: [UIColor redColor]];

//    b = (UIGlossyButton*) [self.view viewWithTag: 1003];
//	[b useWhiteLabel: YES]; b.tintColor = [UIColor clearColor];
//	[b setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
//
//    b = (UIGlossyButton*) [self.view viewWithTag: 1004];
//	[b useWhiteLabel: YES]; b.tintColor = [UIColor clearColor];
//	[b setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
    
//    b = (UIGlossyButton*) [self.view viewWithTag: 1005];
//	[b useWhiteLabel: YES]; b.tintColor = [UIColor clearColor];
//	[b setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
    
//    b = (UIGlossyButton*) [self.view viewWithTag: 1002];
//	[b useWhiteLabel: YES]; b.tintColor = [UIColor darkGrayColor];
//	[b setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
//    b.invertGraidentOnSelected = YES;
//-----------------------自定义button-------------------
    
    UISwipeGestureRecognizer *recognizer; 
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    [[self view] addGestureRecognizer:recognizer];
	// Do any additional setup after loading the view.
}

-(void)backBtnAction{
    CATransition*transition=[CATransition animation];
    transition.duration=0.5;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type=kCATransitionPush;
    transition.subtype=kCATransitionFromRight;//方向
    
    [self.navigationController.view setBackgroundColor:[UIColor whiteColor]];//
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
     
    [self.navigationController popViewControllerAnimated:NO];
    [self.navigationController.view removeFromSuperview];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        CATransition*transition=[CATransition animation];
        transition.duration=0.3;
        transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type=kCATransitionPush;
        transition.subtype=kCATransitionFromRight;//方向
        
        [self.navigationController.view setBackgroundColor:[UIColor colorWithRed:0.0 green:156.0/255 blue:181.0/255 alpha:1]];
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        
        [self.navigationController popViewControllerAnimated:NO];
        NSLog(@"swipe Left");
        
        //执行程序
        
    }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)DeleteData:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                                                 initWithTitle:@"你确定要删除吗？"
                                                                 delegate:self
                                                                 cancelButtonTitle:@"取消"
                                                                 destructiveButtonTitle:@"删除"
                                                                 otherButtonTitles:nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;  
    [actionSheet showInView:self.view]; 
    


}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
    [settingM DeleteSQLiteData];
    }
    
}
- (IBAction)BudgetAction:(id)sender {
    UIStoryboard*storyboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    enterTheCategoryViewController*enter=[storyboard instantiateViewControllerWithIdentifier:@"enter"];
    //            [enter setValue:[NSNumber numberWithInt:1] forKey:@"number"];
    enter.number=[NSNumber numberWithInt:4];

    [self.navigationController pushViewController:enter animated:YES];
}
@end
