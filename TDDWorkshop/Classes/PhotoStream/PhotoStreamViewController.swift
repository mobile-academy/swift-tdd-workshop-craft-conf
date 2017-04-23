//
//  Copyright © 2017 Mobile Academy. All rights reserved.
//

import UIKit

class PhotoStreamViewController: UICollectionViewController {

    // MARK: Properties

    var backendAdapter: BackendAdapting
    var remoteStorage: RemoteDataStoring
    var downloader: ItemDownloading
    var creator: ItemCreating
    var uploader: ItemUploading
    var imageManipulator: ImageManipulating
    var presenter: ViewControllerPresenting
    var alertActionFactory: AlertActionCreating
    var refreshControl: UIRefreshControl

    var streamItems = [StreamItem]()

    // MARK: Object Life Cycle

    required init?(coder: NSCoder) {
        backendAdapter = FirebaseAdapter()
        remoteStorage = FirebaseDataStorage()
        presenter = DefaultViewControllerPresenter()
        imageManipulator = DefaultImageManipulator()
        refreshControl = UIRefreshControl()
        downloader = StreamItemDownloader(backendAdapter: backendAdapter, remoteStorage: remoteStorage)
        creator = StreamItemCreator(presenter: presenter)
        uploader = StreamItemUploader(backendAdapter: backendAdapter, remoteStorage: remoteStorage)
        alertActionFactory = DefaultAlertActionFactory()

        super.init(coder: coder)
        presenter.viewController = self
        creator.delegate = self
    }

    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        downloadStreamItems()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return streamItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoStreamCell", for: indexPath)
        let streamItem = streamItems[indexPath.row]
        guard let photoCell = cell as? PhotoStreamCell else { return cell }
        if let data = streamItem.imageData {
            photoCell.imageView.image = imageManipulator.imageFromData(data)
        } else {
            downloadImage(for: photoCell, at: indexPath)
        }
        return cell
    }

    // MARK: Actions

    @IBAction func didPressAddItemBarButtonItem(_ sender: UIBarButtonItem!) {
        creator.createStreamItem()
    }

    func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        downloadStreamItems()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let itemViewController = segue.destination as? StreamItemViewController,
           let cell = sender as? UICollectionViewCell,
           let indexPath = collectionView?.indexPath(for: cell) {
            itemViewController.streamItem = streamItems[indexPath.item]
        }
    }
}

extension PhotoStreamViewController: ItemCreatingDelegate {
    func creator(_ creator: ItemCreating, didCreateItem item: StreamItem) {
        uploader.uploadItem(item) { [weak self] success, error in
            if success == false {
                self?.presentErrorAlertWithMessage("Failed to upload stream item!")
            } else {
                self?.add(item)
            }
        }
    }

    func creator(_ creator: ItemCreating, failedWithError: Error) {
        presentErrorAlertWithMessage("Failed to create stream item!")
    }
}

extension PhotoStreamViewController {
    fileprivate func presentErrorAlertWithMessage(_ message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        errorAlert.addAction(alertActionFactory.createActionWithTitle("Cancel", style: .cancel) {
            action in
        })
        presenter.presentViewController(errorAlert)
    }

    fileprivate func setupCollectionView() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: UIControlEvents.valueChanged)
        collectionView?.addSubview(refreshControl)
        collectionView?.alwaysBounceVertical = true
    }

    fileprivate func downloadStreamItems() {
        downloader.downloadItems { [weak self] items, error in
            self?.refreshControl.endRefreshing()
            if error != nil {
                self?.presentErrorAlertWithMessage("Failed to download stream items!")
            } else {
                self?.streamItems = items ?? []
                self?.collectionView?.reloadData()
            }
        }
    }

    fileprivate func downloadImage(for cell: PhotoStreamCell, at indexPath: IndexPath) {
        let streamItem = streamItems[indexPath.row]
        downloader.downloadImage(for: streamItem) { [weak self] in
            if let cellIndexPath = self?.collectionView?.indexPath(for: cell), indexPath != cellIndexPath {
                return
            }
            if let data = streamItem.imageData {
                cell.imageView.image = self?.imageManipulator.imageFromData(data)
            }
        }
    }

    fileprivate func add(_ item:StreamItem) {
        streamItems.append(item)
        collectionView?.reloadData()
    }
}



