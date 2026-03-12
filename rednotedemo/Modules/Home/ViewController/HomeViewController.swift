//
//  HomeViewController.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/2/7.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    //1.定义顶部导航栏组件和依赖
    private let viewModel = HomeViewModel()
    private let headerView  = HomeHeaderView()
    
    //2.定义瀑布流列表
    private lazy var collectionView: UICollectionView = {
        //后续定义更复杂瀑布流
        let layout = WaterfallLayout()
        layout.delegate = self
        
        let cv = UICollectionView(frame: .zero,collectionViewLayout: layout)
        cv.backgroundColor = .systemGray6 //浅灰色背景
        cv.dataSource = self //谁来提供数据
        cv.delegate = self //自己来处理交互
        //自定义的 NoteCell
        cv.register(NoteCell.self, forCellWithReuseIdentifier: "NoteCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel() //核心：绑定
        viewModel.fetchPosts() //让 VM 去干活
    }
    
    private func setupUI() {
        //添加顶部组件
        view.addSubview(headerView)
        //添加列表组件
        view.addSubview(collectionView)
        
        headerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        //列表撑满剩下所有空间
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        // 配置数据更新的回调
        // 当 VM 里的数据请求成功并处理完后，会触发这里的代码
        viewModel.onDataUpdated = { [weak self] in
            // 回到主线程（VM 已经处理了主线程分发，这里直接调 UI 即可）
            print("收到 VM 通知：数据已更新，开始刷新 UI")
            self?.collectionView.reloadData()
            
            // 如果有下拉刷新控件，可以在这里停止动画
            // self?.refreshControl.endRefreshing()
        }
        
        // 配置错误处理的回调
        // 当网络断了或者解析出错时，VM 会把错误信息传出来
        viewModel.onError = { [weak self] errorMessage in
            print("收到 VM 通知：发生错误 -> \(errorMessage)")
            
            // 这里可以弹出一个提示框告知用户
            self?.showErrorBanner(message: errorMessage)
        }
    }
    
    private func showErrorBanner(message: String) {
        // 实际开发中，这里会写一个弹窗 UI
        print("界面展示错误提示: \(message)")
    }
}

// MARK: -数据源
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    //告诉系统显示多少个笔记
    func collectionView(_ collection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    //询问每一个格子的具体内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath) as! NoteCell
        
        let post = viewModel.post(at: indexPath.item)
        
        cell.configure(with: post)
        
        return cell
    }
}

// 瀑布流布局代理：在这里决定高度
extension HomeViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.random(in: 180...320)
    }
}
