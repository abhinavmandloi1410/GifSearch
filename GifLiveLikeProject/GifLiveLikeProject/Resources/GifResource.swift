//
//  GifResource.swift
//  GifLiveLikeProject
//
//  Created by Abhinav Mandloi on 12/07/21.
//

import Foundation

protocol GifService {
    
    var _url: String  {
        get set
    }
    
    func getGifs(completionHandler: @escaping (GifResponse?) -> ())
}

extension GifService {
    
    func getGifs(completionHandler: @escaping (GifResponse?) -> ()) {
        
        guard let uRLString = _url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return  }
        
        let GifUrl = URL(string: uRLString)!
        
        URLSession.shared.dataTask(with: GifUrl) { (data, response, error) in
            
            if(error == nil && data != nil)
            {
                do {
                    let result = try JSONDecoder().decode(GifResponse.self, from: data!)
                    
                    completionHandler(result)
                    
                } catch let error {
                    debugPrint(error)
                }
            }
            
        }.resume()
        
    }
}
