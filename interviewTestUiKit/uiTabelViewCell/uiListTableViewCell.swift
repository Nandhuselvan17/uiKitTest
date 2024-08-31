//
//  uiListTableViewCell.swift
//  interviewTestUiKit
//
//  Created by Nandhu Selvan on 31/08/24.
//

import UIKit

class uiListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var uiImg: UIImageView!
    @IBOutlet weak var hLb: UILabel!
    @IBOutlet weak var contLb: UILabel!
    
    static let identifier = "uiListTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.layer.cornerRadius = 10
        uiImg.layer.cornerRadius = 6
        
    }
    public func configure(with image:UIImage){
        uiImg.image = image
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib{
        return UINib(nibName : "uiListTableViewCell",bundle: nil )
    }
    
}
