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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLoopImg()
    }
    
    private func getLoopImg() {
        HomeRequest.getLoopImg(code: "000001") { [weak self] (result) in
            guard let _ = result else { return }
            self?.loopImgArray = result!
            self?.tab.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }
    func middleBtnItemClick(text: String) {
        
    }
    
    func searchBtnClick() {
        
    }
}

extension HomeViewController: UITableViewProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "middel_cell") as! HomeMiddleCell
            cell.selectionStyle = .none
            cell.delegate = self
            return cell
        } else {
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeAdcell") as! HomeScrollerCell
        cell.delegate = self
        cell.configData(model: loopImgArray)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            let merginWidth = (screen_width - 208) / 5
            return merginWidth + (merginWidth + 52) * 2
        }
        return 219
    }
}
