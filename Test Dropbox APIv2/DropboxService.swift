//
//  DropboxService.swift
//  Test Dropbox APIv2
//
//  Created by Freek Sanders on 08-10-15.
//  Copyright © 2015 Freek Sanders. All rights reserved.
//

import Foundation
import SwiftyDropbox

public class DropboxService : NSObject {
    public func setupWithAppKey(key: String) {
        Dropbox.setupWithAppKey(key)
    }
    
    public func link(controller: UIViewController) {
        if (Dropbox.authorizedClient == nil) {
            Dropbox.authorizeFromController(controller)
        } else {
            print("User is already authorized!")
        }
    }
    
    public func unlink() {
        Dropbox.unlinkClient()
    }
    
    public func handleRedirectURL(url: NSURL) -> Bool {
        if let authResult = Dropbox.handleRedirectURL(url) {
            switch authResult {
            case .Success:
                return true
            case .Error:
                return false
            }
        }
        return false
    }
    
    public func autorizedClient() -> DropboxClient? {
        return Dropbox.authorizedClient
    }
    
    public func filesListFolder(path path: String, recursive: Bool = false) -> NSArray? {
        if let client = Dropbox.authorizedClient {
            client.filesListFolder(path: "").response { response, error in
                if let result = response {
                    print("Folder contents:")
                    for entry in result.entries {
                        print(entry.name)
                    }
                } else {
                    print(error!)
                }
            }
        }
        return nil
    }
    
    public func filesDownload() {
        if let client = Dropbox.authorizedClient {
            client.filesDownload(path: "/hello.txt").response { response, error in
                if let (metadata, data) = response {
                    print("Dowloaded file name: \(metadata.name)")
                    print("Downloaded file data: \(data)")
                } else {
                    print(error!)
                }
            }
        }
    }
    
    public func filesUpload() {
        if let client = Dropbox.authorizedClient {
            let fileData = "Hello!".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
            client.filesUpload(path: "/hello.txt", body: fileData!).response { response, error in
                if let metadata = response {
                    print("Uploaded file name: \(metadata.name)")
                    print("Uploaded file revision: \(metadata.rev)")
                    
                    // Get file (or folder) metadata
                    client.filesGetMetadata(path: "/hello.txt").response { response, error in
                        if let metadata = response {
                            print("Name: \(metadata.name)")
                            if let file = metadata as? Files.FileMetadata {
                                print("This is a file.")
                                print("File size: \(file.size)")
                            } else if let folder = metadata as? Files.FolderMetadata {
                                print("This is a folder: \(folder.name)")
                            }
                        } else {
                            print(error!)
                        }
                    }
                } else {
                    print(error!)
                }
            }
        }
    }
    
    public func filesCreateFolder(path path: String) {
        if let client = Dropbox.authorizedClient {
            client.filesCreateFolder(path: path).response { response, error in
                if let result = response {
                    print("created \(result.name)")
                } else {
                    print(error!)
                }
            }
        }
    }
    
    public func filesDelete(path path: String) {
        if let client = Dropbox.authorizedClient {
            client.filesDelete(path: path).response { response, error in
                if let result = response {
                    print("deleted \(result.name)")
                } else {
                    print(error!)
                }
            }
        }
    }
    
    public func filesCopy(fromPath fromPath: String, toPath: String) {
        if let client = Dropbox.authorizedClient {
            client.filesCopy(fromPath: fromPath, toPath: toPath).response { response, error in
                if let result = response {
                    print("copied \(result.name)")
                } else {
                    print(error!)
                }
            }
        }
    }
    
    public func filesMove(fromPath fromPath: String, toPath: String) {
        if let client = Dropbox.authorizedClient {
            client.filesMove(fromPath: fromPath, toPath: toPath).response { response, error in
                if let result = response {
                    print("moved \(result.name)")
                } else {
                    print(error!)
                }
            }
        }
    }
}
