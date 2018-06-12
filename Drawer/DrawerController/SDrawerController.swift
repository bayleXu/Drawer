//
//  SDrawerController.swift
//  Sigma
//
//  Created by 叶子 on 2018/1/22.
//  Copyright © 2018年 metaarchit. All rights reserved.
//

import UIKit

class SDrawerController: UIViewController {
    
    let screenW = UIScreen.main.bounds.width
    
    weak var mainVC: UIViewController?
    weak var leftVC: UIViewController?
    var maxWidth: CGFloat = kScreenWidth * 4 / 5
    //MARK: - 抽屉
    static var shareDrawer : SDrawerController?
    
    //MARK: - Life Cycle
    init(mainVC: UIViewController, leftMenuVC: UIViewController, leftWidth: CGFloat) {
        
        super.init(nibName: nil, bundle: nil)
        
        self.mainVC = mainVC
        self.leftVC = leftMenuVC
        self.maxWidth = leftWidth
        
        view.addSubview(leftMenuVC.view)
        view.addSubview(mainVC.view)
        
        addChildViewController(leftMenuVC)
        addChildViewController(mainVC)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SDrawerController.shareDrawer = self // 每次初始化賦值
        
        registerNoti()
        leftVC?.view.transform = CGAffineTransform(translationX: -screenW/2 , y: 0)
        
        for childViewController in (mainVC?.childViewControllers)! {
            
            addScreenEdgePanGestureRecognizerToView(view: childViewController.view)
        }
        
    }
    
    // 隐藏导航栏
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    deinit {
        removeNoti()
    }
    
    // 移除通知
    func removeNoti() {
        
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {            // iphoneX
            super.viewSafeAreaInsetsDidChange()
            maxWidth = maxWidth + self.view.safeAreaInsets.left
        }
    }
    
