//
//  MainTabBarController.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/2/7.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.设置 tabbar 外观
        setupTabBarAppearance()
        
        //2.初始化所有子页面
        setupViewControllers()
    }
    
    private func setupTabBarAppearance() {
        //设置背景颜色为白色
        tabBar.backgroundColor = .white
        //设置选中图标的颜色
        tabBar.tintColor = .xhsRed
        //设置未选中的图标颜色
        tabBar.unselectedItemTintColor = .gray
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        tabBar.layer.shadowRadius = 3;
    }
    
    private func setupViewControllers() {
        let homeVC = createNavController(viewController: HomeViewController(),
                                         title:"首页")
        let shoppingVC = createNavController(viewController: UIViewController(),
                                             title: "购物")
        //发布页面比较特殊，先占个位
        let postVC = createNavController(viewController: UIViewController(),
                                         title: "")
        let messageVC = createNavController(viewController: UIViewController(),
                                            title: "消息")
        let meVC = createNavController(viewController: UIViewController(),
                                       title: "我")
        
        //交给 TabBarCcontroller 管理
        viewControllers = [homeVC, shoppingVC, postVC, messageVC, meVC]
    }
    
    private func createNavController(viewController: UIViewController,
                                    title: String) -> UINavigationController {
        viewController.tabBarItem.title = title
        viewController.view.backgroundColor = .systemBackground
        
        //返回一个包装了该页面的导航控制器
        return UINavigationController(rootViewController: viewController)
    }
}

