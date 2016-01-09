//
//  ConversationViewController.swift
//  XIM
//
//  Created by k&r on 15/12/16.
//  Copyright © 2015年 k&r. All rights reserved.
//

import UIKit

class ConversationViewController: RCConversationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

      /*

            //新建一个聊天会话View Controller对象
            let chat = RCConversationViewController()
            //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众账号等
            chat.conversationType = RCConversationType.ConversationType_PRIVATE
            //设置会话的目标会话ID。（单聊、客服、公众账号服务为对方的ID，讨论组、群聊、聊天室为会话的ID）
            chat.targetId = "ken"
            //设置聊天名字
            chat.userName = "ken"
            //设置聊天会话界面要显示的标题
            chat.title = chat.userName
            //显示聊天会话界面
            self.navigationController?.pushViewController(chat, animated: true)
            //设置成圆形头像
            chat.setMessageAvatarStyle(RCUserAvatarStyle.USER_AVATAR_CYCLE)
      

            self.conversationType = RCConversationType.ConversationType_PRIVATE
            self.targetId = "ken"
            self.userName = targetId
            self.title = targetId
            self.setMessageAvatarStyle(RCUserAvatarStyle.USER_AVATAR_CYCLE)

      */

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

