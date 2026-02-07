//
//  HomeHeaderView.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/2/7.
//

import Foundation
import SnapKit

class HomeHeaderView: UIView {
    //1.左侧头像图标（先用一个圆形背景模拟）
    private let avatarView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    //2.中间的频道切换容器 （为了演示，我们先放一个 StackView）
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.spacing = 20
        return sv
    }()
    
    //3.频道按钮
    private let followBtn = UIButton()
    private let discoverBtn = UIButton()
    private let nearbyBtn =  UIButton()
    
    //4.右侧搜索图标
    private let searchBtn: UIButton = {
        let btn = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        btn.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: config), for: .normal)
        btn.tintColor = .black
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(avatarView)
        addSubview(stackView)
        addSubview(searchBtn)
        
        //设置频道按钮
        setupChannelButton(followBtn, title: "关注")
        setupChannelButton(discoverBtn, title: "发现", isSelected: true)
        setupChannelButton(nearbyBtn, title: "附近")
        
        stackView.addArrangedSubview(followBtn)
        stackView.addArrangedSubview(discoverBtn)
        stackView.addArrangedSubview(nearbyBtn)
        
        //SnapKit 布局部分
        
        avatarView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        searchBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
        }
    }
    
    private func setupChannelButton(_ btn: UIButton, title: String, isSelected: Bool = false) {
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(isSelected ? .black : .gray, for: .normal)
        btn.titleLabel?.font = isSelected ? .systemFont(ofSize: 17, weight: .bold): .systemFont(ofSize: 16)
    }
}
