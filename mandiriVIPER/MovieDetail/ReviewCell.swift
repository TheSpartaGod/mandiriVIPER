//
//  ReviewCell.swift
//  mandiriVIPER
//
//  Created by Aqshal Wibisono on 11/04/22.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var reviewNameLabel: UILabel!
    @IBOutlet weak var reviewContentLabel: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
