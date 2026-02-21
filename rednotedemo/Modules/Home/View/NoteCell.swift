//
//  NoteCell.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/2/8.
//

import Foundation
import SnapKit

class NoteCell: UICollectionViewCell {
    //先简单定义一个背景色
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    required init?(coder: NSCoder) { fatalError() }
}
