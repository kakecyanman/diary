//
//  DiaryViewController.swift
//  nikki
//
//  Created by 阿迦井翔 on 2020/05/02.
//  Copyright © 2020 kakeru.geek. All rights reserved.
//

import UIKit
import RealmSwift

class DiaryViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var diaryTextView: UITextView!
    var date:NSDate = NSDate();
    
    var diary = ""
    
    var passedDate: String?
    var forDiary: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diaryTextView.delegate = self
        //戻るボタン
        self.navigationItem.leftItemsSupplementBackButton = true
        //タイトル設定
        self.navigationItem.title = "Diary"
        
    }
    
    @IBAction func addDiaryButton(_ sender: Any) {
        
        let form = DateFormatter()
        form.dateFormat = "yyyy/MM/dd"
        
        
        if (diaryTextView.text?.count)! > 0 && passedDate != nil {
            
            _ = Diary(value: ["title": diaryTextView.text!, "diaryDate": passedDate])
            
            // 保存する
            let realm = try! Realm()
            //let result = realm.objects(Diary.self).filter("uuidDiary")
            let uuid = NSUUID().uuidString
            let diary = Diary()
            diary.title = diaryTextView.text!
            diary.diaryDate = passedDate!
            diary.keyDate = forDiary!
            diary.id = uuid
            try! realm.write {
                realm.add(diary)
            }
            
            // ボタンを押したら戻る
            self.navigationController?.popViewController(animated: true)
            self .dismiss(animated: true, completion: nil)
        }
    }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        self.diaryTextView.resignFirstResponder()
        return true
    }
    
    
    
    
}
