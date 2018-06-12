//
//  SPresentController.swift
//  Drawer
//
//  Created by 叶子 on 2018/6/12.
//  Copyright © 2018年 swift. All rights reserved.
//

import UIKit

class SPresentController: UIViewController {
    
    lazy var dismissBtn : UIButton = {
        $0.frame = CGRect.init(x: kScreenWidth/2-50, y: kScreenHeight/2-20, width: 100, height: 40)
        $0.setTitle("dismiss", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(dismissAction(sender:)), for: .touchUpInside)
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(dismissBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissAction(sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
