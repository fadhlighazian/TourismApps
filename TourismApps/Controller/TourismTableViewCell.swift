//
//  TourismTableViewCell.swift
//  TourismApps
//
//  Created by Ghazian Fadhli Fakhrusy on 29/11/20.
//

import UIKit

class TourismTableViewCell: UITableViewCell {

    @IBOutlet weak var tourismImage: UIImageView!
    @IBOutlet weak var tourismName: UILabel!
    @IBOutlet weak var tourismAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
