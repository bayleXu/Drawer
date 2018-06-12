//
//  SLeftController.swift
//  Drawer
//
//  Created by 叶子 on 2018/6/7.
//  Copyright © 2018年 swift. All rights reserved.
//

import UIKit

class SLeftController: UIViewController {
    
    lazy var presentBtn : UIButton = {
        $0.frame = CGRect.init(x: 50, y: kNavBAR_H! + 20, width: 100, height: 40)
        $0.setTitle("present", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(presentAction(sender:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    /**
     个人觉得push出来的方式大致有三种形式
     1: 从SDrawerController控制器推出来
     2: SLeftController关闭，从SHomeController控制器推出来，并且右滑可返回SHomeController
     3: SLeftController关闭，从SHomeController控制器推出来，并且右滑禁止返回SHomeController,并且在推出的控制器中加入右滑打开SDrawerController方法 (未实现)
     **/
    
    lazy var push1Btn : UIButton = {
        $0.frame = CGRect.init(x: 50, y: kNavBAR_H! + 80, width: 100, height: 40)
        $0.setTitle("push1", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(push1Action(sender:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    lazy var push2Btn : UIButton = {
        $0.frame = CGRect.init(x: 50, y: kNavBAR_H! + 140, width: 100, height: 40)
        $0.setTitle("push2", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(push2Action(sender:)), for: .touchUpInside)
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = kRGBACOLOR(r: 72, g: 77, b: 75, a: 1)
        
        view.addSubview(presentBtn)
        view.addSubview(push1Btn)
        view.addSubview(push2Btn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func presentAction(sender: UIButton) {
        
        let vc = SPresentController()
        let navi = SNaviController.init(rootViewController: vc)
        self.present(navi, animated: true, completion: nil)
    }

    @objc func push1Action(sender: UIButton) {
        
        let vc = SPushController()
        SDrawerController.shareDrawer?.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func push2Action(sender: UIButton) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        kAppDelegate?.homeNaviVC.pushViewController(vc, animated: false)
        SDrawerController.shareDrawer?.closeLeftMenu()
    }

}
