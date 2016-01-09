//
//  LoginViewController.swift
//  XIM
//
//  Created by k&r on 15/12/31.
//  Copyright © 2015年 k&r. All rights reserved.
//

import UIKit

//extension UIView {
//  //设置圆角属性
//  @IBInspectable var cornerRadius : CGFloat {
//    get {
//      return layer.cornerRadius
//    }
//    set {
//      layer.cornerRadius = newValue
//      layer.masksToBounds = (newValue > 0)
//    }
//  }
//}

class LoginViewController: UIViewController {//JSAnimatedImagesViewDataSource {

  @IBOutlet weak var LoginStackView: UIStackView!
//  @IBOutlet weak var WallPaper: JSAnimatedImagesView! //设置壁纸1⃣️

  override func viewDidLoad() {
      super.viewDidLoad()
    
      //设置壁纸：2⃣️，报错，存在壁纸的view就报错
//      self.WallPaper.dataSource = self

        // Do any additional setup after loading the view.
    }
  
  override func viewWillAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.navigationController?.navigationBarHidden = true
  }
  
//  //设置壁纸：图片数量3⃣️
//  func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
//    return 1
//  }
//  //设置壁纸：图片名4⃣️
//  func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
//    return UIImage(named: "IMG_2818")
//  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    //显示动画转场
    UIView.animateWithDuration(1.0) { () -> Void in
      //水平改成竖直
      self.LoginStackView.axis = UILayoutConstraintAxis.Horizontal
    }
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
