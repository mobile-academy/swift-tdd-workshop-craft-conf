//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

@testable
import TDDWorkshop

class ImageManipulatorFake: ImageManipulating {

    var capturedImageToScale: UIImage?
    var capturedImageToDataConversion: UIImage?

    var fakeDataFromImage: Data = Data()
    var fakeImageFromData: UIImage = UIImage()
    var fakeScaledImage: UIImage = UIImage()

    func scaleImage(_ image: UIImage, maxDimension: Int) -> UIImage {
        capturedImageToScale = image
        return fakeScaledImage
    }

    func dataFromImage(_ image: UIImage, quality: Float) -> Data {
        capturedImageToDataConversion = image
        return fakeDataFromImage
    }

    func imageFromData(_ data: Data) -> UIImage {
        return fakeImageFromData
    }

}
