//
//  HomeViewController.swift
//  PositiveEnergy
//
//  Created by jintelai on 2018/7/20.
//  Copyright © 2018年 jintelai. All rights reserved.
//

import UIKit



class HomeViewController: BaseViewController,HomeMiddleDelegate,HomeScrollerDelegate {
    @IBOutlet weak var tab: UITableView!
    var sourceArray = [String]()
    private var loopImgArray = [HomeLoopImg]()
    private var tabSourceArray = [HomeNewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTab()
        getLoopImg()
        
        tab.register(UINib(nibName: "HomeNewsBigCell", bundle: nil), forCellReuseIdentifier: "homeBigCell")
        tab.register(UINib(nibName: "HomeNewsNormalCell", bundle: nil), forCellReuseIdentifier: "homeNormalCell")
    }
    
    private func configTab() {
        tab.refresh(header: { [weak self] in
            self?.getLoopImg()
        }) {
            
        }
        tab.mj_footer.isHidden = true
    }
    
    private func getLoopImg() {
        HomeRequest.getLoopImg(code: "000001") { [weak self] (result) in
            guard let _ = result else { return }
            self?.loopImgArray = result!
            self?.tab.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
        
        HomeRequest.getTopNews(code: "000001") { [weak self] (result) in
            guard let _ = result else { return }
            self?.tabSourceArray = result!
            self?.tab.endResh()
            self?.tab.reloadData()
        }
    }
    
    func middleBtnItemClick(text: String) {
        
    }
    
    func searchBtnClick() {
        
    }
}

extension HomeViewController: UITableViewProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2 + tabSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeAdcell") as! HomeScrollerCell
            cell.delegate = self
            cell.configData(model: loopImgArray)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "middel_cell") as! HomeMiddleCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeBigCell") as! HomeBigCell
            cell.selectionStyle = .none
            cell.configData(model: tabSourceArray[indexPath.row - 2])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeNormalCell") as! HomeNormalCell
            cell.selectionStyle = .none
            cell.configData(model: tabSourceArray[indexPath.row - 2])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 219
        case 1:
            let merginWidth = (screen_width - 208) / 5
            return merginWidth + (merginWidth + 52) * 2 + 8
        case 2:
            return 280
        default:
            return 118
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 { return }
        if tabSourceArray.count < indexPath.row - 2 { return }
        let id = tabSourceArray[indexPath.row - 2].contentId
        let sb = UIStoryboard(name: "Propaganda", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "web_vc") as! NewsDetailViewController
        vc.id = id ?? 01
        navigationController?.push(vc: vc)
    }
}
