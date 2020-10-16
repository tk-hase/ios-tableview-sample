//
//  TableViewCell.swift
//  TableViewSample
//
//  Created by Tomoki Hasegawa on 2020/10/05.
//  Copyright © 2020 Tomoki Hasegawa. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
