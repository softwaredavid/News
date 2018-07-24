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
    case getNewsSub(String)
    case getNewsTop(code:String, days: Int)
    case getLoopImg(code: String)
    case newsDetail(code: String)
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
        case .getNewsSub(_):
            return "queryContentIsTopWebInfo"
        case .getNewsTop(_):
            return "queryContentByMenuCodeAllContent"
        case .getLoopImg(_):
            return "queryContentIsSlideWebInfo"
        case .newsDetail(_):
            return "queryContentDetailByContentId"
        }
    }
    
    var method: Method {
        switch self {
        case .homeMenu(_):
            return .post
        case .homeSubMenu(_):
            return .post
        case .getNewsSub(_):
            return .post
        case .getNewsTop(_, _):
            return .post
        case .getLoopImg(_):
            return .post
        case .newsDetail(_):
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
        case .getNewsSub(let para):
            return .requestParameters(parameters: ["menuCode":para], encoding: JSONEncoding.default)
        case .getNewsTop(let code, let days):
            return .requestParameters(parameters: ["menuCode":code,"num":days], encoding: JSONEncoding.default)
        case .getLoopImg(let code):
            return .requestParameters(parameters: ["menuCode":code], encoding: JSONEncoding.default)
        case .newsDetail(let code):
            return .requestParameters(parameters: ["contentId":code], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type":"application/json"]
    }
}
