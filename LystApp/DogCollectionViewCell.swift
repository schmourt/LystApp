//
//  DogCollectionViewCell.swift
//  LystApp
//
//
import Foundation
import UIKit

class DogCollectionViewCell: UICollectionViewCell {
    
    var dog: DogModel?
    var dogImage: UIImage?
    
    private let loadingSpinner: UIActivityIndicatorView = {
        let loginSpinner = UIActivityIndicatorView(style: .medium)
        loginSpinner.translatesAutoresizingMaskIntoConstraints = false
        loginSpinner.hidesWhenStopped = true
        
        return loginSpinner
    }()
    
    private var dogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .tertiarySystemGroupedBackground
        imageView.backgroundColor?.withAlphaComponent(0.5)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var dogBreedLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.setUpConstraints()
    }
    
    override func prepareForReuse() {
        dogImageView.image = nil
        dogBreedLabel.text = ""
        
        self.dog = nil
        self.dogImage = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(image: UIImage, dog: DogModel, completion: @escaping ()->()) {
        DispatchQueue.main.async {
            self.setUpPlaceholder()
            self.dog = dog
            self.dogImage = image
            self.dogBreedLabel.text = dog.name
            self.dogImageView.image = image
            
            self.loadingSpinner.stopAnimating()
            
            completion()
        }
    }
    
    func setUpPlaceholder() {
        self.dogImageView.image = nil
        self.dogBreedLabel.text = ""
    }
    
    private func setUpConstraints() {
        let dimension = (UIScreen.main.bounds.width / 2)
        
        contentView.addSubview(dogImageView)
        contentView.addSubview(dogBreedLabel)
        dogImageView.addSubview(loadingSpinner)

        dogImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        dogImageView.widthAnchor.constraint(equalToConstant: 140).isActive = true
        dogImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        
        dogBreedLabel.widthAnchor.constraint(equalToConstant: dimension - 20).isActive = true
        dogBreedLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        dogBreedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        dogBreedLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        dogBreedLabel.bottomAnchor.constraint(equalTo: dogImageView.topAnchor, constant: -12).isActive = true
        
        loadingSpinner.centerXAnchor.constraint(equalTo: dogImageView.centerXAnchor).isActive = true
        loadingSpinner.centerYAnchor.constraint(equalTo: dogImageView.centerYAnchor).isActive = true
        loadingSpinner.startAnimating()
    }
}
