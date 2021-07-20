//
//  LazyGifView.swift
//  GitSearch
//
//  Created by Abhinav Mandloi on 12/07/21.
//

import Foundation
import UIKit

class LazyGifView: UIImageView {
    
    private let gifCache = NSCache<AnyObject, UIImage>()
    
    func loadGifImage(fromURL gifURL: URL, placeHolderImage: String)
    {
        self.image = UIImage(named: placeHolderImage)
        
        if let cachedGif = self.gifCache.object(forKey: gifURL as AnyObject)
        {
            debugPrint("gif loaded from cache for =\(gifURL)")
            self.image = cachedGif
            return
        }
        
        DispatchQueue.global().async {
            [weak self] in
            
            if let gifData = try? Data(contentsOf: gifURL)
            {
                debugPrint("gif downloaded from server...")
                if let gif = UIImage(data: gifData)
                {
                    DispatchQueue.main.async {
                        if let strongSelf = self {
                            strongSelf.gifCache.setObject(gif, forKey: gifURL as AnyObject)
                            strongSelf.image = gif
                        }
                    }
                }
            }
        }
    }
}
