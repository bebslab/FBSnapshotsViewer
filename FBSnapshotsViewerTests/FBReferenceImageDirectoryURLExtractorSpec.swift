//
//  FBReferenceImageDirectoryURLExtractorSpec.swift
//  FBSnapshotsViewerTests
//
//  Created by Anton Domashnev on 24.06.17.
//  Copyright © 2017 Anton Domashnev. All rights reserved.
//

import Quick
import Nimble

@testable import FBSnapshotsViewer

class XcodeFBReferenceImageDirectoryURLExtractorSpec: QuickSpec {
    override func spec() {
        var extractor: XcodeFBReferenceImageDirectoryURLExtractor!
        
        beforeEach {
            extractor = XcodeFBReferenceImageDirectoryURLExtractor()
        }
        
        describe(".extractImageDirectoryURL") {
            context("when unexpected log line is given") {
                it("throws an error") {
                    expect { try extractor.extractImageDirectoryURL(from: ApplicationLogLine.kaleidoscopeCommandMessage(line: "ksdiff \"/Users/antondomashnev/Library/Developer/CoreSimulator/Devices/B1AC0517-7FC0-4B32-8543-9EC263071FE5/data/Containers/Data/Application/8EEE157C-41B9-47F8-8634-CF3D60962E19/tmp/FBSnapshotsViewerExampleTests/reference_testFail@2x.png\" \"/Users/antondomashnev/Library/Developer/CoreSimulator/Devices/B1AC0517-7FC0-4B32-8543-9EC263071FE5/data/Containers/Data/Application/8EEE157C-41B9-47F8-8634-CF3D60962E19/tmp/FBSnapshotsViewerExampleTests/failed_testFail@2x.png\"")) }.to(throwError())
                    
                    expect { try extractor.extractImageDirectoryURL(from: ApplicationLogLine.referenceImageSavedMessage(line: "2017-04-25 21:15:37.107 FBSnapshotsViewerExample[56034:787919] Reference image save at: /Users/antondomashnev/Work/FBSnapshotsViewerExample/FBSnapshotsViewerExampleTests/ReferenceImages_64/FBSnapshotsViewerExampleTests/testRecord@2x.png")) }.to(throwError())
                    
                    expect { try extractor.extractImageDirectoryURL(from: ApplicationLogLine.applicationNameMessage(line: "XCInjectBundleInto = \"/Users/antondomashnev/Library/Developer/Xcode/DerivedData/FBSnapshotsViewerExample-eeuapqepwoebslcfqojhfzyfuhmp/Build/Products/Debug-iphonesimulator/FBSnapshotsViewerExample.app/FBSnapshotsViewerExample\";")) }.to(throwError())
                    
                    expect { try extractor.extractImageDirectoryURL(from: ApplicationLogLine.unknown) }.to(throwError())
                }
            }
            
            context("when fbReferenceImageDirMessage log line given") {
                context("with unexpected format") {
                    it("throws an error") {
                        expect { try extractor.extractImageDirectoryURL(from: ApplicationLogLine.fbReferenceImageDirMessage(line: "XCInjectBundleInto = ")) }.to(throwError())
                    }
                }
                
                context("with expected format") {
                    it("extracts correct application name") {
                        let applicationName = try? extractor.extractImageDirectoryURL(from: ApplicationLogLine.fbReferenceImageDirMessage(line: "\"FB_REFERENCE_IMAGE_DIR\" = \"/Users/antondomashnev/Work/FBSnapshotsViewerExample/FBSnapshotsViewerExampleTests/ReferenceImages\";"))
                        let expectedURL = URL(fileURLWithPath: "/Users/antondomashnev/Work/FBSnapshotsViewerExample/FBSnapshotsViewerExampleTests/ReferenceImages_64", isDirectory: true)
                        expect(applicationName).to(equal(expectedURL))
                    }
                }
            }
        }
    }
}

class AppCodeFBReferenceImageDirectoryURLExtractorSpec: QuickSpec {
    override func spec() {
        var extractor: AppCodeFBReferenceImageDirectoryURLExtractor!
        
        beforeEach {
            extractor = AppCodeFBReferenceImageDirectoryURLExtractor()
        }
        
        describe(".extractImageDirectoryURL") {
            context("when unexpected log line is given") {
                it("throws an error") {
                    expect { try extractor.extractImageDirectoryURL(from: ApplicationLogLine.kaleidoscopeCommandMessage(line: "ksdiff \"/Users/antondomashnev/Library/Developer/CoreSimulator/Devices/B1AC0517-7FC0-4B32-8543-9EC263071FE5/data/Containers/Data/Application/8EEE157C-41B9-47F8-8634-CF3D60962E19/tmp/FBSnapshotsViewerExampleTests/reference_testFail@2x.png\" \"/Users/antondomashnev/Library/Developer/CoreSimulator/Devices/B1AC0517-7FC0-4B32-8543-9EC263071FE5/data/Containers/Data/Application/8EEE157C-41B9-47F8-8634-CF3D60962E19/tmp/FBSnapshotsViewerExampleTests/failed_testFail@2x.png\"")) }.to(throwError())
                    
                    expect { try extractor.extractImageDirectoryURL(from: ApplicationLogLine.kaleidoscopeCommandMessage(line: "2017-04-25 21:15:37.107 FBSnapshotsViewerExample[56034:787919] Reference image save at: /Users/antondomashnev/Work/FBSnapshotsViewerExample/FBSnapshotsViewerExampleTests/ReferenceImages_64/FBSnapshotsViewerExampleTests/testRecord@2x.png")) }.to(throwError())
                    
                    expect { try extractor.extractImageDirectoryURL(from: ApplicationLogLine.applicationNameMessage(line: "<config PASS_PARENT_ENVS_2=\"true\" PROJECT_NAME=\"FBSnapshotsViewerExample\" TARGET_NAME=\"FBSnapshotsViewerExampleTests\" CONFIG_NAME=\"Debug\" SCHEME_NAME=\"FBSnapshotsViewerExampleTests\" TEST_MODE=\"SUITE_TEST\" XCODE_SKIPPED_TESTS_HASH_CODE=\"0\" configId=\"OCUnitRunConfiguration\" name=\"FBSnapshotsViewerExampleTests\" target=\"iphonesimulatoriPhone_7_10.3_x86_64_1\">")) }.to(throwError())
                    
                    expect { try extractor.extractImageDirectoryURL(from: ApplicationLogLine.unknown) }.to(throwError())
                }
            }
            
            context("when fbReferenceImageDirMessage log line given") {
                context("with unexpected format") {
                    it("throws an error") {
                        expect { try extractor.extractImageDirectoryURL(from: ApplicationLogLine.fbReferenceImageDirMessage(line: "XCInjectBundleInto = ")) }.to(throwError())
                    }
                }
                
                context("with expected format") {
                    it("extracts correct application name") {
                        let applicationName = try? extractor.extractImageDirectoryURL(from: ApplicationLogLine.fbReferenceImageDirMessage(line: "            <env name=\"FB_REFERENCE_IMAGE_DIR\" value=\"/Users/antondomashnev/Work/FBSnapshotsViewerExample/FBSnapshotsViewerExampleTests/ReferenceImages\"/>"))
                        let expectedURL = URL(fileURLWithPath: "/Users/antondomashnev/Work/FBSnapshotsViewerExample/FBSnapshotsViewerExampleTests/ReferenceImages_64", isDirectory: true)
                        expect(applicationName).to(equal(expectedURL))
                    }
                }
            }
        }
    }
}
