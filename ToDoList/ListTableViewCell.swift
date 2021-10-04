//
//  ListTableViewCell.swift
//  ToDoList
//
//  Created by John Linnehan on 10/4/21.
//

import UIKit

protocol ListTableViewCellDelegate: class {
    func checkBoxToggled(sender: ListTableViewCell)
}

class ListTableViewCell: UITableViewCell {
    
    weak var delegate: ListTableViewCellDelegate?

    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    @IBAction func checkToggled(_ sender: UIButton) {
        delegate?.checkBoxToggled(sender: self)
    }
    
    
    
}
