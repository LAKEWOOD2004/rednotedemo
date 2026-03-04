//
//  VideoViewController.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/2/23.
//

import Foundation
import UIKit
import SnapKit

class VideoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        let label = UILabel()
        label.text = "短视频模块"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
