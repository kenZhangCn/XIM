//
//  RoundImageView.swift
//  XIM
//
//  Created by k&r on 16/1/4.
//  Copyright © 2016年 k&r. All rights reserved.
//

import UIKit

@IBDesignable
class RoundImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  @IBInspectable var cornerRadius : CGFloat = 0 {
    //实时显示圆角渲染
    didSet {
      layer.cornerRadius = cornerRadius
      layer.masksToBounds = cornerRadius > 0
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    //添加描边
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var borderColour: UIColor? {
    //描边颜色,面板只识别UIColor
    didSet {
      layer.borderColor = borderColour?.CGColor
    }
  }
  
  
}
