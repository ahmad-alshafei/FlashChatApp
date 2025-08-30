//
//  MeCellTableViewCell.swift
//  Flash Chat
//
//  Created by AhmadALshafei on 8/24/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit

class MeCellTableViewCell: UITableViewCell {
    @IBOutlet weak var labelHeSender: UILabel!
    @IBOutlet weak var ViewHeBubble: UIView!
    
    @IBOutlet weak var labelHeBody: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ViewHeBubble.layer.cornerRadius = ViewHeBubble.frame.size.height/5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
