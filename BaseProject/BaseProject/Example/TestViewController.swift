//
//  TestViewController.swift
//  BaseProject
//
//  Created by jintelai on 2018/7/16.
//  Copyright © 2018年 jintelai. All rights reserved.
//

import UIKit
import RxSwift

class TestViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let ober = Observable.of("").map{ Int($0) }
        ober.skip(2).subscribe { (evernt) in
            
        }
        Observable.from([""])
        Observable<Int>.interval(1, scheduler: MainScheduler.instance).subscribe { (event) in
            
        }
        dispatchMain()
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
