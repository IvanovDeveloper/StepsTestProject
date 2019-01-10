//
//  SPCommentTableViewCell.swift
//  TestProject
//
//  Created by Ivanov Developer on 1/10/19.
//  Copyright © 2019 Andrew Ivanov. All rights reserved.
//

import UIKit

class SPCommentTableViewCell: SPBaseTableViewCell, IdentifiedTableViewCell {
    
    static var identifier = "SPCommentTableViewCellID"
    
    // MARK: IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    // MARK: Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setDefaultValues()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setDefaultValues()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Configurations
    
    /// Set default data for UI.
    fileprivate func setDefaultValues() {
        nameLabel.text = nil
        emailLabel.text = nil
        bodyLabel.text = nil
    }
}
