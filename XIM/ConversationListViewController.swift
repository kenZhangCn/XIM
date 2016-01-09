//
//  ConversationListViewController.swift
//  XIM
//
//  Created by k&r on 15/12/17.
//  Copyright © 2015年 k&r. All rights reserved.
//

import UIKit

class ConversationListViewController: RCConversationListViewController {
  
  @IBAction func plusMenu(sender: UIBarButtonItem) {
//  //利用KxMenu from cocoapods增加＋号功能为弹出菜单
//    var frame = sender.valueForKey("view")?.frame    //因为view由storyboard生成，导致sender.frame属性无法使用，自建一个属性
//    frame?.origin.y = (frame?.origin.y)! + 30
//    KxMenu.showMenuInView(self.view, fromRect: frame!, menuItems: [KxMenuItem("客服", image:UIImage(named:"已导入到图片名，注意时UIImage类型"), target:self, action:"clickMenu1"),KxMenuItem("测试跳转到聊天界面", image:nil, target:self, action:"clickMenu2")])
    
    //改用pop做弹出菜单
    let items = [MenuItem(title: "客服", iconName: "企鹅", glowColor: UIColor.redColor(), index: 0),
      MenuItem(title: "测试跳转到聊天界面", iconName: "企鹅", glowColor: UIColor.yellowColor(), index: 1),
      MenuItem(title: "通讯录", iconName: "企鹅", glowColor: UIColor.blueColor(), index: 2),
      MenuItem(title: "关于", iconName: "企鹅", glowColor: UIColor.greenColor(), index: 3)
    ]
    let menu = PopMenu(frame: self.view.bounds, items: items)
    menu.menuAnimationType = PopMenuAnimationType.Sina
    if menu.isShowed{
      return
    }
    menu.didSelectedItemCompletion = { (selectedItem: MenuItem!) -> Void in
      print(selectedItem.index)
      switch selectedItem.index {
      case 1 :     //实现clickMenu2功能
        let chat = RCConversationViewController()
        chat.userName = "ken"
        chat.targetId = "ken"
        chat.conversationType = RCConversationType.ConversationType_PRIVATE
        chat.title = chat.targetId
        self.navigationController?.pushViewController(chat, animated: true)   //弹出聊天界面
        self.tabBarController?.tabBar.hidden = true
      default :
        print(selectedItem.title)
      }
    }
    menu.showMenuAtView(self.view)
  }
  
  func clickMenu1() {
    print("你点击了第1项")
  }
  func clickMenu2() {
    print("你点击了第2项")
    // 使用代码跳转到会话界面
    let chat = RCConversationViewController()
    chat.userName = "ken"
    chat.targetId = "ken"
    chat.conversationType = RCConversationType.ConversationType_PRIVATE
    chat.title = chat.targetId
    self.navigationController?.pushViewController(chat, animated: true)   //弹出聊天界面
    self.tabBarController?.tabBar.hidden = true      //隐藏底部tabbar
  }

  //使用storyboard跳转到会话界面1⃣️
  let chat = RCConversationViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
      // Do any additional setup after loading the view.
  
      let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
      
      appDelegate?.connectServer({ () -> Void in
        print("ConversationList接连成功")
                
      //设置需要显示哪些类型的会话,使用rawValue变成整型，因为时OC桥接过来的
      self.setDisplayConversationTypes([
        RCConversationType.ConversationType_PRIVATE.rawValue,
        RCConversationType.ConversationType_DISCUSSION.rawValue,
        RCConversationType.ConversationType_CHATROOM.rawValue,
        RCConversationType.ConversationType_GROUP.rawValue,
        RCConversationType.ConversationType_APPSERVICE.rawValue,
        RCConversationType.ConversationType_SYSTEM.rawValue])
      //设置需要将哪些类型的会话在会话列表中聚合显示
      self.setCollectionConversationType([
        RCConversationType.ConversationType_DISCUSSION.rawValue,
        RCConversationType.ConversationType_GROUP.rawValue])
      //刷新列表才会显示
      self.refreshConversationTableViewIfNeeded()
        
      // self.title = "连接成功"   //测试异步主线程区别
      })
    }
  
  //重写RCConversationListViewController的onSelectedTableRow事件
   override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
    
  //打开会话界面
  //使用代码跳转到会话界面
     //let chat = RCConversationViewController(conversationType: model.conversationType, targetId: model.targetId)
     //chat.title = model.conversationTitle
     //chat.userName = model.conversationTitle
//   chat.conversationType = RCConversationType.ConversationType_PRIVATE
     //self.navigationController?.pushViewController(chat, animated: true)
     //self.tabBarController?.tabBar.hidden = true
  
  //使用storyboard跳转到会话界面2⃣️
    chat.targetId = model.targetId
    chat.userName = model.conversationTitle
    chat.conversationType = RCConversationType.ConversationType_PRIVATE
    chat.title = model.conversationTitle
    chat.setMessageAvatarStyle(RCUserAvatarStyle.USER_AVATAR_CYCLE)
    self.performSegueWithIdentifier("tapOnCell", sender: self)
   }


   override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
       // Dispose of any resources that can be recreated.
   }

  
    override func viewWillAppear(animated: Bool) {
      //此方法显示tab bar，返回列表窗口时现实tab Bar
      self.tabBarController?.tabBar.hidden = false
    }

  
    // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         // Get the new view controller using segue.destinationViewController.
         // Pass the selected object to the new view controller.
      
      //使用storyboard跳转到会话界面3⃣️
      let chatVC = segue.destinationViewController as? RCConversationViewController
      chatVC?.targetId = chat.targetId
      chatVC?.userName = chat.userName
      chatVC?.conversationType = chat.conversationType
      chatVC?.title = chat.title
      
       //此方法隐藏tab bar，打开对话窗口之后隐藏
       self.tabBarController?.tabBar.hidden = true
     }
  

}


