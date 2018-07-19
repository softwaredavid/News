//
//  BaseTabBarViewController.swift
//  PartOfXib
//
//  Created by Apple on 2017/6/26.
//  Copyright © 2017年 WangDaoLeTu. All rights reserved.
//

import UIKit

struct TabBarPara {
    var title: String
    var image: String
    var selectImage: String
    var vcName: String
}
class BaseTabBarViewController: UITabBarController,UITabBarControllerDelegate {

    private var subViewControllerCount: Int {
        let count = viewControllers != nil ? viewControllers!.count : 0
        return count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.delegate = self
        /*delegate = tabBarVCDelegate
        panGesture.addTarget(self, action: #selector(handlePan(panGesture:)))
        view.addGestureRecognizer(panGesture)*/
        
        selectedIndex = 0
        view.tintColor = UIColor(red: 186/255, green: 30/255, blue: 39/255, alpha: 1)
        addController()
    }
    private func addController() {
        
        addChildViewController(para: TabBarPara(title: "宣传",
                                                image: "home",
                                                selectImage: "home_select",
                                                vcName: "Propaganda"))
        
        addChildViewController(para: TabBarPara(title: "教育",
                                                image: "edu",
                                                selectImage: "edu_select",
                                                vcName: "Education"))
        
        addChildViewController(para: TabBarPara(title: "管理",
                                                image: "man",
                                                selectImage: "man_select",
                                                vcName: "Manager"))
        
        addChildViewController(para: TabBarPara(title: "服务",
                                                image: "ser",
                                                selectImage: "ser_select",
                                                vcName: "Service"))
    }
    private func addChildViewController(para: TabBarPara) {
        
        let sb = UIStoryboard(name: para.vcName, bundle: nil)
        let vc = sb.instantiateInitialViewController()
        guard let v = vc else { return }
        
        v.tabBarItem.image = UIImage(named: para.image)
        v.tabBarItem.selectedImage = UIImage(named: para.selectImage)
        v.tabBarItem.title = para.title
        let nav = BaseNavigationViewController(rootViewController: v)
        addChildViewController(nav)
    }
    
    func handlePan(panGesture: UIPanGestureRecognizer) {
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
}
