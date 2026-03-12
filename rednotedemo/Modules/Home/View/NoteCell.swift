//
//  NoteCell.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/2/8.
//

import Foundation
import SnapKit

class NoteCell: UICollectionViewCell {
    // MARK: -UI 组件
    //1.封面图
    private let coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray6
        iv.layer.cornerRadius = 8
        iv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return iv
    }()
    
    //2.笔记标题
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2 //最多显示两行
        return label
    }()
    
    //3.作者头像
    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .xhsRed
        iv.layer.cornerRadius = 10
        return iv
    }()
    
    //4.作者名字
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    //5.点赞按钮
    private let likeButton: UIButton = {
        let btn = UIButton(type: .custom)
        let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .regular)
        btn.setImage(UIImage(systemName: "heart", withConfiguration: config), for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.tintColor = .darkGray
        btn.titleLabel?.font = .systemFont(ofSize: 11)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        return btn
    }()
    
    //MARK: -初始化
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -布局
    private func setupUI() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(coverImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(likeButton)
        
        coverImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            // 注意：这里不要写死高度，高度由 WaterfallLayout 计算出来的 Cell 宽度和图片比例决定
            // 我们只需要让它撑满顶部即可
        }
        
        // 2. 标题：【关键修改】必须连接在封面图下方
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(coverImageView.snp.bottom).offset(8) // 连接处！
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8) // 撑起整个 Cell 的底部
            make.size.equalTo(20)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.left.equalTo(avatarImageView.snp.right).offset(6)
            make.width.lessThanOrEqualTo(60) // 限制宽度防止太长
        }
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.right.equalToSuperview().offset(-8)
        }
    }
    
    //MARK: -绑定数据
    func configure(with post:PostItem) {
        titleLabel.text = post.title
        authorLabel.text = post.author.nickname
        likeButton.setTitle("\(post.likeCount)", for: .normal)
        
        //网络请求来的
        let imageURL = "http://127.0.0.1:8000" + post.coverImage
        coverImageView.loadImage(from: imageURL)

        // 如果有作者头像也加载
        if let avatar = post.author.avatar {
            let avatarURL = "http://127.0.0.1:8000" + avatar
            avatarImageView.loadImage(from: avatarURL)
        }
    }
}
