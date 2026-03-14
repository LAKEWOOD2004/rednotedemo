//
//  VideoModel.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/3/14.
//

import Foundation

struct VideoModel: Codable {
    let id: String
    let url: String
    let coverUrl: String
    let title: String
    let author: VideoAuthor
    let likeCount: Int
    let commentCount: Int
    let shareCount: Int
    let duration: Double
    let width: Int
    let height: Int
    let creatTime: String
}

struct VideoAuthor: Codable {
    let id: String
    let name: String
    let avatarUrl: String
}
