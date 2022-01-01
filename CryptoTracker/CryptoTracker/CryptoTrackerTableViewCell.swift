//
//  CryptoTrackerTableViewCell.swift
//  CryptoTracker
//
//  Created by Shamim Rahman on 12/10/21.
// Unique table View cell to show the crypto details

import UIKit

class CryptoTrackerTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
