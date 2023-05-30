//
//  RoverPhotosViewController.swift
//  NASA Probes
//
//  Created by Matheus Cardoso kuhn on 19/04/19.
//  Copyright (c) 2019 MDT. All rights reserved.
//

import Combine
import UIKit

final class RoverPhotosViewController: UIViewController {
    
    // MARK: Internal Properties
    @IBOutlet weak var segmentedControlRover: UISegmentedControl!
    @IBOutlet weak var collectionViewPhotos: UICollectionView!
    
    // MARK: Private Properties
    private let viewModel = RoverPhotosViewModel(service: RoverPhotosService())
    private var cancellables: Set<AnyCancellable> = .init()
    private var photos: [Photo] = []

    // MARK: Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchPhotos(selectedIndex: segmentedControlRover.selectedSegmentIndex)
    }

    // MARK: Internal Methods
    @IBAction func actionChangeSelectedRover() {
        viewModel.fetchPhotos(selectedIndex: segmentedControlRover.selectedSegmentIndex)
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        guard let destinationController = segue.destination as? PhotoDetailViewController else {
    //            return
    //        }
    //        let selectedIndex = collectionViewPhotos.indexPathsForSelectedItems?.first?.row ?? 0
    //        let photo = photos[selectedIndex]
    //        destinationController.photo = photo
    //    }
    
    // MARK: Private Methods
    private func setup() {
        viewModel.viewState.receive(on: DispatchQueue.main).sink { [weak self] status in
            switch status {
            case let .content(photos):
                self?.photos = photos
                self?.collectionViewPhotos.reloadData()
            case .emptyScreen:
                break
            case .loading:
                break
            case let .error(title, message):
                self?.displayError(title: title, message: message)
            }
        }.store(in: &cancellables)
    }
    
    private func displayError(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(actionOk)
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: - UICollectionViewDataSource
extension RoverPhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell
        if let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell {
            cell = dequeuedCell
        } else {
            cell = PhotoCollectionViewCell()
        }
        cell.downloadRequest = viewModel.downloadImage(at: indexPath) { image in
            cell.imageViewPhoto.image = image
        }
        return cell
    }
}
