//
//  uiListCollectionViewCell.swift
//  interviewTestUiKit
//
//  Created by Nandhu Selvan on 31/08/24.
//

import UIKit

class uiListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var uiImage: UIImageView!
    static let identifier = "uiListCollectionViewCell" 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    public func configure(with image:UIImage){
        uiImage.image = image
    }
    static func nib() -> UINib{
        return UINib(nibName : "uiListCollectionViewCell",bundle: nil )
    }
}
