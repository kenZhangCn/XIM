//
//  RegTableViewController.swift
//  XIM
//
//  Created by k&r on 16/1/5.
//  Copyright © 2016年 k&r. All rights reserved.
//

import UIKit

class RegTableViewController: UITableViewController {

//  用户名，密码，邮箱格式合法时使done按钮显示方法1⃣️
//  var (userOK,passwordOK,emailOK) = (false,false,false)
  
//  用户名，密码，邮箱格式合法时使done按钮显示方法2⃣️
  var possibleInputs : Inputs = []

  //校验各项内容
  @IBOutlet var mustFillInField: [UITextField]!
  @IBOutlet weak var user: UITextBox!
  @IBOutlet weak var password: UITextBox!
  @IBOutlet weak var email: UITextBox!
  @IBOutlet weak var phoneNumber: UITextBox!
  @IBOutlet weak var findBackQuestion: UITextBox!
  @IBOutlet weak var findBackAnswer: UITextBox!
  
  
  func checkRequiredField() {
    //检查文本框输入合法性方法1⃣️：利用第三方UIView＋ViewRecursion检查必填项
//    self.view.runBlockOnAllSubviews { (subview) -> Void in
//      if let subview = subview as? UITextField {
//        if subview.text!.isEmpty {
//          print("文本框为空")
//          //显示完成按钮的提示
//          let alert = UIAlertController(title: "提示", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
//          let action = UIAlertAction(title: "请填写完整！", style: UIAlertActionStyle.Default, handler: nil)
//          alert.addAction(action)
//          self.presentViewController(alert, animated: true, completion: nil)
//        }
//      }
//    }
    //检查文本框输入合法性方法2⃣️：利用IBOoulet Collection检查必填项
//    for textField in mustFillInField {
//      if textField.text!.isEmpty {
//        print("必填项为空")
//      }
//    }
    //检查文本框输入合法性方法3⃣️：单独检查每一项,使用HUD：SwiftNotice进行展示
//     if user.text!.isEmpty {
//      print("用户名为空")
//      alert("用户名")
//     } else {
//      if password.text!.isEmpty {
//        print("密码为空")
//        alert("密码")
//      } else {
//        if email.text!.isEmpty {
//          print("邮箱为空")
//          alert("邮箱")
//        }
//      }
//    }
    //检查文本框输入合法性方法4⃣️：单独检查每一项,使用HUD：SwiftNotice进行展示
    if user.text!.isEmpty {
      print("用户名为空")
      self.errorNotice("请输入用户名")
    } else {
      if password.text!.isEmpty {
        print("密码为空")
        self.errorNotice("请输入密码")
      } else {
        let regex = "[A-Z0-9a-z._%+_]+@[A-za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        guard predicate.evaluateWithObject(email.text) else {
          self.errorNotice("Email格式错误")
          return
        }
//        if email.text!.isEmpty {
//          print("邮箱为空")
//          self.successNotice("请输入邮箱")
//        }
      }
    }
    // 检查文本框输入合法性方法5⃣️，建立正则表达式检验
//    let regex = "[A-Z0-9a-z._%+_]+@[A-za-z0-9.-]+\\.[A-Za-z]{2,4}"
//    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
//    guard predicate.evaluateWithObject(email.text) else {
//      self.noticeOnlyText("Email格式错误")
//      return
//    }
  }
  
  func alert(alertContent:String) {
    //弹出提示
    let alert = UIAlertController(title: "提示", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
    let action = UIAlertAction(title: "请填写\(alertContent)", style: UIAlertActionStyle.Default, handler: nil)
    alert.addAction(action)
    self.presentViewController(alert, animated: true, completion: nil)
  }
 
  
  
  override func viewDidLoad() {
      super.viewDidLoad()
      
      self.navigationController?.navigationBarHidden = false
      self.title = "注册新用户"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
      //改造buttom按钮为done按钮
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneButtonTap")
      
      //检查文本框输入合法性方法6⃣️：利用AJValidator进行校验
      //user输入时候验证
      self.navigationItem.rightBarButtonItem?.enabled = false
      let userValidator = AJWValidator(type: .String)
      userValidator.addValidationToEnsureMinimumLength(3, invalidMessage: "至少三位")
      userValidator.addValidationToEnsureMaximumLength(10, invalidMessage: "最长十位")
      self.user.ajw_attachValidator(userValidator)
      
      userValidator.validatorStateChangedHandler = { (newState:AJWValidatorState) -> Void in
        switch newState {
        case AJWValidatorState.ValidationStateValid:
          self.user.highlightState = .Default
          self.possibleInputs.unionInPlace(Inputs.user)  //  把user添加进去 //用户名，密码，邮箱格式合法时使done按钮显示方法2⃣️
//          self.userOK = true     //  用户名，密码，邮箱格式合法时使done按钮显示方法1⃣️
        default:
          let userErrorMessage = userValidator.errorMessages.first as? String
          self.user.highlightState = UITextBoxHighlightState.Wrong(userErrorMessage!)
          self.possibleInputs.subtractInPlace(Inputs.user)  //无效状态移除user //用户名，密码，邮箱格式合法时使done按钮显示方法2⃣️
//          self.userOK = false    //  用户名，密码，邮箱格式合法时使done按钮显示方法1⃣️
        }
//        self.navigationItem.rightBarButtonItem?.enabled = (self.userOK && self.passwordOK && self.emailOK)    //  用户名，密码，邮箱格式合法时使done按钮显示方法1⃣️
         self.navigationItem.rightBarButtonItem?.enabled = self.possibleInputs.allFillIn4()    //  用户名，密码，邮箱格式合法时使done按钮显示方法2⃣️
      }
      //password输入验证
      let passwordValidator = AJWValidator(type: .String)
      passwordValidator.addValidationToEnsureMinimumLength(3, invalidMessage: "密码至少三位")
      passwordValidator.addValidationToEnsureMaximumLength(15, invalidMessage: "最长15位")
      self.password.ajw_attachValidator(passwordValidator)
        
      passwordValidator.validatorStateChangedHandler = { (newState:AJWValidatorState) -> Void in
        switch newState {
        case AJWValidatorState.ValidationStateValid:
          self.password.highlightState = UITextBoxHighlightState.Default
          self.possibleInputs.unionInPlace(Inputs.password)  //  用户名，密码，邮箱格式合法时使done按钮显示方法2⃣️
//          self.passwordOK = true     //  用户名，密码，邮箱格式合法时使done按钮显示方法1⃣️
        default:
          let passwordErrorMessage = passwordValidator.errorMessages.first as? String
          self.password.highlightState = UITextBoxHighlightState.Wrong(passwordErrorMessage!)
          self.possibleInputs.subtractInPlace(Inputs.password)  //用户名，密码，邮箱格式合法时使done按钮显示方法2⃣️
//          self.passwordOK = false    //  用户名，密码，邮箱格式合法时使done按钮显示方法1⃣️
        }
//        self.navigationItem.rightBarButtonItem?.enabled = (self.userOK && self.passwordOK && self.emailOK)  //  用户名，密码，邮箱格式合法时使done按钮显示方法1⃣️
        self.navigationItem.rightBarButtonItem?.enabled = self.possibleInputs.allFillIn4()   //  用户名，密码，邮箱格式合法时使done按钮显示方法2⃣️
//        self.navigationItem.rightBarButtonItem?.enabled = self.possibleInputs ? true : false   //另一个extension
//        self.navigationItem.rightBarButtonItem?.enabled = self.possibleInputs.boolValue        //另一个extension

      }
      //email输入验证
      let emailValidator = AJWValidator(type: .String)
      emailValidator.addValidationToEnsureValidEmailWithInvalidMessage("请输入Email")
      self.email.ajw_attachValidator(emailValidator)
      
      emailValidator.validatorStateChangedHandler = { (newState:AJWValidatorState) -> Void in
        switch newState {
        case AJWValidatorState.ValidationStateValid:
          self.email.highlightState = UITextBoxHighlightState.Default
          self.possibleInputs.unionInPlace(Inputs.email)  //  用户名，密码，邮箱格式合法时使done按钮显示方法2⃣️
//          self.emailOK = true      //  用户名，密码，邮箱格式合法时使done按钮显示方法1⃣️
        default:
          let emailErrorMessage = emailValidator.errorMessages.first as? String
          self.email.highlightState = UITextBoxHighlightState.Wrong(emailErrorMessage!)
          self.possibleInputs.subtractInPlace(Inputs.email)  // 用户名，密码，邮箱格式合法时使done按钮显示方法2⃣️
//          self.emailOK = false    //  用户名，密码，邮箱格式合法时使done按钮显示方法1⃣️
        }
//        self.navigationItem.rightBarButtonItem?.enabled = (self.userOK && self.passwordOK && self.emailOK)     //  用户名，密码，邮箱格式合法时使done按钮显示方法1⃣️
        self.navigationItem.rightBarButtonItem?.enabled = self.possibleInputs.allFillIn4()   //  用户名，密码，邮箱格式合法时使done按钮显示方法2⃣️
      }
    }
  
  func doneButtonTap() {
    
    //显示一个载入提示
    self.pleaseWait()
  
    //建立用户 AVObject
    let user = AVObject(className: "XIMUser")
  
    //吧输入文本框值设置到对象,使用setObject或者下标都可以,key不能使用中文
    user.setObject(self.user.text, forKey: "user")
    user.setObject(self.password.text, forKey: "password")
    user.setObject(self.email.text, forKey: "email")
    user.setObject(self.phoneNumber.text, forKey: "phoneNumber")
    user.setObject(self.findBackQuestion.text, forKey: "findBackQuestion")
    user.setObject(self.findBackAnswer.text, forKey: "findBackAnswer")
    
    //查询是否注册名已经存在
    let query = AVQuery(className: "XIMUser")
    query.whereKey("user", equalTo: self.user.text)
    
    //执行查询
    query.getFirstObjectInBackgroundWithBlock { (existUser, e) -> Void in
      self.clearAllNotice()
      
      //如果查询到用户则
      if existUser != nil {
        self.errorNotice("用户已注册")
        //光标移到用户名方便修改
        self.user.becomeFirstResponder()
      } else {

        //用户注册,即把对象保持到云端
        user.saveInBackgroundWithBlock({ (succeed, e) -> Void in
          if succeed {
            self.successNotice("注册成功！")
            //若注册成功，弹回上一层
            self.navigationController?.popViewControllerAnimated(true)
          } else {
            self.errorNotice(e.localizedDescription)
            print(e.localizedDescription)
            print(e.localizedFailureReason)
          }
        })
      }
    }
}



  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
//    //dynamic的时候使用，static会覆盖storyboard
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 3
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
