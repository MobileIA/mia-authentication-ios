//
//  MIAAccessToken.swift
//  Show Prode
//
//  Created by Matias Camiletti on 11/3/18.
//  Copyright © 2018 Matias Camiletti. All rights reserved.
//

import Foundation
import RealmSwift

open class MIAAccessToken : Object, Decodable {
    @objc open dynamic var id = 0;
    @objc open dynamic var app_id = 0;
    @objc open dynamic var user_id = 0;
    @objc open dynamic var access_token = "";
    //@objc dynamic var expires = "";
    //@objc dynamic var scope = "";
    
    open override static func primaryKey() -> String? {
        return "id"
    }
    
    enum MIAAccessTokenEnum: String, CodingKey {
        case id
        case app_id
        case user_id
        case access_token
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init();
        let container = try decoder.container(keyedBy: MIAAccessTokenEnum.self);
        do{
            id = try container.decode(Int.self, forKey: .id)
        }catch{
            id = Int(try container.decode(String.self, forKey: .id))!;
        }
        do{
            app_id = try container.decode(Int.self, forKey: .app_id)
        }catch{
            app_id = Int(try container.decode(String.self, forKey: .app_id))!;
        }
        do{
            user_id = try container.decode(Int.self, forKey: .user_id)
        }catch{
            user_id = Int(try container.decode(String.self, forKey: .user_id))!;
        }
        access_token = try container.decode(String.self, forKey: .access_token)
    }
}

