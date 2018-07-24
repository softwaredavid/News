//
//  BaseViewController.swift
//  PartOfXib
//
//  Created by Apple on 2017/6/26.
//  Copyright © 2017年 WangDaoLeTu. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.createColor(colorStr: "#f1f1f1")
//
//        let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
//        let nodata = NoDataView(frame: frame, superView: view, content: "暂无相关内容", img: "nodata_img")
//        view.addSubview(nodata)
    }
}

