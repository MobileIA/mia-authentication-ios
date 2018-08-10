//
//  User.swift
//  Show Prode
//
//  Created by Matias Camiletti on 11/3/18.
//  Copyright © 2018 Matias Camiletti. All rights reserved.
//

import Foundation
import RealmSwift

open class MIAUser : Object, Decodable {
    @objc open dynamic var id = 0;
    @objc open dynamic var app_id = 0;
    @objc open dynamic var access_token = "";
    @objc open dynamic var email = "";
    @objc open dynamic var firstname = "";
    @objc open dynamic var lastname = "";
    @objc open dynamic var photo = "";
    @objc open dynamic var phone = "";
    @objc open dynamic var created_at = "";
    open var fullname: String { // read-only properties are automatically ignored
        return "\(firstname) \(lastname)"
    }
    
    open override static func primaryKey() -> String? {
        return "id"
    }
    
    enum MIAUserEnum: String, CodingKey {
        case id
        case app_id
        case email
        case firstname
        case lastname
        case photo
        case phone
        case created_at
     }
     
     open required convenience init(from decoder: Decoder) throws {
        self.init();
        let container = try decoder.container(keyedBy: MIAUserEnum.self);
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
        email = try container.decode(String.self, forKey: .email)
        firstname = try container.decode(String.self, forKey: .firstname)
        lastname = try container.decode(String.self, forKey: .lastname)
        photo = try container.decode(String.self, forKey: .photo)
        phone = try container.decode(String.self, forKey: .phone)
        created_at = try container.decode(String.self, forKey: .created_at)
     }
}
