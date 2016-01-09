//
//  Inputs.swift
//  XIM
//
//  Created by k&r on 16/1/8.
//  Copyright © 2016年 k&r. All rights reserved.
//

import Foundation

//使用OptionSet特性校验用户名，密码，邮箱合法性
struct Inputs: OptionSetType {
  let rawValue: Int
  
  static let user = Inputs(rawValue: 1 << 0)  //1
  static let password = Inputs(rawValue: 1 << 1)  //10
  static let email = Inputs(rawValue: 1 << 2)  //100
}

//另一种方法，可以不写方法名.allFillIn
// 但修改语句为    self.navigationItem.rightBarButtonItem?.enabled = self.possibleInputs ? true : false
// 或 self.navigationItem.rightBarButtonItem?.enabled = self.possibleInputs.boolValue
extension Inputs: BooleanType {
  var boolValue : Bool {
    return self.rawValue == 0b111
  }
}

//判断是非全部输入
extension Inputs {
  func allFillIn1() -> Bool {
  //判断方法1⃣️：利用三个布尔值判定
    return self == [.user,.password,.email]
  }
  
  func allFillIn2() -> Bool {
  //判断方法2⃣️：利用rawValue判定
      return self.rawValue == 0b111
  }
  
  func allFillIn3() -> Bool {
  //判断方法3⃣️：选项数目判断
    //在数目范围内查找，找到found++
    let count = 3
    var found = 0
    for time in 0..<count {
      if self.contains(Inputs(rawValue: 1 << time)) {
        found++
      }
    }
    //比较次数是否相同
    return found == count
  }
  
  func allFillIn4() -> Bool {
  //判断方法4⃣️：同判断方法3⃣️
  let count = 3
  var found = 0
    for time in 0..<count where contains(Inputs(rawValue: 1 << time)) {
      found++
    }
  return found == count
  }

}
