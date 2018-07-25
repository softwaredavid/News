//
//  AppDelegate.swift
//  BaseProject
//
//  Created by jintelai on 2018/6/29.
//  Copyright © 2018年 jintelai. All rights reserved.
//     5b57e6daf29d986b5f0000cc 友盟

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        configWindow()
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    }
    
    private func configWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = BaseTabBarViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
    }
    
    private func configShare() {
        UMConfigure.initWithAppkey(Config.umShare.shareKey, channel: "App Store")
    }
    func configSharePlatform() {
        let UMManager = UMSocialManager.default()
        UMManager!.setPlaform(UMSocialPlatformType.wechatSession, appKey: Config.umShare.wexin, appSecret: Config.umShare.weixinScret, redirectURL: "http://mobile.umeng.com/social")
        UMManager!.setPlaform(UMSocialPlatformType.wechatTimeLine, appKey: Config.umShare.wexin, appSecret: Config.umShare.weixinScret, redirectURL: "http://mobile.umeng.com/social")
        UMManager!.setPlaform(UMSocialPlatformType.QQ, appKey: Config.umShare.qq, appSecret: nil, redirectURL: "http://mobile.umeng.com/social")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

