//
//  HomeTableViewCell.swift
//  PositiveEnergy
//
//  Created by jintelai on 2018/7/20.
//  Copyright © 2018年 jintelai. All rights reserved.
//

import UIKit
import SDCycleScrollView

protocol HomeMiddleDelegate: class {
    func middleBtnItemClick(text: String)
}
protocol HomeScrollerDelegate: class {
    func searchBtnClick()
}

class HomeScrollerCell: UITableViewCell,SDCycleScrollViewDelegate {
    private var adView: SDCycleScrollView?
    weak var delegate: HomeScrollerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createUI()
    }
    
    private func createUI() {
        if adView == nil {
            let frame = CGRect(x: 0, y: 0, width: width, height: height)
            adView = SDCycleScrollView(frame: frame, delegate: self
                , placeholderImage: UIImage(named: "no_course_img"))
            adView!.pageDotColor = UIColor.white
            adView!.currentPageDotColor = UIColor.createColor(colorStr: Config.Color.main.rawValue)
            adView!.pageControlAliment = .init(rawValue: 1)
            adView!.autoScrollTimeInterval = 5
            adView!.backgroundColor = UIColor.white
            adView!.placeholderImage = UIImage(named: "ad_placeholder")
            contentView.addSubview(adView!)
            adView!.addSubview(createSearchBtn())
        }
    }
    
    private func createSearchBtn() -> UIButton {
        let searchBtn = UIButton(type: .custom)
        searchBtn.frame = CGRect(x: width - 60, y: 165, width: 44, height: 44)
        searchBtn.setImage(UIImage(named: "search_icon"), for: .normal)
        searchBtn.addTarget(self, action: #selector(searchBtnClick), for: .touchUpInside)
        searchBtn.rounderRectRadius(cornerRadius: 22)
        searchBtn.backgroundColor = UIColor.white
        return searchBtn
    }
    
    @objc func searchBtnClick() {
        delegate?.searchBtnClick()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        adView?.frame = frame
    }
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
    }
}

class HomeMiddleCell: UITableViewCell {
    
    @IBOutlet weak var middleView: UIView!
    weak var delegate: HomeMiddleDelegate?
    let titleArray = ["学习竞赛","党员教育","干部学习","陕西e支部","第一书记","政策法规库","数字图书馆","更多..."]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createUI()
    }
    
    private func createUI() {
        let merginWidth = (screen_width - 208) / 5
        var x: CGFloat = merginWidth
        var y: CGFloat = merginWidth
        let imageArray = ["icon_bisai","icon_edu","icon_study","icon_zhibu","icon_leader","icon_falu","icon_book","icon_more"]
        var i = 0
        imageArray.forEach { (img) in
            x = merginWidth + (merginWidth + 52) * CGFloat((i % 4))
            y = merginWidth + (merginWidth + 52) * CGFloat((i / 4))
            
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: x, y: y, width: 52, height: 52)
            btn.setImage(UIImage(named: img), for: .normal)
            btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
            btn.tag = 100 + i
            middleView.addSubview(btn)
            
            let label = UILabel(frame: CGRect(x: x, y: btn.frame.maxY, width: 52, height: 20))
            label.text = titleArray[i]
            label.textAlignment = .center
            label.sizeToFit()
            label.center.x = btn.center.x
            label.font = UIFont.systemFont(ofSize: UIFont.font14)
            label.textColor = UIColor.createColor(colorStr: "#333333")
            middleView.addSubview(label)
            i = i + 1
        }
    }
    
    @objc func btnClick(btn: UIButton) {
        let tag = btn.tag - 100
        delegate?.middleBtnItemClick(text: titleArray[tag])
    }
}
