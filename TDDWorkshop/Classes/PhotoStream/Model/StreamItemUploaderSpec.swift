import Quick
import Nimble

@testable
import TDDWorkshop

class StreamItemUploaderSpec: QuickSpec {
    override func spec() {
        describe("StreamItemUploader") {

            var sut: StreamItemUploader!

            var backendFake: BackendAdapterFake!
            var storageFake: RemoteStorageFake!

            beforeEach {
                backendFake = BackendAdapterFake()
                storageFake = RemoteStorageFake()
                sut = StreamItemUploader(backendAdapter: backendFake, remoteStorage: storageFake)
            }

            describe("upload item") {

                var fixtureItem: StreamItem!
                var capturedSuccess: Bool?
                var capturedError: Error?

                beforeEach {
                    fixtureItem = StreamItem(title: "Foo Bar", creationDate: Date())
                    capturedSuccess = nil
                    sut.uploadItem(fixtureItem) {
                        success, error in
                        capturedSuccess = success
                        capturedError = error
                    }
                }
                it("should upload object") {
                    //TODO
                }
                it("should upload object with proper title") {
                }
                it("should upload object with image data") {
                }

                context("when it succeeds") {
                    beforeEach {
                    }
                    it("should call completion") {
                        expect(capturedSuccess).notTo(beNil())
                    }
                    it("should call completion with true flag") {
                        expect(capturedSuccess!) == true
                    }
                    it("should call completion without error") {
                        expect(capturedError).to(beNil())
                    }
                }
                context("when it fails") {
                    beforeEach {
                    }
                    it("should call completion") {
                        expect(capturedSuccess).notTo(beNil())
                    }
                    it("should call completion with false flag") {
                        expect(capturedSuccess!) == false
                    }
                    it("should call completion with error") {
                        expect(capturedError).notTo(beNil())
                    }
                }
            }
        }
    }
}
