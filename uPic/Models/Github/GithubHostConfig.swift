//
//  GithubHostConfig.swift
//  uPic
//
//  Created by Svend Jin on 2019/6/29.
//  Copyright © 2019 Svend Jin. All rights reserved.
//

import Foundation
import SwiftyJSON

@objcMembers
class GithubHostConfig: HostConfig {
    dynamic var owner: String! = ""
    dynamic var repo: String! = ""
    dynamic var branch: String! = "master"
    dynamic var token: String!
    dynamic var domain: String?
    dynamic var folder: String?
    dynamic var saveKey: String! = HostSaveKey.filename.rawValue
    
    override func displayName(key: String) -> String {
        switch key {
        case "owner":
            return NSLocalizedString("host.field.owner", comment: "owner")
        case "repo":
            return NSLocalizedString("host.field.repo", comment: "repo")
        case "branch":
            return NSLocalizedString("host.field.branch", comment: "branch")
        case "token":
            return NSLocalizedString("host.field.token", comment: "token")
        case "domain":
            return NSLocalizedString("host.field.domain", comment: "domain")
        case "folder":
            return NSLocalizedString("host.field.folder", comment: "folder")
        case "saveKey":
            return NSLocalizedString("host.field.saveKey", comment: "fileName")
        default:
            return ""
        }
    }
    
    override func serialize() -> String {
        var dict = Dictionary<String, Any>()
        dict["owner"] = self.owner
        dict["repo"] = self.repo
        dict["branch"] = self.branch
        dict["token"] = self.token
        dict["domain"] = self.domain
        dict["folder"] = self.folder
        dict["saveKey"] = self.saveKey
        
        return JSON(dict).rawString()!
    }
    
    static func deserialize(str: String?) -> GithubHostConfig? {
        let config = GithubHostConfig()
        guard let str = str else {
            return config
        }
        let data = str.data(using: String.Encoding.utf8)
        let json = try! JSON(data: data!)
        config.owner = json["owner"].stringValue
        config.repo = json["repo"].stringValue
        config.branch = json["branch"].stringValue
        config.token = json["token"].stringValue
        config.domain = json["domain"].stringValue
        config.folder = json["folder"].stringValue
        config.saveKey = json["saveKey"].stringValue
        return config
    }
}
