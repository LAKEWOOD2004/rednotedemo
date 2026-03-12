//
//  PostModel.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/2/8.
//

import Foundation

//对应后端的整体返回结构
struct PostListResponse: Codable {
    let status: String
    let message: String
    let data: [PostItem]
    let total: Int?
}

//对应后端的单条帖子数据
struct PostItem: Codable {
    let id: Int
    let authorId: Int
    let title: String
    let content: String?
    let coverImage: String
    let images: [String]?
    let likeCount: Int
    let commentCount: Int?
    let createdAt: String
    let updatedAt: String
    let author: PostAuthor
    let isLiked: Bool
    
    // 映射：把 Swift 的驼峰命名和后端的下划线命名对应起来
    enum CodingKeys: String, CodingKey {
        case id, title, content, images, author
        case authorId = "author_id"
        case coverImage = "cover_image"
        case likeCount = "like_count"
        case commentCount = "comment_count"
        case isLiked = "is_liked"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

//作者
struct PostAuthor: Codable {       
    let id: Int
    let username: String
    let nickname: String
    let avatar: String?
}
