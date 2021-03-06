//
//  HomeMode.swift
//  PositiveEnergy
//
//  Created by jintelai on 2018/7/24.
//  Copyright © 2018年 jintelai. All rights reserved.
//
import Moya
import RxSwift

struct HomeRequest {
    static func getLoopImg(code: String,success: @escaping ([HomeLoopImg]?) -> ()) {
        let provider = MoyaProvider<Service>()
       _ = provider.rx.request(.getLoopImg(code: code))
            .mapModel(ResultModel<[HomeLoopImg]>.self).subscribe { result in
                switch result {
                case .success(let obj):
                    success(obj.data)
                case .error(let error):
                    print(error)
                }
            }
    }
    
    static func getTopNews(code: String,success: @escaping ([HomeNewsModel]?) -> ()) {
        let provider = MoyaProvider<Service>()
        _ = provider.rx.request(.getNewsTop(code: code, days: 10))
            .mapModel(ResultModel<[HomeNewsModel]>.self).subscribe { result in
                switch result {
                case .success(let obj):
                    success(obj.data)
                case .error(let error):
                    print(error)
                }
        }
    }
}

struct HomeMenuModel: Codable {
    var menuName: String?
    var menuId: Int?
}
struct HomeLoopImg: Codable {
    var icon: String?
    var contentTitle: String?
    var contentId: Int?
}
struct HomeNewsModel: Codable {
    var icon: String?
    var contentTitle: String
    var contentId: Int?
    var addTime: TimeInterval?
    var isTop: Int?
    
    var createTime: String? {
        let date = Date(timeIntervalSince1970: addTime ?? 0)
        let formate = DateFormatter()
        formate.dateFormat = "YYYY-MM-dd"
        return "\(formate.date(from: "\(date)") ?? Date())".subString(start: 0, length: 10)
    }
}

struct NewsDetail: Codable {
    var source: String?
    var addTime: TimeInterval?
    var contentTitle: String?
    var contentText: String?
    
    var createTime: String? {
        let date = Date(timeIntervalSince1970: addTime ?? 0)
        let formate = DateFormatter()
        formate.dateFormat = "YYYY-MM-dd"
        return "\(formate.date(from: "\(date)") ?? Date())".subString(start: 0, length: 10)
    }
}
