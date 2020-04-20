//
//  RNJuno.m
//
//  Created by Rafael Althaus on 18/04/20.
//

#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(RNJuno, NSObject)

+ (BOOL)requiresMainQueueSetup {
    return YES;
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

RCT_EXTERN_METHOD(initialize:(NSString *)publicToken
                  production:(BOOL *)production)

RCT_EXTERN_METHOD(getCardHash:(NSString *)cardNumber
                  holderName:(NSString *)holderName
                  securityCode:(NSString *)securityCode
                  expirationMonth:(NSString *)expirationMonth
                  expirationYear:(NSString *)expirationYear
                  callback:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(isValidCardNumber:(NSString *)cardNumber
                  callback:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(isValidExpireDate:(NSString *)month
                  year:(NSString *)year
                  callback:(RCTResponseSenderBlock)callback)

RCT_EXTERN_METHOD(isValidSecurityCode:(NSString *)code
                  cardNumber:(NSString *)cardNumber
                  callback:(RCTResponseSenderBlock)callback)

@end
