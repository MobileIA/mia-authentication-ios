//
//  MobileiaAuthentication.swift
//  Show Prode
//
//  Created by Matias Camiletti on 11/3/18.
//  Copyright © 2018 Matias Camiletti. All rights reserved.
//

import Foundation
import MobileiaCore
import Alamofire

open class MobileiaAuthentication{
    
    public init(){}
    
    open func signInWith(service: MIAAuthBaseService, callback: @escaping (_ object: MIAUser) -> Void, callbackError: @escaping (_ error: MIAErrorRest) -> Void){
        // Iniciamos proceso de inicio de sesion.
        service.signIn(callback: callback, callbackError: callbackError);
    }
    
    open func getCurrentUser() -> MIAUser? {
        // Devolver usuario logueado si exite
        return MIAAuthRealm().fetchUser();
    }
    
    open func updateUser(user: MIAUser, callback: @escaping (_ object: MIAUser) -> Void){
        MIAAuthRest().update(accessToken: getAccessToken(), user: user, callback: { (updateUser) in
            // Guardar en la DB interna
            MIAAuthRealm().updateUser(entity: user);
            // Llamar al callback
            callback(updateUser);
        }) { (error) in
            
        };
    }
    
    open func syncProfile(){
        MIAAuthRest().me(accessToken: getAccessToken(), callback: { (user) in
            
        }) { (error) in
            
        };
    }
    
    open func getAccessToken() -> String {
        let user = self.getCurrentUser();
        if(user != nil){
            return (user?.access_token)!;
        }
        return "";
    }
    
    open func logout() {
        let user = self.getCurrentUser();
        if(user != nil){
            MIAAuthRealm().delete(entity: user!);
            //MIAAuthRealm().deleteAllUsers();
            MIAAuthRealm().deleteAll();
        }
    }
    
    open func signInWithEmail(email: String, password: String){
        let parameters = [
            "grant_type": "normal",
            "email": email,
            "password": password
        ] as Parameters;
        
        MIAAuthRest().oauth(parameters: parameters, callback: { (object) in
            print("Se logueo correctamente: " + object.access_token);
        }) { (error) in
            print("No pudo loguearse");
        };
    }
}
