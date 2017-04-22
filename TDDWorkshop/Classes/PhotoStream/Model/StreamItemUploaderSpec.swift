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
                    fixtureItem.identifier = "FOO-BAR-123"
                    capturedSuccess = nil
                }

                context("with image data") {
                    beforeEach {
                        fixtureItem.imageData = Data()
                        sut.uploadItem(fixtureItem) { success, error in
                            capturedSuccess = success
                            capturedError = error
                        }
                    }
                    it("should upload data to remote storage") {
                        expect(storageFake.uploadCalled) == true
                    }
                    it("should upload image data") {
                        expect(storageFake.capturedData).to(equal(fixtureItem.imageData))
                    }
                    it("should upload image data using item's identifier") {
                        expect(storageFake.capturedIdentifier).to(equal(fixtureItem.identifier))
                    }
                    it("should upload data with completion") {
                        expect(storageFake.capturedCompletion).notTo(beNil())
                    }

                    context("when upload succeeds") {
                        var fixtureURL: URL!
                        beforeEach {
                            fixtureURL = URL(string: "http://foo.bar.com/image.jpg")
                            storageFake.capturedCompletion?(fixtureURL)
                        }
                        it("should set data url on stream item") {
                            expect(fixtureItem.imageURL).to(equal(fixtureURL))
                        }
                        it("should write object on backend") {
                            expect(backendFake.writeCalled) == true
                        }
                        it("should write proper object on backend") {
                            expect(backendFake.capturedObject!) === fixtureItem
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
                }

                context("without image data") {
                    beforeEach {
                        fixtureItem.imageData = nil
                        sut.uploadItem(fixtureItem) { success, error in
                            capturedSuccess = success
                            capturedError = error
                        }
                    }
                    it("should NOT upload data to remote storage") {
                        expect(storageFake.uploadCalled) == false
                    }
                    it("should write object on backend") {
                        expect(backendFake.writeCalled) == true
                    }
                    it("should write proper object on backend") {
                        expect(backendFake.capturedObject!) === fixtureItem
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
            }
        }
    }
}
