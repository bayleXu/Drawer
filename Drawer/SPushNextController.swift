//
//  SPushNextController.swift
//  Drawer
//
//  Created by 叶子 on 2018/6/12.
//  Copyright © 2018年 swift. All rights reserved.
//

import UIKit

class SPushNextController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }
    
    // 显示导航栏
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
