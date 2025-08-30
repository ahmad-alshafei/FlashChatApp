//
//  MessageViewCell.swift
//  Flash Chat
//
//  Created by AhmadALshafei on 8/22/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit

class MessageViewCell: UITableViewCell {
    @IBOutlet weak var MessageBubble: UIView!
    
    @IBOutlet weak var labelMessage: UILabel!
    
    @IBOutlet weak var labelNameSender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MessageBubble.layer.cornerRadius = MessageBubble.frame.size.height/5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
