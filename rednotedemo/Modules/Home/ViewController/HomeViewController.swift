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
        viewModel.requestData() //和兴：让 VM 去干活
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
        //一旦数据好了，就刷新 UI
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: -数据源
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    //告诉系统显示多少个笔记
    func collectionView(_ collection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
        //return viewModel.numberOfItems
    }
    
    //询问每一个格子的具体内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        return cell
    }
}

// 瀑布流布局代理：在这里决定高度
extension HomeViewController: WaterfallLayoutDelegate {
    func waterfallLayout(_ layout: WaterfallLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.random(in: 180...320)
    }
}
