//
//  Copyright © 2017 Mobile Academy. All rights reserved.
//

import UIKit

class PhotoStreamViewController: UICollectionViewController, ItemCreatingDelegate {

    // MARK: Properties

    var backendAdapter: BackendAdapting
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
        presenter = DefaultViewControllerPresenter()
        imageManipulator = DefaultImageManipulator()
        refreshControl = UIRefreshControl()
        downloader = StreamItemDownloader(backendAdapter: backendAdapter)
        creator = StreamItemCreator(presenter: presenter)
        uploader = StreamItemUploader(backendAdapter: backendAdapter)
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
        if let photoCell = cell as? PhotoStreamCell {
            let streamItem = streamItems[indexPath.row]
            photoCell.imageView.image = imageManipulator.imageFromData(streamItem.imageData)
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

    // MARK: ItemCreatingDelegate

    func creator(_ creator: ItemCreating, didCreateItem item: StreamItem) {
        uploader.uploadItem(item) {
            [weak self] success, error in
            if success == false {
                self?.presentErrorAlertWithMessage("Failed to upload stream item!")
            } else {
                // TODO: Task 1
                // TODO: add `item` to `streamItems`
                // TODO: reload data on `collectionView`
            }
        }
    }

    func creator(_ creator: ItemCreating, failedWithError: Error) {
        presentErrorAlertWithMessage("Failed to create stream item!")
    }

    // MARK: Private methods

    fileprivate func presentErrorAlertWithMessage(_ message: String) {
        let errorAlert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        errorAlert.addAction(alertActionFactory.createActionWithTitle("Cancel", style: .cancel) {
            action in })
        presenter.presentViewController(errorAlert)
    }

    fileprivate func setupCollectionView() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: UIControlEvents.valueChanged)
        collectionView?.addSubview(refreshControl)
        collectionView?.alwaysBounceVertical = true
    }

    fileprivate func downloadStreamItems() {
        downloader.downloadItems {
            [weak self] items, error in
            self?.refreshControl.endRefreshing()
            if error != nil || items == nil {
                self?.presentErrorAlertWithMessage("Failed to download stream items!")
            } else {
                self?.streamItems = items!
                self?.collectionView?.reloadData()
            }
        }
    }
}



