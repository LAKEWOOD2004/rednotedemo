//
//  UIImageView+Network.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/3/12.
//

import Foundation
import UIKit

//给 UIImageView写一个扩展，异步加载网络图片并缓存
extension UIImageView {
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        //使用 URLSession异步下载图片
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                let data = data,
                error == nil,
                let image = UIImage(data: data) else {
                    return
            }
            
            //回到主线程更新 UI
            DispatchQueue.main.async {
                UIView.transition(with: self,
                                  duration: 0.3,
                                  options: .transitionCrossDissolve,
                                  animations: { self.image = image },
                                  completion: nil)
            }
        }.resume()
    }
}
