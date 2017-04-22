//
//  Copyright © 2017 Mobile Academy. All rights reserved.
//

import UIKit

class SpeakersViewController: UICollectionViewController {

    // MARK: Properties

    var dataSource: SpeakersCollectionViewDataSource? {
        didSet {
            self.collectionView?.dataSource = self.dataSource
        }
    }

    // MARK: Initializers

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.title = "Speakers"
        self.dataSource = SpeakersCollectionViewDataSource(speakers: self.defaultSpeakers())
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    // MARK: Init Helpers

    func defaultSpeakers() -> [Speaker] {
        let resourcePath = Bundle.main.path(forResource: "speakers", ofType: "JSON")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: resourcePath))

        var speakersArray: [Speaker] = []

        do {
            let unparsedSpeakers = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String : String]]
            for speakerDictionary in unparsedSpeakers! {

                let speakerImageName = speakerDictionary["image"]
                var image: UIImage?

                if speakerImageName != nil {
                    image = UIImage(named: speakerImageName!)
                }

                let speaker = Speaker(name: speakerDictionary["name"]!, photo: image)
                speakersArray.append(speaker)
            }

        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        } 

        return speakersArray
    }

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.dataSource = self.dataSource
        self.collectionView?.register(SpeakerCollectionViewCell.self, forCellWithReuseIdentifier:SpeakerCellIdentifier)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError()
        }

        layout.itemSize = CGSize(width: self.view.bounds.width, height: 80)
    }
}

