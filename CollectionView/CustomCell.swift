//
//  CustomCell.swift
//  CollectionView
//
//  Created by Umang Kedan on 11/12/23.
//

import UIKit

class CustomCell: UICollectionViewCell {

    @IBOutlet weak var imageView1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCellData(image : UIImage){
        self.imageView1.image = image
    }
}
