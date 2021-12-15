//
//  ViewController.swift
//  LystApp
//
//

import UIKit

class ViewController: UIViewController {
    
    private var dogModelArray = [DogModel]()
    private var viewModel = ViewModel()
    private var collectionView: UICollectionView?
    
    /// Search bar to search for dog breeds
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.titleView = searchBar
        navigationItem.title = "Dog API Search"
        
        setUpCollectionView()
        setDoneOnKeyboard()
        
        searchBar.delegate = self
        
        self.viewModel.getBreedList { dogs in
            self.dogModelArray = dogs
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    /// Add "Done" button to keyboard
    private func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        
        keyboardToolbar.sizeToFit()
        
        let flexibleSpaceBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        
        keyboardToolbar.items = [flexibleSpaceBarButton, doneBarButton]
        
        searchBar.inputAccessoryView = keyboardToolbar
    }

    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.backgroundColor = .secondarySystemBackground
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func setUpCollectionView() {
        let view = UIView()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        
        let dimension = (UIScreen.main.bounds.width / 2)
        layout.itemSize = CGSize(width: dimension - 20, height: dimension - 30)
        
        layout.minimumLineSpacing = 40
        
        collectionView?.backgroundColor = .secondarySystemBackground
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(DogCollectionViewCell.self, forCellWithReuseIdentifier: "DogCollectionViewCell")
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        collectionView?.decelerationRate = .fast
        
        if let collectionView = collectionView {
            view.addSubview(collectionView)
        }
        view.backgroundColor = .secondarySystemBackground
        self.view = view
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dogModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogCollectionViewCell", for: indexPath) as? DogCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        if indexPath.item <= (dogModelArray.count - 1) {
            let dog = dogModelArray[indexPath.item]
           
            DispatchQueue.main.async {
                self.viewModel.getImage(dog: dog) { image in
                    cell.setUpCell(image: image, dog: dog) {
                        cell.reloadInputViews()
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? DogCollectionViewCell,
              let dog = cell.dog,
              let image = cell.dogImage else {
            return
        }
        
        self.navigationController?.pushViewController(DogInformationViewController(dog: dog, dogImage: image, viewModel: viewModel), animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let searchedText = searchBar.text?.lowercased() else {
            return
        }
        
        let indexPath = viewModel.getIndexPathOfSearch(searchString: searchedText)
        
        self.collectionView?.scrollToItem(at: indexPath, at: .top, animated: false)
    }
}
