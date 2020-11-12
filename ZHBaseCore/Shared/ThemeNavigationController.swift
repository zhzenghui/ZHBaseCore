//
//  ThemeNavigationController.swift
//  ruby-china-ios
//
//  Created by 柯磊 on 16/8/22.
//  Copyright © 2016年 ruby-china. All rights reserved.
//

import UIKit

class ThemeNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationBar.bottomBorder = true
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        // 修复 WebView 中点击“上传图片”按钮不能正常打开“照片图库”问题
        if presentedViewController != nil {
            super.dismiss(animated: flag, completion: completion)
        }
    }
}
