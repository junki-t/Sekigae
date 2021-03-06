//
//  SekiHaitiViewController.swift
//  席替え
//
//  Created by Tomatsu Junki on 2016/01/30.
//  Copyright © 2016年 Tomatsu Junki. All rights reserved.
//

import UIKit

class SekiHaitiViewController: UIViewController {

    @IBOutlet var nextBtn: UIButton!
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // ボタンの画像を設定します。
        //
        for i in 0 ..< AppData.CountLimit {
            for v in self.view.subviews {
                if let btn = v as? UIButton {
                    let t : String = btn.currentTitle!
                    let b : Bool = (t == String(format: "Button%d", (i + 1)))
                    if b {
                        if btn.allTargets().count == 0 {
                            btn.addTarget(self, action: #selector(SekiHaitiViewController.buttontap(_:)), forControlEvents: .TouchUpInside)
                            var numstr = btn.currentTitle!
                            numstr = numstr.stringByReplacingOccurrencesOfString("Button", withString: "")
                            let num = Int(numstr)! - 1
                            if AppData.sekistatus.count < AppData.CountLimit {
                                AppData.sekistatus.append(false)
                                if (num + 1) <= AppData.maxcount {
                                    AppData.sekistatus[num] = true
                                    btn.setImage(UIImage(named: "desk.png"), forState: .Normal)
                                }else{
                                    AppData.sekistatus[num] = false
                                    btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
                                }
                            } else {
                                if AppData.sekistatus[num] {
                                    btn.setImage(UIImage(named: "desk.png"), forState: .Normal)
                                } else {
                                    btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
                                }
                            }
                        }
                        break;
                    }
                }
            }
        }
        nextBtn.setTitleColor(UIColor(red: 0.66, green: 0.66, blue: 0.66, alpha: 1.0), forState: .Disabled)
        checkbtnandupdlbl()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //
    // 切り替え
    //
    @IBAction func buttontap(sender: AnyObject){
        let btn = (sender as! UIButton)
        var numstr = btn.currentTitle!
        numstr = numstr.stringByReplacingOccurrencesOfString("Button", withString: "")
        let num = Int(numstr)! - 1
        if AppData.sekistatus[num] {
            AppData.sekistatus[num] = false
            btn.setImage(UIImage(named: "nodesk.png"), forState: .Normal)
            checkbtnandupdlbl()
        } else {
            AppData.sekistatus[num] = true
            btn.setImage(UIImage(named: "desk.png"), forState: .Normal)
            checkbtnandupdlbl()
        }
    }
    
    //
    // 数があっているかを確認する関数。
    //
    func checkbtnandupdlbl(){
        if AppData.maxcount == 0 {
            AppData.loadData()
        }
        var truecnt: Int = 0
        for b in AppData.sekistatus {
            if b {
                truecnt += 1
            }
        }
        if truecnt == AppData.maxcount {
            nextBtn.enabled = true
        }else{
            nextBtn.enabled = false
        }
        label.text = String(truecnt) + "/" + String(AppData.maxcount)
    }

}
