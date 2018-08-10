//
//  MIAAuthRealm.swift
//  Show Prode
//
//  Created by Matias Camiletti on 11/3/18.
//  Copyright © 2018 Matias Camiletti. All rights reserved.
//

import Foundation
import MobileiaCore
import RealmSwift

open class MIAAuthRealm : MIABaseRealm {
 
    open func updateUser(entity: MIAUser){
        let realm = getRealm();
        let current = fetchUser()!;
        try! realm.write {
            current.firstname = entity.firstname;
            current.lastname = entity.lastname;
            current.photo = entity.photo;
            current.phone = entity.phone;
        }
    }
    
    open func fetchUser() -> MIAUser? {
        let realm = getRealm();
        let users = realm.objects(MIAUser.self);
        return users.first;
    }
    
    open func deleteAllUsers(){
        let realm = getRealm();
        let users = realm.objects(MIAUser.self);
        realm.delete(users);
    }
    
    open override func getNameFile() -> String {
        return "mobileia_authentication_" + String(Mobileia.getInstance().appId);
    }
    
    open override func getObjectTypes() -> [Object.Type] {
        return [MIAUser.self];
    }
}
