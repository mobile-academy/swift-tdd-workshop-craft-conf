//
// Copyright (©) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

@objc class SpeakersCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    //MARK: Properties

    let speakers: [Speaker]

    //MARK: Initializers

    init(speakers: [Speaker]) {
        self.speakers = speakers
    }

    //MARK: UICollection View Data Source

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.speakers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpeakerCellIdentifier, for: indexPath) as! SpeakerCollectionViewCell
        cell.titleLabel.text = self.speakers[indexPath.row].name
        cell.imageView.image = self.speakers[indexPath.row].photo
        return cell
    }
}
