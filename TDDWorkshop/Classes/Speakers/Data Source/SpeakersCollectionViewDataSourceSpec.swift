import Foundation
import Quick
import Nimble

@testable
import TDDWorkshop


class SpeakersCollectionViewDataSourceSpec: QuickSpec {
    override func spec() {
        describe("SpeakersCollectionViewDataSource") {

            var sut: SpeakersCollectionViewDataSource?
            var collectionView: UICollectionView?

            beforeEach {
                let speaker1 = Speaker(name:"Fixture Name 1", photo:nil)
                let speaker2 = Speaker(name:"Fixture Name 2", photo:nil)

                sut = SpeakersCollectionViewDataSource(speakers: [speaker1, speaker2])

                collectionView = UICollectionView(frame:CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
                collectionView?.register(SpeakerCollectionViewCell.self, forCellWithReuseIdentifier: SpeakerCellIdentifier)
                collectionView?.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
                collectionView?.dataSource = sut
            }

            describe("number of items") {

                var numberOfItems: NSInteger?

                beforeEach {
                    numberOfItems = sut?.collectionView(collectionView!, numberOfItemsInSection:0)
                }

                it("should return number of items equal to number of speakers") {
                    expect(numberOfItems).to(equal(2))
                }
            }

            describe("cell for item at index path") {

                var cell: SpeakerCollectionViewCell?
                
                context("when it's the first row") {
                    
                    beforeEach {
                        cell = sut?.collectionView(collectionView!, cellForItemAt: IndexPath(item:0, section:0)) as? SpeakerCollectionViewCell
                    }
                    
                    it("should return a cell with properly configured title") {
                        expect(cell?.titleLabel.text).to(equal("Fixture Name 1"))
                    }
                }
                
                context("when it's the second row") {

                    beforeEach {
                        cell = sut?.collectionView(collectionView!, cellForItemAt: IndexPath(item:1, section:0)) as? SpeakerCollectionViewCell
                        
                    }

                    it("should return a cell with properly configured title") {
                        expect(cell?.titleLabel.text).to(equal("Fixture Name 2"))
                    }
                }
            }
        }
    }
}
