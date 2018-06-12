//
//  SNaviController.swift
//  Sigma
//
//  Created by 叶子 on 2018/1/22.
//  Copyright © 2018年 metaarchit. All rights reserved.
//

import UIKit

class SNaviController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.shadowImage = UIImage()
        
        if self.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            weak var weakSelf = self
            interactivePopGestureRecognizer?.delegate = weakSelf
            delegate = weakSelf
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SNaviController : UIGestureRecognizerDelegate, UINavigationControllerDelegate
{
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if animated {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @discardableResult
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if animated {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }
        return super.popToRootViewController(animated: animated)
    }
    
    @discardableResult
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        self.interactivePopGestureRecognizer?.isEnabled = false
        return super.popToViewController(viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer && self.viewControllers.count < 2 {
            return false
        }
        // 禁止右滑手势
        if self.viewControllers.count > 0 && self.viewControllers.count == 2 {
            
            // 对想要禁止的控制器禁止右滑
//            if self.viewControllers.last is SAddressBookController {
//                return false
//            }
//            if self.viewControllers.last is SRecycleBoxController {
//                return false
//            }
//            if self.viewControllers.last is SSettingController {
//                return false
//            }
//            if self.viewControllers.last is SEmailModeController {
//                return false
//            }
        }
        return true
    }
}
