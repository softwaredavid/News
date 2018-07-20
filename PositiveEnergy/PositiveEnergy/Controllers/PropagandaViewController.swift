//
//  PropagandaViewController.swift
//  PositiveEnergy
//
//  Created by jintelai on 2018/7/19.
//  Copyright © 2018年 jintelai. All rights reserved.
//

import UIKit

class PropagandaViewController: BaseViewController {
    
    var titleScrollerView: ScrollerTitleView?
    var titleBtns: [UIButton] {
        return titleScrollerView?.titlesBtn ?? [UIButton(),UIButton()]
    }
    var markeLine: UIView {
        return titleScrollerView?.markeLine ?? UIView()
    }
    lazy var contentScrollerView: UIScrollView = {
        let y = contentScrolerY()
        let height = contentScrollerHeight()
        let contentScrollerView = UIScrollView(frame: CGRect(x: 0, y: y, width: view.width, height: height))
        contentScrollerView.delegate = self
        contentScrollerView.bounces = false
        contentScrollerView.showsHorizontalScrollIndicator = false
        contentScrollerView.scrollsToTop = false
        contentScrollerView.contentSize = CGSize(width: 1000, height: 100)
        return contentScrollerView
    }()
    var viewControllers: [UIViewController]?
    var selectIndex: Int = 0
    
    var contentViewController: UIViewController? {
        return viewControllers?[selectIndex]
    }
    var content: UIView? {
        return contentViewController?.view
    }
    
    var minEndDraggingVelocity: CGFloat = 2
    
    private var shouldHiddenTitleScrollerView = false
    private var scrollingAfterTitleButton = false
    
    func hiddenTitleScrollerView(hiden: Bool) {
        shouldHiddenTitleScrollerView = hiden
        if titleScrollerView != nil && hiden {
            
            titleScrollerView?.removeFromSuperview()
            titleScrollerView = nil
            
        } else if !hiden && titleScrollerView == nil {
            
            setUpTitleScrollerView()
            
        }
        
    }
    
    private func setSelectIndex(selectIndex: Int) {
        guard let _ = viewControllers else { return }
        if selectIndex > viewControllers!.count { return }
        
        contentScrollerView.scrollRectToVisible(frameForContentControllerAtIndex(index: selectIndex), animated: true)
        self.selectIndex = selectIndex
    }
    
    private func setViewControllers(viewControllers: [UIViewController]) {
        if !checkViewControllers(viewControllers: viewControllers) { return }
        
        let hide = shouldHiddenTitleScrollerView
        if !hide {
            hiddenTitleScrollerView(hiden: false)
        }
        
        hiddenViewControllers()
        self.viewControllers = viewControllers
    }
    
    private func contentScrolerY() -> CGFloat {
        guard let _ = titleScrollerView else { return 0 }
        var y = topLayoutGuide.length
        y = titleScrollerView!.frame.maxY
        return y
    }
    
    private func contentScrollerHeight() -> CGFloat {
        return view.height - topLayoutGuide.length - contentScrolerY()
    }
    
    private func checkViewControllers(viewControllers: [UIViewController]) -> Bool {
        if viewControllers.count < 0 { return false }
        for vc in viewControllers {
            if vc.isMember(of: UIViewController.self) {
                return false
            }
        }
        return true
    }
    
