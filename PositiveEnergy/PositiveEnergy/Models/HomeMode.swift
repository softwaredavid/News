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
