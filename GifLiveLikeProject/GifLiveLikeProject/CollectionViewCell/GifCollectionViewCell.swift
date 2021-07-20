//
//  GifCollectionViewCell.swift
//  GitSearch
//
//  Created by Abhinav Mandloi on 11/07/21.
//

import UIKit

class GifCollectionViewCell: UICollectionViewCell {
    
    // MARK:- IBOutlets
    @IBOutlet weak var imageGifView: LazyGifView!
    @IBOutlet weak var gifNameLabel: UILabel!
    
    override class func awakeFromNib() {

    }
    
}
