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
    
    public func filesListFolder(path path: String, completion:(result: Array<String>?) -> Void) {
        if let client = Dropbox.authorizedClient {
            client.filesListFolder(path: path).response { response, error in
                if let result = response {
                    var results = Array<String>()
                    for entry in result.entries {
                        results.append(entry.name)
                    }
                    completion(result: results)
                } else {
                    print(error!)
                    completion(result: nil)
                }
            }
        }
    }
    
    public func filesDownload(path path: String, completion:(result: NSData?) -> Void) {
        if let client = Dropbox.authorizedClient {
            client.filesDownload(path: path).response { response, error in
                if let (_, data) = response {
                    completion(result: data)
                } else {
                    print(error!)
                    completion(result: nil)
                }
            }
        }
    }
    
    public func filesUpload(path path: String, fileData: NSData, completion:(success: Bool) -> Void) {
        if let client = Dropbox.authorizedClient {
            client.filesUpload(path: path, body: fileData).response { response, error in
                if let _ = response {
                    completion(success: true)
                } else {
                    print(error!)
                    completion(success: false)
                }
            }
        }
    }
    
    public func filesCreateFolder(path path: String, completion:(success: Bool) -> Void) {
        if let client = Dropbox.authorizedClient {
            client.filesCreateFolder(path: path).response { response, error in
                if let _ = response {
                    completion(success: true)
                } else {
                    print(error!)
                    completion(success: false)
                }
            }
        }
    }
    
    public func filesDelete(path path: String, completion:(success: Bool) -> Void) {
        if let client = Dropbox.authorizedClient {
            client.filesDelete(path: path).response { response, error in
                if let _ = response {
                    completion(success: true)
                } else {
                    print(error!)
                    completion(success: false)
                }
            }
        }
    }
    
    public func filesCopy(fromPath fromPath: String, toPath: String, completion:(success: Bool) -> Void) {
        if let client = Dropbox.authorizedClient {
            client.filesCopy(fromPath: fromPath, toPath: toPath).response { response, error in
                if let _ = response {
                    completion(success: true)
                } else {
                    print(error!)
                    completion(success: false)
                }
            }
        }
    }
    
    public func filesMove(fromPath fromPath: String, toPath: String, completion:(success: Bool) -> Void) {
        if let client = Dropbox.authorizedClient {
            client.filesMove(fromPath: fromPath, toPath: toPath).response { response, error in
                if let _ = response {
                    completion(success: true)
                } else {
                    print(error!)
                    completion(success: false)
                }
            }
        }
    }
}
