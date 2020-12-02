//
//  ListViewController.swift
//  nikki
//
//  Created by 阿迦井翔 on 2020/05/02.
//  Copyright © 2020 kakeru.geek. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var diaryArray = [Diary]()
    @IBOutlet weak var diaryTableView: UITableView!
    
    var passedCalendar: String?
    var forDate: String?
    var uuid: Int!
    let diary = Diary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diaryTableView.dataSource = self
        diaryTableView.delegate = self
        
        self.diaryTableView.reloadData()
        //戻るボタン
        self.navigationItem.leftItemsSupplementBackButton = true
        // TableViewの不要な線を消す
        diaryTableView.tableFooterView = UIView()
        //タイトル設定
        self.navigationItem.title = forDate
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDiaryDate()
        self.diaryTableView.reloadData()
        
    }
    // TableViewの個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaryArray.count
    }
    // TableViewの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath)
        // 表示内容を決める
        let object = diaryArray[indexPath.row]
        cell.textLabel?.text = object.title
        cell.tag = indexPath.row
        return cell
    }
    // 日記の削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            deleteDiary(at: indexPath.row)
            diaryArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }
    
    // 日記をrealmから削除
    func deleteDiary(at index: Int) {
        let realm = try! Realm()
        let uuid = diaryArray[index].id
        let results = realm.objects(Diary.self).filter("id == '\(uuid)'")
        
        try! realm.write {
            realm.delete(results)
        }
    } 
    
    func getDiaryDate() {
        // タップしたDateのスケジュール取得
        let realm = try! Realm()
        //        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let result = realm.objects(Diary.self)
        diaryArray.removeAll()
        for ev in result {
            if forDate == ev.keyDate {
                diaryArray.append(ev)
                diaryTableView.reloadData()
            }
        }
        diaryTableView.reloadData()
    }
    
    // 値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //日記追加画面へ
        if segue.identifier == "addDiary" {
            let diaryViewController = segue.destination as! DiaryViewController
            diaryViewController.passedDate = passedCalendar
            
            diaryViewController.forDiary = forDate
        }
        //詳細画面へ
        if segue.identifier == "toDetail" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.selectedDiary = diaryArray[diaryTableView.tag].title
        }
        
    }
    // 日記追加画面へ
    @IBAction func addDiary() {
        performSegue(withIdentifier: "addDiary", sender: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.tag = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        
    }
    
}
