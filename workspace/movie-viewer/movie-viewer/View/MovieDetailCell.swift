//
//  MovieDetailCell.swift
//  movie-viewer
//
//  Created by Dreb Rodriguez on 14/06/2018.
//  Copyright © 2018 Dreb Rodriguez. All rights reserved.
//

import UIKit

protocol MovieDetailCellDelegate {
    func didTapViewSeat(movie: Movie)
}

class MovieDetailCell: UICollectionViewCell {
    
    var delegate: MovieDetailCellDelegate?
    
    var movie: Movie? {
        didSet {
            setupTextViewAttributedText()
            
            guard let posterLandscapeUrl = movie?.posterLandscape else { return }
            posterLandscapeImageView.imageFromUrl(urlString: posterLandscapeUrl)
            
            guard let posterUrl = movie?.poster else { return }
            posterImageView.imageFromUrl(urlString: posterUrl)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.Custom.edgarWhite
        
        setupViews()
    }
    
    let posterLandscapeImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let posterImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let detailsTextView: UITextView = {
        let tv = UITextView()
        tv.isEditable = false
        tv.backgroundColor = .clear
        return tv
    }()
    
    lazy var viewSeatButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .red
        btn.setTitle("View Seat Map", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(handleViewSeat), for: .touchUpInside)
        return btn
    }()
    
    @objc fileprivate func handleViewSeat() {
        guard let movie = self.movie else { return }
        delegate?.didTapViewSeat(movie: movie)
    }
    
    fileprivate func setupViews() {
        
        [posterLandscapeImageView, posterImageView, detailsTextView, viewSeatButton].forEach({addSubview($0)})
        
        posterLandscapeImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        posterLandscapeImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        posterImageView.anchor(top: posterLandscapeImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0), size: CGSize(width: frame.width / 2.5, height: frame.height / 2.5))
        
        detailsTextView.anchor(top: posterImageView.topAnchor, leading: posterImageView.trailingAnchor, bottom: viewSeatButton.topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
        
        viewSeatButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: CGSize(width: 0, height: 50))
    }
    
    fileprivate func setupTextViewAttributedText() {
        guard let movie = movie else { return }
        
        let detailsMutableAttibutedString = NSMutableAttributedString()
        
        let nameAttributedString = NSMutableAttributedString(string: "Name:\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        nameAttributedString.append(NSAttributedString(string: "\(movie.canonicalTitle)\n\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        let genreAttributedString = NSMutableAttributedString(string: "Genre:\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        genreAttributedString.append(NSAttributedString(string: "\(movie.genre)\n\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        let advisoryAttributedString = NSMutableAttributedString(string: "Advisory Rating:\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        advisoryAttributedString.append(NSAttributedString(string: "\(movie.advisoryRating)\n\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        let durationAttributedString = NSMutableAttributedString(string: "Duration:\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        durationAttributedString.append(NSAttributedString(string: "\(movie.runtimeMins.formattedTime())\n\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        let releaseDateAttributedString = NSMutableAttributedString(string: "Release Date:\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        releaseDateAttributedString.append(NSAttributedString(string: "\(movie.releaseDate.formattedDate())\n\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        let synopsisAttributedString = NSMutableAttributedString(string: "Synopsis:\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        synopsisAttributedString.append(NSAttributedString(string: "\(movie.synopsis)\n\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        let castAttributedString = NSMutableAttributedString(string: "Cast:\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        castAttributedString.append(NSAttributedString(string: "\(movie.cast.joined(separator: ", "))", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        [nameAttributedString, genreAttributedString, advisoryAttributedString, durationAttributedString, releaseDateAttributedString, synopsisAttributedString, castAttributedString].forEach({detailsMutableAttibutedString.append($0)})
        
        detailsTextView.attributedText = detailsMutableAttibutedString
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
