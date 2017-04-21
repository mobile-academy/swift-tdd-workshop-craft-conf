//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit
import UIImage_Resize

protocol ImageManipulating {
    func scaleImage(_ image: UIImage, maxDimension: Int) -> UIImage

    func dataFromImage(_ image: UIImage, quality: Float) -> Data
    func imageFromData(_ data: Data) -> UIImage
}

class DefaultImageManipulator: ImageManipulating {

    func scaleImage(_ image: UIImage, maxDimension: Int) -> UIImage {
        let size = CGSize(width: maxDimension, height: maxDimension)
        return image.resizedImageToFit(in: size, scaleIfSmaller: true)
    }

    func dataFromImage(_ image: UIImage, quality: Float) -> Data {
        return UIImageJPEGRepresentation(image, CGFloat(quality))!
    }

    func imageFromData(_ data: Data) -> UIImage {
        return UIImage(data: data)!
    }

}
