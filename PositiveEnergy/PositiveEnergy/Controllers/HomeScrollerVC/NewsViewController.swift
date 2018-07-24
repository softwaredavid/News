//
//  ViewController2.swift
//  PositiveEnergy
//
//  Created by jintelai on 2018/7/20.
//  Copyright © 2018年 jintelai. All rights reserved.
//

import UIKit
import Moya
import RxSwift

class NewsViewController: BaseViewController {
    
    var menuId: Int = 00001
    private var disposeBag = DisposeBag()
    fileprivate var tabHeaderView: ScrollerTitleView?
    
    @IBOutlet weak var tab: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTab()
        configTabHeaderView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    private func configTab() {
        tab.refresh(header: {
           refreshData()
        }) {
            
        }
    }
    private func getMeunData() {
        let id = String(format: "%06d", menuId)
        let provider = MoyaProvider<Service>()
        provider.rx.request(.homeSubMenu(id))
            .mapModel(ResultModel<[HomeMenuModel]>.self).subscribe { [weak self] result in
                switch result {
                case .success(let obj):
                    self?.tab.endResh()
                    self?.configTabHeaderData(modelArray: obj.data)
                case .error(let error):
                    print(error)
                }
            }.disposed(by: disposeBag)
    }
    
    private func configTabHeaderView() {
        if tabHeaderView != nil { return }
        tabHeaderView = ScrollerTitleView(frame: CGRect(x: 0, y: 88, width: view.width, height: 33))
        tabHeaderView!.showsVerticalScrollIndicator = false
        tabHeaderView!.showsHorizontalScrollIndicator = false
        tabHeaderView!.setup()
        tab.tableHeaderView = tabHeaderView
    }
    
    private func configTabHeaderData(modelArray: [HomeMenuModel]?) {
        guard let _ = modelArray else { return }
        tabHeaderView?.subviews.forEach({ $0.removeFromSuperview() })
        let btns = createButton(modelArray: modelArray)!
        btns.forEach { tabHeaderView?.addSubview($0) }
        tabHeaderView?.titlesBtn = btns
    }
    
    private func createButton(modelArray: [HomeMenuModel]?) -> [UIButton]? {
        guard let _ = modelArray else { return nil }
        var btns = [UIButton]()
        var btnName: String?
        for i in 0..<modelArray!.count {
            let btn = UIButton(type: .custom)
            btn.addTarget(self, action: #selector(titleButtonClick(btn:)), for: .touchUpInside)
            btn.setTitleColor(UIColor.createColor(colorStr: "#333333"), for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor.createColor(colorStr: Config.Color.main.rawValue), for: .selected)
            btnName = modelArray![i].menuName
            btn.setTitle(btnName, for: .normal)
            btns.append(btn)
        }
        layoutSubView(btns: btns)
        return btns
    }
    
    private func layoutSubView(btns: [UIButton]) {
        for btn in btns {
            let font: UIFont = btn.titleLabel?.font ?? UIFont.systemFont(ofSize: 14)
            let rect = btn.titleLabel?.text?.boundingRect(with: CGSize(width: 1000, height: 33), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context:nil)
            btn.frame = CGRect(x: 0, y: 0, width: rect?.size.width ?? 40, height: 30)
        }
    }
    
    @objc func titleButtonClick(btn: UIButton) {
    
    }
    
    func refreshData() {
        getMeunData()
    }
}
