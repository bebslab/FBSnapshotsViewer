//
//  MenuWireframeSpec.swift
//  FBSnapshotsViewer
//
//  Created by Anton Domashnev on 27.04.17.
//  Copyright © 2017 Anton Domashnev. All rights reserved.
//

import Quick
import Nimble
import AppKit

@testable import FBSnapshotsViewer

class MenuWireframeSpec: QuickSpec {
    override func spec() {
        var wireframe: MenuWireframe!

        beforeEach {
            wireframe = MenuWireframe()
        }

        describe("instantinateMenu(in:)") {
            var menuModule: MenuController!

            beforeEach {
                menuModule = wireframe.instantinateMenu(in: NSStatusBar.system(), configuration: Configuration.default()) as? MenuController
            }

            it("returns initialized module") {
                let presenter: MenuPresenter? = menuModule.eventHandler as? MenuPresenter
                let interactor: MenuInteractor? = presenter?.interactor as? MenuInteractor
                expect(menuModule).toNot(beNil())
                expect(presenter).toNot(beNil())
                expect(presenter?.wireframe).toNot(beNil())
                expect(presenter?.userInterface).toNot(beNil())
                expect(interactor).toNot(beNil())
                expect(interactor?.output).toNot(beNil())
            }
        }

        describe(".showTestResultsModule(with:)") {
            it("doesnt crash") {
                wireframe.showTestResultsModule(with: [])
            }
        }

        describe(".showPreferencesModule") {
            var configurationStorage: ConfigurationStorageMock!

            beforeEach {
                let configuration = Configuration.default()
                configurationStorage = ConfigurationStorageMock()
                configurationStorage.loadConfiguration_ReturnValue = configuration
            }

            it("doesnt crash") {
                wireframe.showPreferencesModule(with: configurationStorage)
            }
        }
    }
}
