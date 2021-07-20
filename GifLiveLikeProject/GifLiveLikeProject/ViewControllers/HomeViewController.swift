//
//  HomeViewController.swift
//  GifLiveLikeProject
//
//  Created by Abhinav Mandloi on 12/07/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK:- Constants
    private static let NIB_NAME = "GifCollectionViewCell"
    private static let CELL_IDENTIFIER = "Cell"
    private static let PLACEHOLDER_GIF_NAME = "giphy"
    
    // MARK:- IBOutlets
    var gifSearchBar: UISearchBar!
    var gifCollectionView: UICollectionView!
    
    var gif: [Gif]? = nil
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.createCollectionView()
        self.createSearchBar()
        self.registerNib()
        self.apiCall()
    }
    
    private func createCollectionView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let collectionViewFrame = CGRect(x: 0, y: 120, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 140)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        self.gifCollectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        self.gifCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: HomeViewController.CELL_IDENTIFIER)
        self.gifCollectionView?.backgroundColor = UIColor.white
        
        view.addSubview(self.gifCollectionView ?? UICollectionView())
        
        self.view = view
        
        self.gifCollectionView.delegate = self
        self.gifCollectionView.dataSource = self
    }
    
    private func createSearchBar() {
        
        self.gifSearchBar = UISearchBar(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.width, height: 100))
        
        self.gifSearchBar.searchBarStyle = UISearchBar.Style.default
        self.gifSearchBar.placeholder = "  Search..."
        self.gifSearchBar.sizeToFit()
        self.gifSearchBar.isTranslucent = false
        self.gifSearchBar.backgroundImage = UIImage()
        self.gifSearchBar.delegate = self
        navigationItem.titleView = gifSearchBar
        self.view.addSubview(self.gifSearchBar ?? UISearchBar())
        self.gifSearchBar.delegate = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       print("Print")
    }
    
    private func apiCall() {
        
        let gifTrendingService: TrendingGifService = TrendingGifService()
        
        gifTrendingService.getGifs(){ (_gifResponse) in
            
            if(_gifResponse?.gif != nil)
            {
                self.gif = _gifResponse?.gif
                
                DispatchQueue.main.async {
                    self.gifCollectionView.reloadData()
                }
            }
        }
    }
    
    //Move to contant
    private func registerNib() {
        let nib = UINib(nibName: HomeViewController.NIB_NAME, bundle: nil)
        self.self.gifCollectionView.register(nib, forCellWithReuseIdentifier: HomeViewController.CELL_IDENTIFIER)
    }
}

// MARK:- UISearchBarDelegate methods
extension HomeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let gifSearchText = self.self.gifSearchBar.text {
            
            timer?.invalidate()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                
                if gifSearchText == "".trimmingCharacters(in: .whitespaces) {
                    self.apiCall()
                }
                else {
                    
                    let gifSerachService: SearchGifService = SearchGifService(gifSearchText: gifSearchText)
                    gifSerachService.getGifs(){ (_gifResponse) in
                        
                        if(_gifResponse?.gif != nil)
                        {
                            self.gif = _gifResponse?.gif
                            
                            DispatchQueue.main.async {
                                self.self.gifCollectionView.reloadData()
                            }
                        }
                        else {
                            DispatchQueue.main.async {
                                let ac = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
                                ac.addAction(UIAlertAction(title: "OK", style: .default))
                                self.present(ac, animated: true)
                            }
                        }
                    }
                }
            })
        }
    }
}

// MARK:- UICollectionViewDataSource methods
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gif?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewController.CELL_IDENTIFIER, for: indexPath) as! GifCollectionViewCell
        
        let gif = self.gif?[indexPath.row]
        cell.gifNameLabel.text = self.gif?[indexPath.row].title
        let gifUrl = URL(string: "https://media3.giphy.com/media/LFDLUii8MvNmgimggQ/giphy.gif?cid=4116d493ey36nf0uehwsvozmkyi05mkgbfqpefdnp52c0v31&rid=giphy.gif&ct=g")!
        
        cell.imageGifView.loadGifImage(fromURL: gifUrl, placeHolderImage: HomeViewController.PLACEHOLDER_GIF_NAME)
        
        return cell
    }
}

// MARK:- UICollectionViewDelegateFlowLayout methods
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 15, height: 150)
    }
    
}

