//
//  ViewController.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/2/6.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置窗口背景颜色 🌈
        view.backgroundColor = .systemPink
        
        // 添加文本
        let label = UILabel()
        label.text = "Hello world! 👋"
        label.textColor = .white
        label.textAlignment = .center
        label.frame = view.bounds

        // 添加到视图
        view.addSubview(label)
    }


}

