//
//  DetailViewController.swift
//  nikki
//
//  Created by 阿迦井翔 on 2020/05/06.
//  Copyright © 2020 kakeru.geek. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedDiary: String!
    
    @IBOutlet var diaryTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diaryTextView.text = selectedDiary
        //戻るボタン
        self.navigationItem.leftItemsSupplementBackButton = true
        //タイトル設定
        self.navigationItem.title = "Detail"
    }
    
    
    
}
