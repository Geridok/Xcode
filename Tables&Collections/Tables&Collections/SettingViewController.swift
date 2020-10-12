//
//  SettingViewController.swift
//  Tables&Collections
//
//  Created by Vladimir Mustafin on 12.10.2020.
//  Copyright © 2020 Vladimir Mustafin. All rights reserved.
//

import UIKit

struct SettingParagraph{
    var settingsNames:[String] = []
    var settingsImages:[UIImage] = []
}

class SettingParagraphFabric{
    static func getAllSettingParagraph() -> [SettingParagraph]{
        return [
            SettingParagraph(settingsNames: ["General", "Accessibility","Privacy"],
                             //MARK: Here u can add image set for current paragraph of settings
                             settingsImages: ["setting.png"].map{UIImage(imageLiteralResourceName: $0)}),
            SettingParagraph(settingsNames: ["Passwords & Accounts"],
                             //MARK: Here u can add image set for current paragraph of settings
                             settingsImages: ["setting.png"].map{UIImage(imageLiteralResourceName: $0)}),
            SettingParagraph(settingsNames: ["Maps","Safari","News","Heart","General", "Accessibility","Privacy","Passwords & Accounts","Maps","Safari","News","Heart","General", "Accessibility","Privacy","Passwords & Accounts","Maps","Safari","News","Heart"],
                             //MARK: Here u can add image set for current paragraph of settings
                             settingsImages: ["setting.png"].map{UIImage(imageLiteralResourceName: $0)})
        ]
    }
}

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    let settingParagraphs = SettingParagraphFabric.getAllSettingParagraph()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension SettingViewController: UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingParagraphs.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Header") as! SettingTableViewCell
        cell.nameLabel.text = " "
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingParagraphs[section].settingsNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "  "
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setCell") as! SettingTableViewCell
        if(settingParagraphs[indexPath.section].settingsNames.count == settingParagraphs[indexPath.section].settingsImages.count){
            cell.settingImageView.image = settingParagraphs[indexPath.section].settingsImages[indexPath.row]
        }else{
            cell.settingImageView.image = settingParagraphs[indexPath.section].settingsImages[0]
        }
        
        cell.nameLabel.text = settingParagraphs[indexPath.section].settingsNames[indexPath.row]
        return cell
    }
    
    
    
}
