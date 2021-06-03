//
//  HeaderTableViewCell.swift
//  Module14TaskManager
//
//  Created by Vladimir Mustafin on 02.06.2021.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {


    static var identifier = "HeaderTableViewCell"
    
    @IBOutlet weak var unCompleteTaskLabel: UILabel!
    @IBOutlet weak var completeTaskLabel: UILabel!
    @IBOutlet weak var overDueTaskLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {

        return UINib(nibName: "HeaderTableViewCell", bundle: nil)
    }
    
    func configure(unCompleteTaskAmount:UInt, completeTaskAmount:UInt, overDueTaskAmount:UInt){
        unCompleteTaskLabel.text = String(unCompleteTaskAmount)
        unCompleteTaskLabel.text = String(unCompleteTaskAmount)
        unCompleteTaskLabel.text = String(unCompleteTaskAmount)
    }

}
