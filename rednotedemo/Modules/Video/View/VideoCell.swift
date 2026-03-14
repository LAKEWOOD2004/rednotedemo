//
//  VideoCell.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/3/14.
//

import Foundation
import UIKit
import SnapKit

class VideoCell: UICollectionViewCell {
    static let identifier = "VideoCell"
    
    // MARK: -UI Components
    
    // 播放器视图的承载容器
    let playerContainer = UIView()
    
    // 封面图： 视频加载完成前显示
    let coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .black
        return iv
    }()
    
    //侧边栏
    let sideStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        return stack
    }()
    
    //底部文字区： 作者标题
    let bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        return stack
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -Setup
    
    private func setupUI() {
        //严格遵循层级：底层Player -> 中层 Cover —> 顶层 UI
        contentView.addSubview(playerContainer)
        contentView.addSubview(coverImageView)
        
        contentView.addSubview(sideStackView)
        contentView.addSubview(bottomStackView)
        
        bottomStackView.addArrangedSubview(authorLabel)
        bottomStackView.addArrangedSubview(titleLabel)
        
        playerContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        coverImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 侧边栏：固定在右侧，底部留出 TabBar 的安全区域
        sideStackView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-100) // 这里的 offset 需根据你的 TabBar 高度调整
            make.width.equalTo(60)
        }
        
        // 底部文字：左侧对齐，右侧避开 sideStackView
        bottomStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalTo(sideStackView.snp.left).offset(-16)
            make.bottom.equalToSuperview().offset(-40) // 避开安全区
        }
    }
    
    // MARK: - 核心：数据绑定与复用清理
        
        func configure(with model: VideoModel) {
            authorLabel.text = "@\(model.author.name)"
            titleLabel.text = model.title
            // 封面图建议：coverImageView.sd_setImage(with: URL(string: model.coverUrl))
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
            // 💡 极其重要：移除播放器 View，防止画面在 Cell 间乱串
            playerContainer.subviews.forEach { $0.removeFromSuperview() }
            coverImageView.isHidden = false
        }
}
