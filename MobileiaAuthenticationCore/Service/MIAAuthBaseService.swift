//
//  MIAAuthBaseService.swift
//  Show Prode
//
//  Created by Matias Camiletti on 12/3/18.
//  Copyright © 2018 Matias Camiletti. All rights reserved.
//

import UIKit
import MobileiaCore

open class MIAAuthBaseService : NSObject {
    
    open var accessToken : String = "";
    
    open var callbackSuccess : ((_ object: MIAUser) -> Void)?;
    open var callbackError : ((_ error: MIAErrorRest) -> Void)?;
    
    open var callbackAccessTokenSuccess : ((_ object: MIAAccessToken) -> Void)?;
    open var callbackAccessTokenError : ((_ error: MIAErrorRest) -> Void)?;
    
    open var callbackNewAccountSuccess : ((_ object: MIAUser) -> Void)?;
    
    public required override init() {
        super.init();
        // Creamos callback requeridos para obtener accessToken
        self.callbackAccessTokenSuccess = { (object:MIAAccessToken) in
            // Guardar AccessToken
            self.accessToken = object.access_token;
            // realizamos peticion del perfil del usuario
            self.requestProfile();
        };
        self.callbackAccessTokenError = { (error: MIAErrorRest) in
            // Verificamos si no se pudo loguear porque la cuenta no existe
            if(error.code == 414){
                // Creamos una nueva cuenta ya que es la primera vez que se loguea
                self.requestNewAccount();
            }else{
                // No se pudo loguear por otro motivo
                self.callbackError!(error);
            }
        };
        // Creamos callback requeridos para registrar nuevas cuentas
        self.callbackNewAccountSuccess = { (object:MIAUser) in
            // Al registrar una nueva cuenta realizamos el login por default
            self.requestAccessToken();
        };
    }
    
    open func requestAccessToken() {
        
    }
    
    open func requestNewAccount() {
        
    }
    
    open func requestProfile(){
        // Buscamos datos del usuario
        MIAAuthRest().me(accessToken: self.accessToken, callback: self.callbackSuccess!, callbackError: self.callbackError!);
    }
    
    open func signIn(callback: @escaping (_ object: MIAUser) -> Void, callbackError: @escaping (_ error: MIAErrorRest) -> Void){
        // Guardamos callback
        self.callbackSuccess = callback;
        self.callbackError = callbackError;
        // Iniciamos proceso de inicio de sesion del servicio en cuestion
        startSignIn();
    }
    
    open func startSignIn() {
        
    }
    
}
