//
// Created by Maciej Oczko on 23.04.2017.
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TDDWorkshop

class DefaultValidatorsFactorySpec: QuickSpec {
    override func spec() {
        describe("DefaultValidatorsFactory") { 
        
            var sut: DefaultValidatorsFactory!
            
            beforeEach {
				sut = DefaultValidatorsFactory()
			}

			afterEach {
				sut = nil
			}

			it("should return illegal symbols validator for name") {
				expect(sut.validator(for: .text) is IllegalSymbolsValidator).to(beTrue())
			}

			it("should return email validator for username") {
				expect(sut.validator(for: .email) is EmailValidator).to(beTrue())
			}

			it("should return minimal characters count validator for comment") {
				expect(sut.validator(for: .comment) is CharactersMinimalCountValidator).to(beTrue())
			}

		}
	}
}
