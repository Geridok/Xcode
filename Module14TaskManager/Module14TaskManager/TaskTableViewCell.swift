//
//  TaskTableViewCell.swift
//  Module14TaskManager
//
//  Created by Vladimir Mustafin on 28.05.2021.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    
    @IBOutlet weak var taskNamelabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    static var identifier = "TaskTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib {

        return UINib(nibName: "TaskTableViewCell", bundle: nil)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(taskName: String,date: String){
        taskNamelabel.text = taskName
        dateLabel.text = date
    }

}
