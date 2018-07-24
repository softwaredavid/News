//
//  ScrollerTitleView.swift
//  PositiveEnergy
//
//  Created by jintelai on 2018/7/20.
//  Copyright © 2018年 jintelai. All rights reserved.
//

import UIKit

let btn_space: CGFloat = 20

class ScrollerTitleView: UIScrollView {
    
    var titlesBtn: [UIButton] = [UIButton]() {
        didSet {
            if titlesBtn.count != 0 && markeLine == nil {
                guard let btn = titlesBtn.first else { return }
                let y = btn.frame.maxY
                let width = btn.width
                markeLine = UIView(frame: CGRect(x: 0, y: y, width: width + btn_space, height: 1))
                markeLine!.backgroundColor = UIColor.clear
                addSubview(markeLine!)
            }
        }
    }
    var markeLine: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateFrame(btns: [UIButton]) {
        var x: CGFloat = 0.5 * btn_space
        btns.forEach {
            $0.frame = CGRect(x: x, y: 0, width: $0.width, height: $0.height)
            x += $0.width + btn_space
        }
        if titlesBtn.count != 0 {
            let lastButton = titlesBtn.last!
            contentSize = CGSize(width: lastButton.frame.maxX + btn_space, height: height)
        }
    }
    
    private func setTitles(btns: [UIButton]) {
        btns.forEach { addSubview($0) }
    }
    
    
    func setup() {
        bounces = false
        showsHorizontalScrollIndicator = false
        
        setTitles(btns: titlesBtn)
        updateContentSize()
    }
    
    func updateContentSize() {
        guard let lastFrame = titlesBtn.last?.frame else { return }
        guard let _ = markeLine else { return }
        let markeLineHeight = markeLine!.height
        let contentWidth = lastFrame.maxX + btn_space * 0.5
        let contentHeight = lastFrame.maxY + markeLineHeight
        contentSize = CGSize(width: contentWidth, height: contentHeight)
        
        let marekLineX = markeLine!.x
        let markeLineY = contentHeight - markeLineHeight
        let markeWidth = markeLine!.width
        markeLine!.frame = CGRect(x: marekLineX, y: markeLineY, width: markeWidth, height: markeLineHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateFrame(btns: titlesBtn)
    }
    
}
