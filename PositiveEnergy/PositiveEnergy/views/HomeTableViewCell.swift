//
//  HomeTableViewCell.swift
//  PositiveEnergy
//
//  Created by jintelai on 2018/7/20.
//  Copyright © 2018年 jintelai. All rights reserved.
//

import UIKit
import SDCycleScrollView

class HomeScrollerCell: UITableViewCell,SDCycleScrollViewDelegate {
   private var adView: SDCycleScrollView?
    
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
            contentView.addSubview(adView!)
            contentView.backgroundColor = UIColor.red
        }
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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
