//
//  SHomeNextController.swift
//  Drawer
//
//  Created by 叶子 on 2018/6/12.
//  Copyright © 2018年 swift. All rights reserved.
//

import UIKit

class SHomeNextController: UIViewController {
    
    lazy var pushBtn : UIButton = {
        $0.frame = CGRect.init(x: 50, y: kNavBAR_H! + 80, width: 100, height: 40)
        $0.setTitle("push", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(pushAction(sender:)), for: .touchUpInside)
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        view.addSubview(pushBtn)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func pushAction(sender: UIButton) {
        
        let vc = SHomeController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