    //MARK: - 注册通知
    func registerNoti() {
        
        // 屏幕旋转
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceOrientationDidChange(sender:)), name: .UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    @objc func handleDeviceOrientationDidChange(sender:UIInterfaceOrientation) {
        
        let orientation = UIApplication.shared.statusBarOrientation
        
        switch orientation {
        case .portrait:
            // 不是iphoneX不需要加安全区域的距离
            // 侧滑菜单打开的时候
            if mainVC?.view.frame.origin.x == maxWidth{
                
                maxWidth = kScreenWidth * 4 / 5
                openLeftMenu()
            } else {
                
                closeLeftMenu()
            }
            // 侧滑菜单未打开的时候
            if mainVC?.view.frame.origin.x == 0 {
                if #available(iOS 11.0, *) {    // iphoneX
                    maxWidth = kScreenWidth * 4 / 5
                } else {
                }
            }
            // 重新设置遮盖按钮的frame
            // 之所以用window的bounds,不用mainVC.bounds,是因为如果是模态出的界面就无法获取mainVC.bounds
            coverBtn.frame = (kAppDelegate?.window?.bounds)!
        default:
            // 侧滑菜单打开的时候
            if #available(iOS 11.0, *) {        // iphoneX
                if (mainVC?.view.frame.origin.x)! + self.view.safeAreaInsets.left == maxWidth {
                    
                    openLeftMenu()
                }else {
                    
                    closeLeftMenu()
                }
            }else {
                if mainVC?.view.frame.origin.x == maxWidth {
                    
                    openLeftMenu()
                }else {
                    
                    closeLeftMenu()
                }
            }
            // 侧滑菜单未打开的时候
            if mainVC?.view.frame.origin.x == 0 {
                if #available(iOS 11.0, *) {    // iphoneX
                    maxWidth = kScreenWidth * 4 / 5 + self.view.safeAreaInsets.left
                } else {
                }
            }
            // 重新设置遮盖按钮的frame
            coverBtn.frame = (kAppDelegate?.window?.bounds)!
        }
    }
    
    //MARK: - 侧边栏跳转功能
    func LeftViewController(didSelectController view: UIViewController) {
        
        let tabbarVC = mainVC as? UITabBarController
        let nav = tabbarVC?.selectedViewController as? UINavigationController
        view.hidesBottomBarWhenPushed = true
        nav?.pushViewController(view, animated: false)
        closeLeftMenu()
    }
    
    //MARK: - 添加屏幕边缘手势
    private func addScreenEdgePanGestureRecognizerToView(view: UIView) {
        
        let pan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgPanGesture(_:)))
        pan.edges = UIRectEdge.left
        pan.delegate = self
        view.addGestureRecognizer(pan)
    }
    
    //MARK: - 屏幕边缘手势
    @objc func edgPanGesture(_ pan: UIScreenEdgePanGestureRecognizer) {
        
        let offsetX = pan.translation(in: pan.view).x
        let rate = (screenW/2)/maxWidth
        let leftOffsetX = offsetX * rate
        
        if pan.state == UIGestureRecognizerState.changed && offsetX <= maxWidth {
            
            mainVC?.view.transform = CGAffineTransform(translationX: max(offsetX, 0), y: 0)
            leftVC?.view.transform = CGAffineTransform(translationX: -screenW/2 + leftOffsetX, y: 0)
            
        } else if pan.state == UIGestureRecognizerState.ended || pan.state == UIGestureRecognizerState.cancelled || pan.state == UIGestureRecognizerState.failed {
            
            if offsetX > screenW * 0.1 {
                
                openLeftMenu()
                
            } else {
                
                closeLeftMenu()
                
            }
            
        }
        
    }
    
    //MARK: - 遮盖按钮手势
    @objc func panCloseLeftMenu(_ pan: UIPanGestureRecognizer) {
        
        let offsetX = pan.translation(in: pan.view).x
        if offsetX > 0 {return}
        
        if pan.state == UIGestureRecognizerState.changed && offsetX >= -maxWidth {
            
            let distace = maxWidth + offsetX
            let rate = (screenW/2)/maxWidth
            let leftOffsetX = distace * rate
            
            mainVC?.view.transform = CGAffineTransform(translationX: distace, y: 0)
            leftVC?.view.transform = CGAffineTransform(translationX: -screenW/2 + leftOffsetX, y: 0)
            
        } else if pan.state == UIGestureRecognizerState.ended || pan.state == UIGestureRecognizerState.cancelled || pan.state == UIGestureRecognizerState.failed {
            
            if offsetX > screenW * 0.5 {
                
                openLeftMenu()
                
            } else {
                
                closeLeftMenu()
            }
            
        }
        
    }
    
    //MARK: - 打开左侧菜单
    func openLeftMenu() {

        weak var weakSelf = self
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {

            weakSelf?.mainVC?.view.transform = CGAffineTransform(translationX: self.maxWidth, y: 0)
            weakSelf?.leftVC?.view.transform = CGAffineTransform(translationX: 0 , y: 0)
            
        }, completion: {
            
            (finish: Bool) -> () in

            weakSelf?.mainVC?.view.addSubview((weakSelf?.coverBtn)!)
            
        })
        
    }
    
    //MAKR: - 无时差打开左侧菜单
    func openLeftMenuNoTime() {
        
        weak var weakSelf = self
        UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
            
            weakSelf?.mainVC?.view.transform = CGAffineTransform(translationX: self.maxWidth, y: 0)
            weakSelf?.leftVC?.view.transform = CGAffineTransform(translationX: 0 , y: 0)
            
        }, completion: {
            
            (finish: Bool) -> () in
            
            weakSelf?.mainVC?.view.addSubview((weakSelf?.coverBtn)!)
            
        })
    }
    
    //MARK: - 关闭左侧菜单
    @objc func closeLeftMenu() {
        
        weak var weakSelf = self
        UIView.animate(withDuration: 0.25, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {

            weakSelf?.mainVC?.view.transform = CGAffineTransform.identity
            weakSelf?.leftVC?.view.transform = CGAffineTransform(translationX: -self.screenW/2 , y: 0)
            
        }, completion: {
            
            (finish: Bool) -> () in

            weakSelf?.coverBtn.removeFromSuperview()
        })
        
    }
    
    //MARK: - 灰色背景按钮
    private lazy var coverBtn: UIButton = {
        
        let btn = UIButton(frame: (kAppDelegate?.window?.bounds)!)
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(closeLeftMenu), for: .touchUpInside)
        btn.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panCloseLeftMenu(_:))))
        
        return btn
        
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SDrawerController : UIGestureRecognizerDelegate
{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
