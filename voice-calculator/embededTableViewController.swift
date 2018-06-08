//
//  UITableViewController.swift
//  voice-calculator
//
//  Created by lz on 6/8/18.
//  Copyright © 2018 Zhuang Liu. All rights reserved.
//

import UIKit

class embededTableViewController: UITableViewController {
    @IBOutlet weak var lightModeLabel: UILabel!
    @IBOutlet weak var versionNumberLabel: UILabel!
    @IBOutlet weak var lightModeCell: UIView!
    @IBOutlet weak var rateUsCell: UIView!
    @IBOutlet weak var versionNumberCell: UIView!
    @IBOutlet weak var feedbackCell: UIView!
    @IBOutlet weak var shareCell: UIView!
    @IBOutlet weak var lightModeSwitch: UISwitch!
    @IBOutlet weak var rateUsButton: UIButton!
    
    @IBAction func lightModeSwitched(_ sender: UISwitch) {
        if  SettingsService.sharedService.lightModeStatus {
            SettingsService.sharedService.lightModeStatus = false
            SettingsService.sharedService.backgroundColor = UIColor.black
            self.view.backgroundColor = SettingsService.sharedService.backgroundColor
            rateUsCell.backgroundColor = SettingsService.sharedService.backgroundColor
            lightModeCell.backgroundColor = SettingsService.sharedService.backgroundColor
            versionNumberCell.backgroundColor = SettingsService.sharedService.backgroundColor
            feedbackCell.backgroundColor = SettingsService.sharedService.backgroundColor
            shareCell.backgroundColor = SettingsService.sharedService.backgroundColor
            SettingsService.sharedService.textColor = UIColor.white
            lightModeLabel.textColor = SettingsService.sharedService.textColor
            versionNumberLabel.textColor = SettingsService.sharedService.textColor
            rateUsButton.titleLabel?.textColor = SettingsService.sharedService.textColor
        } else {
            SettingsService.sharedService.lightModeStatus = true
            SettingsService.sharedService.backgroundColor = UIColor.white
            self.view.backgroundColor = SettingsService.sharedService.backgroundColor
            rateUsCell.backgroundColor = SettingsService.sharedService.backgroundColor
            lightModeCell.backgroundColor = SettingsService.sharedService.backgroundColor
            versionNumberCell.backgroundColor = SettingsService.sharedService.backgroundColor
            feedbackCell.backgroundColor = SettingsService.sharedService.backgroundColor
            shareCell.backgroundColor = SettingsService.sharedService.backgroundColor
            SettingsService.sharedService.textColor = UIColor.black
            lightModeLabel.textColor = SettingsService.sharedService.textColor
            versionNumberLabel.textColor = SettingsService.sharedService.textColor
            rateUsButton.titleLabel?.textColor = SettingsService.sharedService.textColor
        }
    }
    
    
    @IBAction func rateUsPressed(_ sender: UIButton) {
        gotoAppStore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = SettingsService.sharedService.backgroundColor
        lightModeLabel.textColor = SettingsService.sharedService.textColor
        versionNumberLabel.textColor = SettingsService.sharedService.textColor
        lightModeCell.backgroundColor = SettingsService.sharedService.backgroundColor
        versionNumberCell.backgroundColor = SettingsService.sharedService.backgroundColor
        feedbackCell.backgroundColor = SettingsService.sharedService.backgroundColor
        shareCell.backgroundColor = SettingsService.sharedService.backgroundColor
        lightModeSwitch.isOn = SettingsService.sharedService.lightModeStatus
        rateUsButton.titleLabel?.textColor = SettingsService.sharedService.textColor
        rateUsCell.backgroundColor = SettingsService.sharedService.backgroundColor
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        print("embeded showed")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gotoAppStore() {
        let urlString = "itms-apps://itunes.apple.com/cn/app/%E4%BF%9D%E9%99%A9%E5%B8%88-%E8%AE%A1%E5%88%92%E4%B9%A6-%E5%B1%95%E4%B8%9A%E7%AD%BE%E5%8D%95%E5%B9%B3%E5%8F%B0/id981360164?l=en&mt=8"
        if let url = URL(string: urlString) {
            
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
