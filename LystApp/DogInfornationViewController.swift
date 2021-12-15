//
//  DogInformationViewController.swift
//  LystApp
//
//
import Foundation
import UIKit

class DogInformationViewController: UIViewController {
    
    let dog: DogModel
    let dogImage: UIImage
    let viewModel: ViewModel
    
    var dogInformationArray = [String]()
    
    let tableView = UITableView()
    
    private var dogImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        imageView.backgroundColor?.withAlphaComponent(0.5)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var dogNameLabel: UILabel = {
        let label = UILabel()
        label.text = dog.name
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(dog: DogModel, dogImage: UIImage, viewModel: ViewModel) {
        self.dog = dog
        self.dogImage = dogImage
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UILabel.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).adjustsFontSizeToFitWidth = true
        
        self.dogInformationArray = viewModel.getDogInformationArray(dog: dog)
        
        view.backgroundColor = .secondarySystemBackground
    
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = dog.name
        
        dogImageView.image = dogImage
        
        setUpTableView()
        setUpConstraints()
    }

    
    private func setUpTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DogInformationTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    private func setUpConstraints() {
        let dimension = (UIScreen.main.bounds.width / 2)
        view.addSubview(dogImageView)
        view.addSubview(tableView)
        
        dogImageView.heightAnchor.constraint(equalToConstant: dimension + 40).isActive = true
        dogImageView.widthAnchor.constraint(equalToConstant: dimension + 60).isActive = true
        dogImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dogImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: dogImageView.bottomAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DogInformationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogInformationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        
        cell.detailTextLabel?.numberOfLines = 0
        
        cell.textLabel?.text = viewModel.dogInformationTitles[indexPath.row]
        cell.detailTextLabel?.text = dogInformationArray[indexPath.row]
        
        return cell
    }
}
