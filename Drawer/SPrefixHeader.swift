//
//  SPrefixHeader.swift
//  Drawer
//
//  Created by 叶子 on 2018/6/7.
//  Copyright © 2018年 swift. All rights reserved.
//

import UIKit

let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenBounds = UIScreen.main.bounds

let kStatusBAR_H = UIApplication.shared.statusBarFrame.size.height
let kNavBAR_H = kAppDelegate?.homeNaviVC.navigationBar.frame.size.height
let kNavBAR_landscapeH = 32     //导航栏横屏高度32

//adlg
let kAppDelegate = UIApplication.shared.delegate as? AppDelegate

//RGB颜色
func kRGBACOLOR(r : CGFloat, g : CGFloat, b : CGFloat, a: CGFloat) -> UIColor {
    return UIColor.init(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: (a))
}
