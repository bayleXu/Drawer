//
//  SPushController.swift
//  Drawer
//
//  Created by 叶子 on 2018/6/12.
//  Copyright © 2018年 swift. All rights reserved.
//

import UIKit

class SPushController: UIViewController {
    
    lazy var pushBtn : UIButton = {
        $0.frame = CGRect.init(x: 50, y: kNavBAR_H! + 80, width: 100, height: 40)
        $0.setTitle("push", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(pushAction(sender:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    // 自定义的仿导航栏视图
    lazy var naviBar : UIVisualEffectView = {
       
        let tempBar = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .extraLight))
        tempBar.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kStatusBAR_H + kNavBAR_H!)
        return tempBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(naviBar)
        view.addSubview(pushBtn)
    }
    
    // 隐藏导航栏
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushAction(sender: UIButton) {
        
        let vc = SPushNextController()
        vc.view.backgroundColor = .white
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
