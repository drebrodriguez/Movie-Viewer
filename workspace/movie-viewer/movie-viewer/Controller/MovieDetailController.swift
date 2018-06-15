//
//  ViewController.swift
//  movie-viewer
//
//  Created by Dreb Rodriguez on 14/06/2018.
//  Copyright © 2018 Dreb Rodriguez. All rights reserved.
//

import UIKit

class MovieDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Movie Viewer"
        
        setupCollectionViews()
        fetchMovie()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
        }) { (_) in
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        }
        
    }
    
    fileprivate func fetchMovie() {
        print("Fetching movies...")
        let urlString = "http://ec2-52-76-75-52.ap-southeast-1.compute.amazonaws.com/movie.json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, err) in
            if let err = err {
                print("Failed to fetch json from url:", err.localizedDescription)
                return
            }
            guard let jsonData = data else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let movie = try decoder.decode(Movie.self, from: jsonData)
                
                DispatchQueue.main.async {
                    self.movies.append(movie)
                    self.collectionView?.reloadData()
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr.localizedDescription)
            }
            
        }.resume()
    }
    
}

extension MovieDetailController {
    fileprivate func setupCollectionViews() {
        collectionView?.backgroundColor = UIColor.Custom.edgarWhite
        collectionView?.register(MovieDetailCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.isPagingEnabled = true
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieDetailCell
        
        cell.movie = self.movies[indexPath.item]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

