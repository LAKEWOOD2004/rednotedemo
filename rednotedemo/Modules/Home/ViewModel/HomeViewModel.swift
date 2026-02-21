//
//  HomeViewModel.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/2/8.
//

import Foundation

class HomeViewModel {
    //1.数据源
    private var notes: [Note] = []
    
    //2.绑定闭包 ：当数据加载好了，通知 VC 刷新
    var reloadData: (() -> Void)?
    
    //3.提供给外部的数据接口
    var numberOfItems: Int {
        return notes.count
    }
    
    func getNote(at index: Int) -> Note {
        return notes[index]
    }
    
    //4.网络请求
    func requestData() {
        
    }
}
