//
//  SearchGif.swift
//  GitSearch
//
//  Created by Abhinav Mandloi on 12/07/21.
//

import Foundation

class SearchGifService: GifService {
    
    var gifSearchText: String = ""
    var _url: String = GIF_URLs.SEARCH_GIF_URL
    
    init(gifSearchText: String) {
        self.gifSearchText = gifSearchText
        self._url = GIF_URLs.SEARCH_GIF_URL + self.gifSearchText
    }

}
