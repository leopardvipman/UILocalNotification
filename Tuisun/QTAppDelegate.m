//
//  QTAppDelegate.m
//  Tuisun
//
//  Created by 杨 宏强 on 13-1-15.
//  Copyright (c) 2013年 yanghongqiang. All rights reserved.
//

#import "QTAppDelegate.h"

#import "QTViewController.h"
NSString *didReceiveLocalNotification = @"didReceiveLocalNotification";
@implementation QTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[QTViewController alloc] initWithNibName:@"QTViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    [self createLocalNotification];
    
 
    
    return YES;
}


-(void)createLocalNotification {
    // 创建一个本地推送
    
    UILocalNotification *notification = [[UILocalNotification alloc] init] ;
    
    //设置周期之后
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    //获取当前日期
    NSDate*date = [NSDate date];
     NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
            
                       fromDate:date];
    
    NSInteger year = [comps year];
    NSString* yearString=[NSString stringWithFormat:@"%d",year];
    
    yearString=[yearString substringFromIndex:2];
    
    NSLog(@"yearString%@",yearString);
    
    NSInteger month = [comps month];
    
    NSInteger day = [comps day];
    
    NSString *Stirngdate=[NSString stringWithFormat:@"%@-%d-%d 下午8:40",yearString,month,day];
    NSLog(@"is same%@",Stirngdate);
    
    NSDate *fireDate = [dateFormatter dateFromString:Stirngdate];
    
    
    NSDate *pushDate=fireDate;
    
    
    
   // NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:20];
   if (notification != nil) {
        
        // 设置推送时间
       
            notification.fireDate = pushDate;
       
        // 设置时区
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔
         notification.repeatInterval = kCFCalendarUnitDay;
        // 推送声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        
        // 推送内容
        notification.alertBody = @"爱台球";
        
        
        //显示在icon上的红色圈中的数子
        notification.applicationIconBadgeNumber ++;
        
        
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
        
        
        notification.userInfo = info;
        
        
        //添加推送到UIApplication
        UIApplication *app = [UIApplication sharedApplication];
         [app scheduleLocalNotification:notification];
        
    }
}

//第三步：解除本地推送
//- (void) removeLocalNotication {
//    // 获得 UIApplication
//    
//    UIApplication *app = [UIApplication sharedApplication];
//    
//    //获取本地推送数组
//    
//    NSArray *localArray = [app scheduledLocalNotifications];
//    
//    //声明本地通知对象
//    
//    UILocalNotification *localNotification;
//    
//    if (localArray) {
//        
//        
//        for (UILocalNotification *noti in localArray) {
//            
//            
//            NSDictionary *dict = noti.userInfo;
//            
//            
//            if (dict) {
//                
//                
//                NSString *inKey = [dict objectForKey:@"key"];
//                
//                
//                if ([inKey isEqualToString:@"name"]) {
//                    
//                    
//                    if (localNotification){
//                       localNotification = nil;
//                        localNotification.applicationIconBadgeNumber =0;
//                        
//                        
//                    }
//                    break;
//                    
//                    
//                }
//                
//                
//            }
//            
//            
//        }
//        
//        
//        //判断是否找到已经存在的相同key的推送
//        
//        
//        if (!localNotification) {
//            
//            
//            //不存在初始化
//            localNotification = [[UILocalNotification alloc] init];
//            
//            
//        }if (localNotification) {
//            
//            
//            //不推送 取消推送
//            [app cancelLocalNotification:localNotification];
//            return;
//            
//            
//        }
//        
//    }
//}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	//当程序还在后天运行
    application.applicationIconBadgeNumber=0;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //点击提示框的打开
    application.applicationIconBadgeNumber--;
	[[NSNotificationCenter defaultCenter] postNotificationName:didReceiveLocalNotification object:nil userInfo:nil];
}


@end
