//
//  Owner.swift
//  DemoRest
//
//  Created by Dobariya, Chetankumar || mytheresa.com on 20.10.18.
//  Copyright © 2018 Chetan Dobariya. All rights reserved.
//

import Foundation
import ObjectMapper

struct Owner {
    
    enum JSONKeys: String {
        
        case login
        case id
        case avatarUrl = "avatar_url"
        case gravatarId = "gravatar_id"
        case url
        case htmlUrl = "html_url"
        case followersUrl = "followers_url"
        case followingUrl = "following_url"
        case gistsUrl = "gists_url"
        case starredUrl = "starred_url"
        case subscriptionsUrl = "subscriptions_url"
        case organizationsUrl = "organizations_url"
        case reposUrl = "repos_url"
        case eventsUrl = "events_url"
        case receivedEventsUrl = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
    
    private (set) var id: Int?
    private (set) var login: String?
    private (set) var avatarUrl: URL?
    private (set) var gravatarId: String?
    private (set) var url: URL?
    private (set) var htmlUrl: URL?
    private (set) var followersUrl: URL?
    private (set) var followingUrl: URL?
    private (set) var gistsUrl: URL?
    private (set) var subscriptionsUrl: URL?
    private (set) var starredUrl: URL?
    private (set) var organizationsUrl: URL?
    private (set) var reposUrl: URL?
    private (set) var eventsUrl: URL?
    private (set) var receivedEventsUrl: URL?
    private (set) var type: String?
    private (set) var siteAdmin: Bool?
}

extension Owner: Mappable {
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        self.id <- map[JSONKeys.id.rawValue]
        self.login <- map[JSONKeys.login.rawValue]
        self.avatarUrl <- (map[JSONKeys.avatarUrl.rawValue], URLTransform())
        self.gravatarId <- map[JSONKeys.gravatarId.rawValue]
        self.url <- (map[JSONKeys.url.rawValue], URLTransform())
        self.htmlUrl <- (map[JSONKeys.htmlUrl.rawValue], URLTransform())
        self.followersUrl <- (map[JSONKeys.followersUrl.rawValue], URLTransform())
        self.followingUrl <- (map[JSONKeys.followingUrl.rawValue], URLTransform())
        self.gistsUrl <- (map[JSONKeys.gistsUrl.rawValue], URLTransform())
        self.organizationsUrl <- (map[JSONKeys.organizationsUrl.rawValue], URLTransform())
        self.subscriptionsUrl <- (map[JSONKeys.subscriptionsUrl.rawValue], URLTransform())
        self.starredUrl <- (map[JSONKeys.starredUrl.rawValue], URLTransform())
        self.reposUrl <- (map[JSONKeys.reposUrl.rawValue], URLTransform())
        self.eventsUrl <- (map[JSONKeys.eventsUrl.rawValue], URLTransform())
        self.receivedEventsUrl <- (map[JSONKeys.receivedEventsUrl.rawValue], URLTransform())
        self.type <- map[JSONKeys.type.rawValue]
        self.siteAdmin <- map[JSONKeys.siteAdmin.rawValue]
    }
}
