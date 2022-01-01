//
//  CryptoDetailViewTableViewCell.swift
//  CryptoTracker
//
//  Created by Shamim Rahman on 12/10/21.
//
// CryptoViewController unique table View cell to show the crypto details

import UIKit

class CryptoDetailViewTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var totalMarketLabel: UILabel!
    @IBOutlet weak var lastUpDateLabel: UILabel!
    @IBOutlet weak var low24Label: UILabel!
    @IBOutlet weak var high24Label: UILabel!
    @IBOutlet weak var totalVolumeLabel: UILabel!
    
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