    private func setUpTitleScrollerView() {
        guard let _ = viewControllers else { return }
        var btns = [UIButton]()
        var i = 0
        var maxWidth: CGFloat = 0
        for _ in viewControllers! {
            let btn = UIButton(type: .custom)
            btn.addTarget(self, action: #selector(titleButtonClick(btn:)), for: .touchUpInside)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setTitle("首页", for: .normal)
            btn.sizeToFit()
            maxWidth = max(maxWidth, btn.width)
            i += 1
            
            btns.append(btn)
        }
        
        let minWidth: CGFloat = (view.width - CGFloat(btns.count) * btn_space) / CGFloat(btns.count)
        maxWidth = max(maxWidth, minWidth)
        btns.forEach { $0.frame = CGRect(x: 0, y: 0, width: maxWidth, height: $0.height) }
        
        titleScrollerView = ScrollerTitleView(frame: CGRect(x: 0, y: 88, width: view.width, height: 0))
        titleScrollerView?.titlesBtn = btns
        titleScrollerView?.height = titleScrollerView!.contentSize.height
        titleScrollerView?.setup()
        view.addSubview(titleScrollerView!)
    }
    
    @objc func titleButtonClick(btn: UIButton) {
        if titleBtns.contains(btn) {
            if let indexs = titleBtns.index(where: { $0 == btn }) {
                let titleRect = CGRect(x: btn.x - btn_space * 0.5,
                                       y: btn.y,
                                       width: btn.width + btn_space,
                                       height: btn.height)
                titleScrollerView?.scrollRectToVisible(titleRect, animated: true)
                contentScrollerView.scrollRectToVisible(frameForContentControllerAtIndex(index: indexs), animated: true)
                selectIndex = indexs
                scrollingAfterTitleButton = true
            }
        }
    }
    
    private func frameForContentControllerAtIndex(index: Int) -> CGRect {
        return CGRect(x: contentScrollerView.width * CGFloat(index),
                      y: 90,
                      width: contentScrollerView.width,
                      height: contentScrollerView.height - 90)
    }
    
    private func hiddenViewControllers() {
        guard let _ = viewControllers else { return }
        for vc in viewControllers! {
            vc.willMove(toParentViewController: nil)
            
            vc.view.removeFromSuperview()
            
            vc.removeFromParentViewController()
        }
        selectIndex = 0
    }
    
    private func disPlayVc() {
        guard let _ = viewControllers else { return }
        var i = 0
        for vc in viewControllers! {
            
            addChildViewController(vc)
            vc.view.frame = frameForContentControllerAtIndex(index: i)
            contentScrollerView.addSubview(vc.view)
            vc.didMove(toParentViewController: self)
            i += 1
            
        }
        
        contentScrollerView.contentSize = CGSize(width: view.width * CGFloat(i), height: contentScrollerHeight())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentScrollerView)
        
        viewControllers = [UIViewController]()
        
        let sb = UIStoryboard(name: "Propaganda", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "home_vc")
        viewControllers?.append(vc)
        
        
        viewControllers?.append(ViewController2())
        setViewControllers(viewControllers: viewControllers!)
        
        disPlayVc()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !shouldHiddenTitleScrollerView && titleScrollerView != nil {
            setUpTitleScrollerView()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationController?.isNavigationBarHidden = true
        
        titleScrollerView?.updateContentSize()
        
        let contentWidth = view.width
        
        titleScrollerView?.frame = CGRect(x: 0, y: 88, width: contentWidth, height: titleScrollerView?.contentSize.height ?? 0)
        
        let btns = titleBtns
        var maxWidth: CGFloat = 0
        for btn in btns {
            let font: UIFont = btn.titleLabel?.font ?? UIFont.systemFont(ofSize: 14)
            let rect = btn.titleLabel?.text?.boundingRect(with: CGSize(width: 1000, height: titleScrollerView?.height ?? 30), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context:nil)
            maxWidth = max(maxWidth, rect?.size.width ?? 0)
        }
        let minWidth = (contentWidth - CGFloat(btns.count) * btn_space) / CGFloat(btns.count)
        maxWidth = max(maxWidth, minWidth)
        
        var x = 0.5 * btn_space
        
        for btn in btns {
            btn.frame = CGRect(x: 0, y: 0, width: maxWidth, height: btn.height)
            x += maxWidth + btn_space
        }
        
        markeLine.frame = CGRect(x: (maxWidth + btn_space) * CGFloat(selectIndex),
                                 y: markeLine.frame.minY,
                                 width: maxWidth + btn_space,
                                 height: markeLine.height)
        titleScrollerView?.scrollRectToVisible(markeLine.frame, animated: false)
    }
}
extension PropagandaViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == contentScrollerView {
            let btn = titleBtns[selectIndex]
            var markeLine_x = btn.frame.minX - btn_space * 0.5
            let markeLine_y = markeLine.frame.minY
            let markeLine_width = btn.width + btn_space
            let markeLine_height = markeLine.height
            
            let contentOffset_x = scrollView.contentOffset.x
            let contentView_width = view.width
            
            let contentViewMoveLength = CGFloat(selectIndex) * contentView_width - contentOffset_x
            let markeLineMoveLength = contentViewMoveLength / contentView_width * markeLine_width
            markeLine_x -= markeLineMoveLength
            
            markeLine.frame = CGRect(x: markeLine_x, y: markeLine_y, width: markeLine_width, height: markeLine_height)
            
            if !scrollingAfterTitleButton {
                titleScrollerView?.scrollRectToVisible(markeLine.frame, animated: false)
            }
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == contentScrollerView {
            
            let x = targetContentOffset.pointee.x
            let contentview_width = view.width
            
            let contentViewMoveLength = x - CGFloat(selectIndex) * contentview_width
            
            if contentViewMoveLength < -contentview_width * 0.5 {
                selectIndex -= 1
            } else if contentViewMoveLength > contentview_width * 0.5 {
                selectIndex += 1
            }
            
            if abs(velocity.x) >= minEndDraggingVelocity {
                
                targetContentOffset.pointee.x = CGFloat(selectIndex) * contentview_width
                
            } else {
                targetContentOffset.pointee.x = scrollView.contentOffset.x
                scrollView.setContentOffset(CGPoint(x: CGFloat(selectIndex) * contentview_width, y: scrollView.contentOffset.y), animated: true)
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        scrollingAfterTitleButton = false
    }
}
