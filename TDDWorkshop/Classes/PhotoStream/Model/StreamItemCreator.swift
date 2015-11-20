//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class StreamItemCreator: NSObject, ItemCreating, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties

    weak var delegate: ItemCreatingDelegate?

    var controllerPresenter: ViewControllerPresenting
    var resourceAvailability: SourceTypeAvailability
    var actionFactory: AlertActionCreating
    var pickerFactory: ImagePickerCreating
    var imageManipulator: ImageManipulating

    // MARK: Object Life Cycle

    init(presenter: ViewControllerPresenting) {
        controllerPresenter = presenter
        resourceAvailability = DefaultSourceTypeProvider()
        actionFactory = DefaultAlertActionFactory()
        pickerFactory = DefaultImagePickerFactory()
        imageManipulator = DefaultImageManipulator()
    }

    // MARK: ItemCreating

    func createStreamItem() {
        //TODO: Task 2
        //TODO: check the available source types from `resourceAvailability`
        //TODO: if it's empty, inform delegate about error
        //TODO: if it contains single element, present `UIImagePickerController`
        //TODO: if it contains more then one element, present `UIAlertControler` so user has to pick source
        presentSourcesActionSheet()
    }

    // MARK: UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        controllerPresenter.dismissViewController(picker)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            let error = NSError(domain: "TDDWorkshop", code: -1, userInfo: nil)
            delegate?.creator(self, failedWithError: error)
            return
        }
        let alertController = createTitleAlertController()
        let alertAction = actionFactory.createActionWithTitle("OK", style: .default) {
            [weak self] action in
            let title = self?.itemTitleFromTitleAlertController(alertController)
            let streamItem = self?.createItemWithTitle(title!, pickedImage: image)
            self?.delegate?.creator(self!, didCreateItem: streamItem!)
        }
        alertController.addAction(alertAction)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        controllerPresenter.dismissViewController(picker)
    }

    // MARK: Private methods

    fileprivate func itemTitleFromTitleAlertController(_ alertController: UIAlertController) -> String {
        guard let title = alertController.textFields?.first?.text else {
            return "No title provided:("
        }
        return title
    }

    fileprivate func createItemWithTitle(_ title: String, pickedImage image: UIImage) -> StreamItem {
        let scaledImage = imageManipulator.scaleImage(image, maxDimension: 600)
        let imageData = imageManipulator.dataFromImage(scaledImage, quality: 0.7)
        let streamItem = StreamItem(title: title, creationDate: Date())
        streamItem.imageData = imageData
        streamItem.identifier = NSUUID().uuidString
        return streamItem
    }

    fileprivate func createTitleAlertController() -> UIAlertController {
        let alertController = UIAlertController(title: "Title of the item", message: nil, preferredStyle: .alert)
        controllerPresenter.presentViewController(alertController)
        alertController.addTextField {
            textField in
            textField.placeholder = "Something funny"
        }
        return alertController
    }

    fileprivate func presentSourcesActionSheet() {
        let alertController = UIAlertController(title: "Add new Item to the stream", message: nil, preferredStyle: .actionSheet)
        addImagePickerActionsToAlertController(alertController, forSources: resourceAvailability.availableSources())
        let cancelAction = actionFactory.createActionWithTitle("Cancel", style: .cancel) {
            action in
        }
        alertController.addAction(cancelAction)
        controllerPresenter.presentViewController(alertController)
    }

    fileprivate func addImagePickerActionsToAlertController(_ alertController: UIAlertController,
                                                        forSources sources: [UIImagePickerControllerSourceType]) {
        for source in sources {
            switch (source) {
            case .photoLibrary:
                let alertAction = actionFactory.createActionWithTitle("Pick from Library", style: .default) {
                    [weak self] action in
                    self?.presentPickerWithResourceType(.photoLibrary)
                }
                alertController.addAction(alertAction)
            case .camera:
                let alertAction = actionFactory.createActionWithTitle("Take a Photo", style: .default) {
                    [weak self] action in
                    self?.presentPickerWithResourceType(.camera)
                }
                alertController.addAction(alertAction)
            default:
                break
            }
        }
    }

    fileprivate func presentPickerWithResourceType(_ sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = pickerFactory.createPickerWithSourceType(sourceType)
        imagePicker.delegate = self
        controllerPresenter.presentViewController(imagePicker)
    }
}
