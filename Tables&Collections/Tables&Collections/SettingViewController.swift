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

struct Setting {
    let title: String
    let icon: UIImage
}

struct SettingsSection {
    let title: String
    let settings: [Setting]
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
    static func getSettingSection()-> [SettingsSection]{
        return[
            SettingsSection(title: "General", settings: [
                Setting(title: "General", icon: UIImage(imageLiteralResourceName: "setting.png")),
                Setting(title: "Accessibility", icon: UIImage(imageLiteralResourceName: "setting.png")),
                Setting(title: "Privacy", icon: UIImage(imageLiteralResourceName: "setting.png"))]),
            SettingsSection(title: "Security", settings:  [Setting(title: "General", icon: UIImage(imageLiteralResourceName: "setting.png"))]),
            SettingsSection(title: "Other", settings: [
            Setting(title: "Maps", icon: UIImage(imageLiteralResourceName: "setting.png")),
            Setting(title: "Safari", icon: UIImage(imageLiteralResourceName: "setting.png")),
            Setting(title: "News", icon: UIImage(imageLiteralResourceName: "setting.png")),
            Setting(title: "Heart", icon: UIImage(imageLiteralResourceName: "setting.png")),
            Setting(title: "General", icon: UIImage(imageLiteralResourceName: "setting.png")),
            Setting(title: "Accessibility", icon: UIImage(imageLiteralResourceName: "setting.png")),
            Setting(title: "Maps", icon: UIImage(imageLiteralResourceName: "setting.png")),
            Setting(title: "Safari", icon: UIImage(imageLiteralResourceName: "setting.png")),
            Setting(title: "News", icon: UIImage(imageLiteralResourceName: "setting.png")),
            Setting(title: "Heart", icon: UIImage(imageLiteralResourceName: "setting.png")),
            Setting(title: "General", icon: UIImage(imageLiteralResourceName: "setting.png")),
            Setting(title: "Accessibility", icon: UIImage(imageLiteralResourceName: "setting.png"))])
        ]
    }
}

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    let settingParagraphs = SettingParagraphFabric.getSettingSection()
        
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
        cell.nameLabel.text = settingParagraphs[section].title
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingParagraphs[section].settings.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "  "
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "setCell") as! SettingTableViewCell
        
        cell.settingImageView?.image = settingParagraphs[indexPath.section].settings[indexPath.row].icon
        
        cell.nameLabel.text = settingParagraphs[indexPath.section].settings[indexPath.row].title
        
        return cell
    }
    
    
    
}
