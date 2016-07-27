//
//  ListImages.swift
//  Shop2
//
//  Created by HuuLuong on 7/27/16.
//  Copyright © 2016 CanhDang. All rights reserved.
//

import UIKit

class ListImages: UIViewController {
    
    @IBAction func onTouch(sender: AnyObject) {
        switch (sender.tag) {
        case 101: pushView(0)
        case 102: pushView(1)
        case 103: pushView(2)
        case 104: pushView(3)
        case 105: pushView(4)
        default:break
        }
    }

    func pushView(index: Int) {
        let listView = self.storyboard?.instantiateViewControllerWithIdentifier("ViewScroll") as? ViewScroll
        listView?.currentPage = index 
        self.navigationController?.pushViewController(listView!, animated: true)
    }

}
