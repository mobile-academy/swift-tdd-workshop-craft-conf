import Quick
import Nimble

@testable
import TDDWorkshop

class StreamItemDownloaderSpec: QuickSpec {
    override func spec() {
        describe("StreamItemDownloader") {

            var sut: StreamItemDownloader!

            var backendFake: BackendAdapterFake!
            var storageFake: RemoteStorageFake!

            beforeEach {
                backendFake = BackendAdapterFake()
                storageFake = RemoteStorageFake()

                sut = StreamItemDownloader(backendAdapter: backendFake, remoteStorage: storageFake)
            }

            describe("download items") {

                var downloadedItems: [StreamItem]?
                var capturedError: Error?

                beforeEach {
                    sut.downloadItems { items, error in
                        downloadedItems = items
                        capturedError = error
                    }
                }

                it("should execute query") {
                    expect(backendFake.readObjectsCalled) == true
                }

                context("when succeeds and completion is called") {
                    beforeEach {
                        backendFake.simulateSuccess?()
                    }
                    it("should NOT pass error") {
                        expect(capturedError).to(beNil())
                    }
                    it("should return stream items") {
                        expect(downloadedItems).notTo(beNil())
                    }
                }
                context("when fails") {
                    beforeEach {
                        backendFake.simulateFailure?()
                    }
                    it("should pass an error") {
                        expect(capturedError).notTo(beNil())
                    }
                    it("should NOT return stream items") {
                        expect(downloadedItems).to(beNil())
                    }
                }
            }
        }
    }
}
