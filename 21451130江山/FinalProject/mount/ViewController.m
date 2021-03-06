//
//  ViewController.m
//  mount
//
//  Created by 江山 on 12/3/14.
//  Copyright (c) 2015 jiangshan. All rights reserved.
//

#import "ViewController.h"
#import "settingViewController.h"
#import "displayViewController.h"
#import "billViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIGlossyButton.h"
#import "UIView+LayerEffects.h"
#import "billManagement.h"
#import "settingManagement.h"
#import "payout.h"
@interface ViewController ()
@property(strong,nonatomic)FMDatabase*Fdb;
@property(strong,nonatomic)billManagement*billM;
@property(strong,nonatomic)NSArray*BillArray;

@end

@implementation ViewController
@synthesize myImage;
@synthesize tableOutlet;

@synthesize list,Fdb;
@synthesize billM;
@synthesize BillArray;

- (void)viewDidLoad
{

    [super viewDidLoad];

    billM=[[billManagement alloc]init];
    self.tableOutlet.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.navigationItem.hidesBackButton=YES;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"view.png"]];
    
    
    
//-----------------自定义记一笔button-------------------------
//    UIGlossyButton *b;
//    b = (UIGlossyButton*) [self.view viewWithTag: 1018];
//	[b useWhiteLabel: YES]; b.tintColor = [UIColor whiteColor];
//	[b setShadow:[UIColor blackColor] opacity:0.8 offset:CGSizeMake(0, 1) blurRadius: 4];
//    [b setGradientType:kUIGlossyButtonGradientTypeLinearSmoothExtreme];
//-------------------自定义记一笔button------------------------
//    self.navigationController.navigationBar.barStyle=UIBarStyleBlackOpaque;
    
    
    UISwipeGestureRecognizer *recognizer; 
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    [[self view] addGestureRecognizer:recognizer];
    

    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    [[self view] addGestureRecognizer:recognizer];
    

    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
    
    [[self view] addGestureRecognizer:recognizer];
    


    
    //UISwipeGestureRecognizer *recognizer;
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    
    [[self view] addGestureRecognizer:recognizer];


	// Do any additional setup after loading the view, typically from a nib.
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        
        displayViewController*svc=[storyboard instantiateViewControllerWithIdentifier:@"display"];
        [self.navigationController pushViewController:svc animated:YES];
        NSLog(@"swipe left");

    }
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        settingViewController*svc=[storyboard instantiateViewControllerWithIdentifier:@"setting"];
        CATransition*transition=[CATransition animation];
        transition.duration=0.3;
        transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type=kCATransitionPush;
        transition.subtype=kCATransitionFromLeft;
        
        [self.navigationController.view setBackgroundColor:[UIColor colorWithRed:0.0 green:156.0/255 blue:181.0/255 alpha:1]];
        [self.navigationController.view.layer addAnimation:transition forKey:nil];

        [self.navigationController pushViewController:svc animated:NO];
        NSLog(@"swipe right");
        
        //执行程序
        
    }
    
}
- (void)viewDidUnload
{
    [self setMyImage:nil];
  
    [self setTableOutlet:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
-(void)viewWillAppear:(BOOL)animated{
    self.BillArray=[self.billM getRecentlyPayouDate];
    [self.tableOutlet reloadData];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [BillArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    payout* _payout=[BillArray objectAtIndex:indexPath.row];
    NSLog(@"%d",_payout.payout_ID);
//    NSLog(@"%d---%@",indexPath.row,_payout.type);
    UILabel*label=(UILabel*)[cell viewWithTag:1];
    label.text=[NSString stringWithFormat:@"%.2f",_payout.amount];
    label=(UILabel*)[cell viewWithTag:2];
    label.text=_payout.date;
    label=(UILabel*)[cell viewWithTag:3];
    label.text=_payout.type;
    label=(UILabel*)[cell viewWithTag:4];
    label.text=_payout.personnel;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    payout* _payout=[BillArray objectAtIndex:indexPath.row];
    NSLog(@"payout_id %d",_payout.payout_ID);
    
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    billViewController*svc=[storyboard instantiateViewControllerWithIdentifier:@"bill"];
    svc.billIndex=_payout.payout_ID;
    svc.backTypeNSString=@"View";
    CATransition*transition=[CATransition animation];
    transition.duration=0.5;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type=kCATransitionPush;
    transition.subtype=kCATransitionFromTop;
    
    [self.navigationController.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:svc animated:NO];
}

- (IBAction)bill:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    billViewController*svc=[storyboard instantiateViewControllerWithIdentifier:@"bill"];
    svc.billIndex=-1;
    svc.backTypeNSString=@"View";
    CATransition*transition=[CATransition animation];
    transition.duration=0.5;
    transition.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type=kCATransitionPush;
    transition.subtype=kCATransitionFromTop;
    
    [self.navigationController.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:svc animated:NO];
}
@end
