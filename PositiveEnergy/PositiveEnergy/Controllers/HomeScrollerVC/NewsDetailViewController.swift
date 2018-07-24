//
//  NewsDetailViewController.swift
//  PositiveEnergy
//
//  Created by jintelai on 2018/7/24.
//  Copyright © 2018年 jintelai. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class NewsDetailViewController: BaseViewController {
    
    var id: Int!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var webView: UIWebView! {
        didSet {
            webView.backgroundColor = UIColor.createColor(colorStr: "#f1f1f1")
            webView.scrollView.showsHorizontalScrollIndicator = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "新闻详情"
        getData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func getData() {
        let hud = Message.showProgressView(text: "请稍后....", view: view)
        let provider = MoyaProvider<Service>()
        _ = provider.rx.request(.newsDetail(code: "\(id ?? 01)"))
            .mapModel(ResultModel<NewsDetail>.self).subscribe { [weak self] result in
                hud?.isHidden = true
                switch result {
                case .success(let obj):
                    self?.createData(model: obj.data)
                case .error(let error):
                    print(error)
                }
        }
    }
    
    private func createData(model: NewsDetail?) {
        titleLabel.text = model?.contentTitle
        source.text = model?.source
        time.text = model?.createTime
        
        webView.loadHTMLString(model?.contentText ?? "", baseURL: nil)
    }
}
