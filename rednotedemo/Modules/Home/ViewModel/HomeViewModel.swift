//
//  HomeViewModel.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/2/8.
//

import Foundation

class HomeViewModel {
    //1.数据源
    private var posts: [PostItem] = []
    
    //MARK: - 分页加载相关（上滑加载更多的核心控制）
    private var currentPage = 1
    private let pageSize = 20
    private(set) var isLoading = false
    private(set) var hasMore = true
    
    //回调闭包
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    //MARK: -配置
    let baseURL = "http://127.0.0.1:8000"

    
    //3.提供给外部的数据接口
    var numberOfItems: Int {
        return posts.count
    }
    
    func post(at index: Int) -> PostItem {
        return posts[index]
    }
    
    //MARK: - 网络请求动作
    
    //初始刷新（用户下拉刷新，或者第一次进页面时候调用）
    func fetchPosts() {
        //把状态初始化
        currentPage = 1
        hasMore = true
        //调用真正的请求
        loadData(page: currentPage)
    }
    
    //加载下一页（划到底部时候调用）
    func loadMorePosts() {
        //如果在加载
        guard !isLoading && hasMore else {return}
        //去拉下一页
        loadData(page: currentPage + 1)
    }
    
    private func loadData(page: Int) {
        //标记状态
        isLoading = true
        
        //1.准备网址
        let urlString = "\(baseURL)/posts/list?page=\(page)&size=\(pageSize)"
        
        // 确保合法
        guard let url = URL(string: urlString) else {return}
        
        //2.派发网络请求任务
        //URLSession.shared.dataTask 会在子线程（后台）下载数据
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {return}
            
            self.isLoading = false
            
            if let error = error {
                DispatchQueue.main.async {
                    self.onError?("请求失败: \(error.localizedDescription)")
                    return
                }
            }
            
            guard let data = data else { return }
            
            do {
                let responseData = try JSONDecoder().decode(PostListResponse.self, from: data)
                
                //判断请求状态
                if responseData.status == "success" {
                    let newPosts = responseData.data
                    
                    if newPosts.isEmpty {
                        self.hasMore = false
                    } else {
                        //如果是第一页说明是重新刷新
                        if page == 1 {
                            self.posts = newPosts
                        } else {
                            //如果是后面的页数，直接拼到旧数组的尾部
                            self.posts.append(contentsOf: newPosts)
                        }
                        
                        self.currentPage = page
                        
                        //如果问后端要 10 条，只给了 5条，说明到底了
                        if newPosts.count < self.pageSize {
                            self.hasMore = false
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.onDataUpdated?()
                    }
                }
            } catch {
                //如果和后端返回的不对
                DispatchQueue.main.async {
                    self.onError?("解析错误")
                    print(error)
                }
            }
        }.resume()
    }
}
