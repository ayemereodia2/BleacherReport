//
//  PhotoSearchController.swift
//  BleacherReportApp
//
//  Created by Ayemere  Odia  on 27/03/2020.
//  Copyright © 2020 Ayemere  Odia . All rights reserved.
//

import UIKit

class PhotoSearchController: UIViewController {
    
    // MARK:- Properties
    private lazy var viewModel: PhotoSearchViewModel = PhotoSearchViewModel()
    fileprivate var searchHistoryViewController: SearchHistoryController?
    fileprivate var currentPage: Int = 0
    fileprivate var searchText: String?
    
    private let flickrAPI = FlickrAPI.shared
    private let cellId = "photoCell2Id"
    
    // MARK:- Screen Properties
    private lazy var photoSearchBar: UISearchBar = {
        let sb = UISearchBar(frame: .zero)
        sb.placeholder = "photos,people,groups.."
        sb.searchBarStyle = .prominent
        sb.barTintColor = .black
        let textFieldInsideSearchBar = sb.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        sb.delegate = self
        return sb
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .black
        cv.dataSource = self
        cv.delegate = self
        let nib = UINib(nibName: "PhotoCell2", bundle: nil)
        cv.register(nib, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK:- Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flickr Photo Search"
        view.backgroundColor = .black
        setUpSearchHistoryView()

        setupSubviews()

        searchFlickr(with: "goose")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        photoSearchBar.text = nil
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK:- Screen layout methods
    private func setupSubviews() {
        
        let newView = UIView()
        newView.backgroundColor = UIColor.red
        
        [photoSearchBar, collectionView].forEach {
            view.addSubview($0)
        }
        
        let guide = view.safeAreaLayoutGuide
        
        photoSearchBar.anchor(top: guide.topAnchor,
                              leading: guide.leadingAnchor,
                              bottom: nil,
                              trailing: guide.trailingAnchor)
       
        collectionView.anchor(top: photoSearchBar.bottomAnchor,
                              leading: guide.leadingAnchor,
                              bottom: guide.bottomAnchor,
                              trailing: guide.trailingAnchor)
    }
    
    // MARK:- Handling methods
    private func searchFlickr(with query: String) {
        let query = query.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: " ", with: "+")
        
        if query.isEmpty {
            let alert = flickrAPI.displayAlert(with: "Enter a search term")
            self.present(alert, animated: true, completion: nil)
            self.photoSearchBar.text = nil
            return
        }
        
        guard let searchUrl = flickrAPI.searchUrl(with: query) else { return }
        
        flickrAPI.flickrSearch(with: searchUrl) { [weak self] (photos, err) in
            if let err = err {
                print("Failed to fetch flickr data: \(err.localizedDescription)")
                return
            }
            guard
                let self = self,
                let photos = photos else { return }
            // DI
            self.viewModel = PhotoSearchViewModel(photos: photos)
            
            DispatchQueue.main.async {
                self.collectionView.reloadSections(IndexSet(0...0))
                if !photos.isEmpty {
                    let indexPath: IndexPath = IndexPath(item: 0, section: 0)
                    self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.bottom, animated: false)
                }
            }
        }
    }
    
    func setUpSearchHistoryView() -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    searchHistoryViewController = storyboard.instantiateViewController(withIdentifier: "SearchHistoryController") as? SearchHistoryController
        
        
        searchHistoryViewController?.view.frame = CGRect(x: 0, y: 64+44, width: view.frame.size.width, height: view.frame.size.height)
        searchHistoryViewController?.delegate = self
        searchHistoryViewController?.view.isHidden = true
        
       if let searchHistoryView = searchHistoryViewController?.view {


        view.addSubview(searchHistoryView)
    }
        
    }
    
    func prepareViewForSearch(with text: String?) -> Void {
        searchText = text
        currentPage = 0
    }
    
    func searchPhotos(completion: ((_ success: Bool) -> Void)?) -> Void {
        guard let searchText = searchText else { return }
        
        guard let searchUrl = flickrAPI.searchUrl(with: searchText) else { return }
               
               flickrAPI.flickrSearch(with: searchUrl) { [weak self] (photos, err) in
                   if let err = err {
                       print("Failed to fetch flickr data: \(err.localizedDescription)")
                       return
                   }
        guard
            let self = self,
            let photos = photos else { return }
        // DI
        self.viewModel = PhotoSearchViewModel(photos: photos)
        
        DispatchQueue.main.async {
            self.collectionView.reloadSections(IndexSet(0...0))
            if !photos.isEmpty {
                let indexPath: IndexPath = IndexPath(item: 0, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.bottom, animated: false)
            }
        }
    
    completion?(true)
        
    }
    
    
}
}

// MARK:- Regarding Collection View methods
extension PhotoSearchController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PhotoCell2 else {
            fatalError("Failed to cast PhotoCell")
        }
        cell.imageTitle = viewModel.imageTitle(for: indexPath)//(for: indexPath)

        cell.imageUrl = viewModel.imageUrl(for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 420 //collectionView.frame.width
        let height = 106 //collectionView.frame.height / 2.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoDetailController = PhotoDetailController()
        // DI
        let photo = viewModel.photo(for: indexPath)
        photoDetailController.viewModel = PhotoDetailViewModel(photo: photo)
        navigationController?.pushViewController(photoDetailController, animated: true)
    }
}

// MARK:- Regarding UISearchBarDelegate methods
extension PhotoSearchController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        searchHistoryViewController = storyboard.instantiateViewController(withIdentifier: "SearchHistoryController") as? SearchHistoryController
            
        
        searchBar.showsCancelButton = true
        print("table",SearchHistoryManager.history.count)
        searchHistoryViewController?.view.isHidden = SearchHistoryManager.history.count <= 0
        searchHistoryViewController?.reloadTableView()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        prepareViewForSearch(with: searchBar.text)
        searchHistoryViewController?.view.isHidden = true
        searchPhotos(completion: { success in
            if success {
                DispatchQueue.main.async {
                if let text = searchBar.text {
                    SearchHistoryManager.add(text: text)
                }
                searchBar.text = nil
                }
            }
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchHistoryViewController?.view.isHidden = true
    }
}

extension PhotoSearchController: SearchHistoryViewControllerDelegate {
    
    func userDidSelect(searchText: String) {
        searchHistoryViewController?.view.isHidden = true
        prepareViewForSearch(with: searchText)
        searchPhotos(completion: nil)
    }
}


