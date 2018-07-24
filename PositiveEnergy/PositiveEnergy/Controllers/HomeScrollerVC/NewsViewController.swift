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
    private var loopImgArray = [HomeLoopImg]()
    private var tabSourceArray = [HomeNewsModel]()
    
    @IBOutlet weak var tab: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTab()
        configTabHeaderView()
        
        tab.register(UINib(nibName: "HomeNewsBigCell", bundle: nil), forCellReuseIdentifier: "homeBigSubCell")
        tab.register(UINib(nibName: "HomeNewsNormalCell", bundle: nil), forCellReuseIdentifier: "homeNormalSubCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    private func configTab() {
        tab.delegate = self
        tab.dataSource = self
        tab.refresh(header: { [weak self] in
           self?.refreshData()
        }) {
            
        }
    }
    
    private func getLoopImg() {
        let id = String(format: "%06d", menuId)
        HomeRequest.getLoopImg(code: id) { [weak self] (result) in
            guard let _ = result else { return }
            self?.loopImgArray = result!
            self?.tab.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
        
        HomeRequest.getTopNews(code: id) { [weak self] (result) in
            guard let _ = result else { return }
            self?.tabSourceArray = result!
            self?.tab.reloadData()
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
        tabHeaderView = ScrollerTitleView(frame: CGRect(x: 0, y: 0, width: view.width, height: 33))
        tabHeaderView!.showsVerticalScrollIndicator = false
        tabHeaderView!.showsHorizontalScrollIndicator = false
        tabHeaderView!.setup()
        view.addSubview(tabHeaderView!)
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
        getLoopImg()
    }
}

extension NewsViewController: UITableViewProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1 + tabSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "home_img_loop") as! HomeImgLoopCell
            cell.configData(model: loopImgArray)
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeBigSubCell") as! HomeBigCell
            cell.selectionStyle = .none
            cell.configData(model: tabSourceArray[indexPath.row - 1])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeNormalSubCell") as! HomeNormalCell
            cell.selectionStyle = .none
            cell.configData(model: tabSourceArray[indexPath.row - 1])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 219
        case 1:
            return 220
        default:
            return 118
        }
    }
}
