//
//  AppDelegate.swift
//  XIM
//
//  Created by k&r on 15/12/16.
//  Copyright © 2015年 k&r. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, RCIMUserInfoDataSource {

  var window: UIWindow?
  
  //根据UserId返回用户信息
  func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
    let userInfo = RCUserInfo()   //赋值一个空值
    userInfo.userId = userId
    
    //没有服务器，所以硬编码一个用户信息
    switch userId {
      case "ken":
       userInfo.name = "ken"
       userInfo.portraitUri = "http://f.hiphotos.baidu.com/image/pic/item/63d0f703918fa0ecbd632845279759ee3c6ddbd6.jpg"
       print("userId为ken")
      case "ken1":
       userInfo.name = "ken1"
       userInfo.portraitUri = "http://img3.imgtn.bdimg.com/it/u=3843280280,1494860957&fm=21&gp=0.jpg"
       print("userId为ken1")
      default:
       print("无此账户")
    }
    return completion(userInfo)
  }
  
  func connectServer (completion:() -> Void) {
    //连接登陆函数,把下边函数写上来独立开

    //获取保存得Token
//    let deviceTokenCache = NSUserDefaults.standardUserDefaults().objectForKey("kDeviceToken")as?String
    
    //初始化appkey
    RCIM.sharedRCIM().initWithAppKey("yourDataFromRongCloudOrLeanCloud")
    
    //用Token测试连接
    RCIM.sharedRCIM().connectWithToken("yourDataFromRongCloudOrLeanCloud",
      success: { (userId) -> Void in
        print("登陆成功。当前登录的用户ID：\(userId)")
        
        let currentUser = RCUserInfo.init(userId: "ken", name: "ken", portrait: "http://f.hiphotos.baidu.com/image/pic/item/63d0f703918fa0ecbd632845279759ee3c6ddbd6.jpg")
        RCIMClient.sharedRCIMClient().currentUserInfo = currentUser
        
        //异步操作，使用主线程
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          completion()
        })
          
        
      }, error: { (status) -> Void in
        print("登陆的错误码为:\(status.rawValue)")
      }, tokenIncorrect: {
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        print("token错误")
    })
  }

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    
/*    //获取保存得Token
    let deviceTokenCache = NSUserDefaults.standardUserDefaults().objectForKey("kDeviceToken")as?String
    
    //初始化appkey
    RCIM.sharedRCIM().initWithAppKey("yourDataFromRongCloudOrLeanCloud")
    
    //  设定用户信息数据源之后，必须设定代理，此次代理微app delegate本身，
    //设定用户数据提供者 AppDelegate       //依然无法获得头像，原因不明
    RCIM.sharedRCIM().userInfoDataSource = self
    
    //用Token测试连接
    RCIM.sharedRCIM().connectWithToken("yourDataFromRongCloudOrLeanCloud",
      success: { (userId) -> Void in
        print("登陆成功。当前登录的用户ID：\(userId)")

          //原视频教程
          //let currentUser = RCUserInfo.init(userId: "ken", name: "ken", portrait: "http://f.hiphotos.baidu.com/image/pic/item/63d0f703918fa0ecbd632845279759ee3c6ddbd6.jpg")
          //RCIMClient.sharedRCIMClient().currentUserInfo = currentUser
        
      }, error: { (status) -> Void in
        print("登陆的错误码为:\(status.rawValue)")
      }, tokenIncorrect: {
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        print("token错误")
    })   */
    
    //  设定用户信息数据源之后，必须设定代理，此次代理微app delegate本身，
    //设定用户数据提供者 AppDelegate       //依然无法获得头像，原因不明
    RCIM.sharedRCIM().userInfoDataSource = self

    
    
    //以上为融云部分
    //以下为leanCloud部分
    //获取LeanCloud授权
    AVOSCloud.setApplicationId("yourDataFromRongCloudOrLeanCloud", clientKey: "yourDataFromRongCloudOrLeanCloud")

    return true
  }
 

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

