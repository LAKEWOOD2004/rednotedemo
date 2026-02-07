//
//  HomeViewController.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/2/7.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    //1.定义顶部导航栏组件
    private let headerView  = HomeHeaderView()
    
    //2.定义瀑布流列表
    private lazy var collectionView: UICollectionView = {
        //后续定义更复杂瀑布流
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        //设置左右边距
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let cv = UICollectionView(frame: .zero,collectionViewLayout: layout)
        cv.backgroundColor = .systemGray6 //浅灰色背景
        cv.dataSource = self //谁来提供数据
        cv.delegate = self //自己来处理交互
        //注册一种格子类型，之后写自定义的 NoteCell
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "NoteCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //隐藏系统默认的导航栏
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupUI()
    }
        
    private func setupUI() {
        //添加顶部组件
        view.addSubview(headerView)
        //添加列表组件
        view.addSubview(collectionView)
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(44)
        }
        
        //列表撑满剩下所有空间
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //告诉系统显示多少个笔记
    func collectionView(_ collection: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 //暂时写死 20 个
    }
    
    //询问每一个格子的具体内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCell", for: indexPath)
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 8
        return cell
    }
    
    //询问每一个格子的长款尺寸
    func collectionView(_collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 30) / 2 // 屏幕宽度扣除间距除以2
        return CGSize(width: width, height: width * 1.3) // 暂时设个 1.3 倍的高
    }
}
