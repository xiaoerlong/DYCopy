//
//  DYHistoryViewController.swift
//  DYCopy
//
//  Created by xiaoerlong on 2017/8/20.
//  Copyright © 2017年 xiaoerlong. All rights reserved.
//

import UIKit

let identifier = "HistoryCell"
let HistoryVideoIdentifier = "HistoryVideoCell"

class DYHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sliderView: UIView!

    var isShowLiving: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 100
        tableView.register(UINib.init(nibName: "DYHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)
        tableView.register(UINib.init(nibName: "DYHistoryVideoTableViewCell", bundle: nil), forCellReuseIdentifier: HistoryVideoIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //MARK:- Action
    @IBAction func tapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    // 点击直播按钮
    @IBAction func tapLivingButton(_ sender: UIButton) {
        tapButton(btn: sender)
    }
    
    // 点击视频按钮
    @IBAction func tapVideoButton(_ sender: UIButton) {
        tapButton(btn: sender)
    }
    
    // 点击按钮后调用
    func tapButton(btn: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { 
            self.sliderView.frame.origin.x = btn.frame.origin.x + 30
        }) { (completed) in
            self.isShowLiving = !self.isShowLiving
            self.tableView.scrollsToTop = true
            self.tableView.reloadData()
        }
    }

}

extension DYHistoryViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowLiving {
            return 10
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isShowLiving {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? DYHistoryTableViewCell else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryVideoIdentifier) as? DYHistoryVideoTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        return cell
    }
}
