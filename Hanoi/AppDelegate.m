//
//  AppDelegate.m
//  Hanoi
//
//  Created by lifeng on 17/1/20.
//  Copyright © 2017年 fq. All rights reserved.
//

#import "AppDelegate.h"

static int count = 0;

@interface AppDelegate ()

@property (nonatomic,strong)NSMutableArray * arrayX;
@property (nonatomic,strong)NSMutableArray * arrayY;
@property (nonatomic,strong)NSMutableArray * arrayZ;

@end


@implementation AppDelegate


- (void)move:(NSInteger)i from:(NSString *)source to:(NSString *)target
{
    NSLog(@"[%d] move disk [%ld] from __%@__ to __%@__ ",++count,i,source,target);
    if ([source isEqualToString:@"x"])
    {
        [self.arrayX removeObject:[NSString stringWithFormat:@"%ld",i]];
    }
    if ([source isEqualToString:@"y"])
    {
        [self.arrayY removeObject:[NSString stringWithFormat:@"%ld",i]];
    }
    if ([source isEqualToString:@"z"])
    {
        [self.arrayZ removeObject:[NSString stringWithFormat:@"%ld",i]];
    }
    
    if ([target isEqualToString:@"x"])
    {
        [self.arrayX insertObject:[NSString stringWithFormat:@"%ld",i] atIndex:0];
    }
    if ([target isEqualToString:@"y"])
    {
        [self.arrayY insertObject:[NSString stringWithFormat:@"%ld",i] atIndex:0];
    }
    if ([target isEqualToString:@"z"])
    {
        [self.arrayZ insertObject:[NSString stringWithFormat:@"%ld",i] atIndex:0];
    }
    
    NSMutableString * arrayStr = [NSMutableString stringWithString:@"["];
    [self.arrayX enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrayStr appendString:obj];
    }];
    [arrayStr appendString:@"] "];
    
    [arrayStr appendString:@"["];
    [self.arrayY enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrayStr appendString:obj];
    }];
    [arrayStr appendString:@"] "];
    
    [arrayStr appendString:@"["];
    [self.arrayZ enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrayStr appendString:obj];
    }];
    [arrayStr appendString:@"] "];
    
    NSLog(@"%@",arrayStr);
}

- (void)hanoi:(NSInteger)n x:(NSString *)x y:(NSString *)y z:(NSString *)z
{
    if (n == 1)
    {
        [self move:1 from:x to:z];
    }
    else
    {
        [self hanoi:n-1 x:x y:y z:z];

        [self move:n from:x to:y];

        [self hanoi:n-1 x:z y:y z:x];

        [self move:n from:y to:z];
        
        [self hanoi:n-1 x:x y:y z:z];

    }
}

- (NSInteger)indexOfString:(NSString *)originString withSubStrig:(NSString *)subString
{
    NSInteger pos , i , j;
    pos = i = 0;
    j = 0;
    while (i < originString.length && j < subString.length) {
        char originChar = [originString characterAtIndex:i];
        char subChar = [subString characterAtIndex:j];
        if (originChar == subChar)
        {
            i++;
            j++;
        }
        else
        {
            pos ++;
            i = pos;
            j = 0;
        }
        
        count ++;
    }
    if (j == subString.length)
    {
        return pos;
    }
    else
    {
        return -1;
    }
}

- (NSInteger)kmp_indexOfString:(NSString *)originString withSubStrig:(NSString *)subString
{
    NSInteger pos , i , j, offset;
    pos = i = 0;
    j = 0;
    offset = 0;
    while (i < originString.length && j < subString.length) {
        char originChar = [originString characterAtIndex:i];
        char subChar = [subString characterAtIndex:j];
        if (originChar == subChar)
        {
            i++;
            j++;
            offset ++;
        }
        else
        {
            pos = pos + (offset >= 1 ? offset : 1);
            i = pos;
            j = 0;
            offset = 0;
        }
        
        count ++;
    }
    if (j == subString.length)
    {
        return pos;
    }
    else
    {
        if (i == originString.length)
        {
            //需要判断越界问题
            return -1;
        }
        else
        {
            return -1;
        }
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    float sum;
    int i;
    
    sum = 0;
    
    for (i = 0;i<100;i++)
    {
        sum = sum + 0.1;
    }
    NSLog(@"%f",sum);
    NSString * aa = @"a";
    NSString * bb = @"a".mutableCopy;
    NSMutableArray * array = [NSMutableArray array];
    [array addObject:aa];
    BOOL isContain = [array containsObject:bb];
    NSLog(@"isContain:%@",isContain?@"YES":@"NO");
    
    NSInteger index = [self kmp_indexOfString:@"00000000000001" withSubStrig:@"001"];
    NSLog(@"indexOfString is %ld,count is %d",index,count);
    
//    self.arrayX = @[@"1",@"2",@"3",@"4"].mutableCopy;
//    self.arrayY = @[].mutableCopy;
//    self.arrayZ = @[].mutableCopy;
//    [self hanoi:4 x:@"x" y:@"y" z:@"z"];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
