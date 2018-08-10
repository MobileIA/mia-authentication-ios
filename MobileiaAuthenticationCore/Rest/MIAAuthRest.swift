//
//  MIAAuthRest.swift
//  Show Prode
//
//  Created by Matias Camiletti on 11/3/18.
//  Copyright © 2018 Matias Camiletti. All rights reserved.
//

import Foundation
import Alamofire
import MobileiaCore

open class MIAAuthRest : MIABaseRest {
    
    open func oauth(parameters : Parameters, callback: @escaping (_ object: MIAAccessToken) -> Void, callbackError: @escaping (_ error: MIAErrorRest) -> Void) -> Void{
        // Procesamos los parametros
        let parameters = processParameters(parameters: parameters);
        // Ejecutamos llamada
        execute("api/oauth", method: .post, parameters: parameters, callback: callback, callbackError: callbackError);
    }
    
    open func register(parameters : Parameters, callback: @escaping (_ object: MIAUser) -> Void, callbackError: @escaping (_ error: MIAErrorRest) -> Void) -> Void{
        // Procesamos los parametros
        let parameters = processParameters(parameters: parameters);
        // Ejecutamos llamada
        execute("api/register", method: .post, parameters: parameters, callback: callback, callbackError: callbackError);
    }
    
    open func update(accessToken : String, user: MIAUser, callback: @escaping (_ object: MIAUser) -> Void, callbackError: @escaping (_ error: MIAErrorRest) -> Void) -> Void{
        // Procesamos los parametros
        var parameters = processParameters(parameters: [:]);
        parameters["access_token"] = accessToken;
        parameters["firstname"] = user.firstname;
        parameters["lastname"] = user.lastname;
        parameters["photo"] = user.photo;
        parameters["phone"] = user.phone;
        // Ejecutamos llamada
        execute("api/update", method: .post, parameters: parameters, callback: callback, callbackError: callbackError);
    }
    
    open func me(accessToken : String, callback: @escaping (_ object: MIAUser) -> Void, callbackError: @escaping (_ error: MIAErrorRest) -> Void) -> Void{
        // Procesamos los parametros
        var parameters = processParameters(parameters: [:]);
        parameters["access_token"] = accessToken;
        // Ejecutamos llamada
        execute("api/me", method: .post, parameters: parameters, callback: { (object:MIAUser) in
            // Guardamos el AccessToken
            object.access_token = accessToken;
            // Guardamos usuario en la DB
            MIAAuthRealm().save(entity: object);
            // Llamamos al callback con exito
            callback(object);
            
        }, callbackError: callbackError);
    }
    
    open func processParameters(parameters : Parameters) -> Parameters {
        var parameters = parameters;
        parameters["app_id"] = Mobileia.getInstance().appId;
        parameters["device_token"] = Mobileia.getInstance().deviceToken;
        parameters["device_model"] = UIDevice.current.model;
        parameters["platform"] = 1;
        parameters["language"] = Locale.current.languageCode;
        parameters["version"] = "1.0";
        return parameters;
    }
    
    open override func getBaseUrl() -> String {
        return "https://authentication.mobileia.com/";
    }
}
