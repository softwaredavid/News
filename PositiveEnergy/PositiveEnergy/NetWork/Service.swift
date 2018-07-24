//
//  Service.swift
//  BaseProject
//
//  Created by jintelai on 2018/6/29.
//  Copyright © 2018年 jintelai. All rights reserved.
//
import Moya

enum Service {
    case homeMenu([String: Any])
    case homeSubMenu(String)
}

extension Service: TargetType {
    
    var baseURL: URL {
        return Config().server.remoteURL
    }
    
    var path: String {
        switch self {
        case .homeMenu(_):
            return "queryMenuFirstWebInfo"
        case .homeSubMenu(_):
            return "querySonMenuByFirstMenuCode"
        }
    }
    
    var method: Method {
        switch self {
        case .homeMenu(_):
            return .post
        case .homeSubMenu(_):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .homeMenu(let para):
            return .requestParameters(parameters: para, encoding: JSONEncoding.default)
        case .homeSubMenu(let para):
            return .requestParameters(parameters: ["menuCode":para], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type":"application/json"]
    }
}
