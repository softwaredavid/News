//
//  Config.swift
//  BaseProject
//
//  Created by jintelai on 2018/6/29.
//  Copyright © 2018年 jintelai. All rights reserved.
//

import UIKit

public let screen_width = UIScreen.main.bounds.width
public let screen_height = UIScreen.main.bounds.height

typealias void_func_void = () -> ()
typealias UITableViewProtocol = UITableViewDataSource & UITableViewDelegate

struct Config {
    
    struct umShare {
        static let shareKey = "5b57e6daf29d986b5f0000cc"
        static let wexin = ""
        static let weixinScret = ""
        static let qq = "FP13QN36kufvyHIv" // key
        // id 1107203246
    }
    
    var server: Server {
        return .distribute
    }
    
    enum Color: String {
        case main = "#891D22"
        case title = "#FFFFFF"
        case subTitle
        case bgColor
    }
    
}
