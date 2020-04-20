//
//  RNJuno.swift
//
//  Created by Rafael Althaus on 18/04/20.
//

import Foundation
import DirectCheckout

@objc(RNJuno)
class RNJuno: NSObject {
   
  @objc(initialize: production:)
  func initialize(publicToken: String, production: Bool) {
    DirectCheckout.initialize(publicToken: publicToken, environment: (production ? APIEnvionment.production : APIEnvionment.sandbox))
  }
  
  @objc(getCardHash: holderName: securityCode: expirationMonth: expirationYear: callback:)
  func getCardHash(cardNumber: String, holderName: String, securityCode:String, expirationMonth:String, expirationYear:String, _ callback:@escaping RCTResponseSenderBlock) {
      let card = Card(cardNumber:cardNumber,
                    holderName:holderName,
                    securityCode:securityCode,
                    expirationMonth:expirationMonth,
                    expirationYear:expirationYear)

      DirectCheckout.getCardHash(card) { result in
          do {
              let hash = try result.get()
              callback([NSNull(), hash])
          } catch let error {
              callback([error.localizedDescription, NSNull()])
          }
      }
  }
  
  @objc(isValidCardNumber: callback:)
  func isValidCardNumber(cardNumber:String, _ callback:RCTResponseSenderBlock) {
    callback([DirectCheckout.isValidCardNumber(cardNumber)])
  }
  
  @objc(isValidExpireDate: year: callback:)
  func isValidExpireDate(month:String, year:String, _ callback:RCTResponseSenderBlock) {
    callback([DirectCheckout.isValidExpireDate(month: month, year: year)])
  }
  
  @objc(isValidSecurityCode: cardNumber: callback:)
  func isValidSecurityCode(code:String, cardNumber:String, _ callback:RCTResponseSenderBlock) {
    callback([DirectCheckout.isValidSecurityCode(code, cardNumber)])
  }
  
}
