//
//  RCTCardIO.m
//  RCTCardIO
//
//  Created by Roger Chapman on 3/10/2015.
//  Copyright © 2015 Kayla Technologies. All rights reserved.
//

#import "RCTCardIOView.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@implementation RCTConvert (CardIODetectionMode)
RCT_ENUM_CONVERTER(CardIODetectionMode, (@{
                                           @"cardImageAndNumber" : @(CardIODetectionModeCardImageAndNumber),
                                           @"cardImageOnly" : @(CardIODetectionModeCardImageOnly),
                                           @"automatic" : @(CardIODetectionModeAutomatic)
                                           }), CardIODetectionModeCardImageAndNumber, integerValue);
@end

@implementation RCTCardIOView {
    CardIOView *cardIOView;
}

@synthesize bridge, methodQueue;

RCT_EXPORT_MODULE();

RCT_EXPORT_VIEW_PROPERTY(hidden, BOOL);
RCT_EXPORT_VIEW_PROPERTY(languageOrLocale, NSString);
RCT_EXPORT_VIEW_PROPERTY(guideColor, UIColor);
RCT_EXPORT_VIEW_PROPERTY(useCardIOLogo, BOOL);
RCT_EXPORT_VIEW_PROPERTY(hideCardIOLogo, BOOL);
RCT_EXPORT_VIEW_PROPERTY(allowFreelyRotatingCardGuide, BOOL);
RCT_EXPORT_VIEW_PROPERTY(scanInstructions, NSString);
RCT_EXPORT_VIEW_PROPERTY(scanOverlayView, UIView);
RCT_EXPORT_VIEW_PROPERTY(scanExpiry, BOOL);
RCT_EXPORT_VIEW_PROPERTY(scannedImageDuration, CGFloat);
RCT_EXPORT_VIEW_PROPERTY(detectionMode, CardIODetectionMode);

static id ObjectOrNull(id object) {
    return object ?: [NSNull null];
}

-(UIView *)view {
    cardIOView = [[CardIOView alloc] init];
    cardIOView.delegate = self;
    return cardIOView;
}

-(void)cardIOView:(CardIOView *)_cardIOView didScanCard:(CardIOCreditCardInfo *)cardInfo {
    NSString *cardType = [CardIOCreditCardInfo displayStringForCardType: cardInfo.cardType
                                                  usingLanguageOrLocale: _cardIOView.languageOrLocale];
    UIImage *cardLogo = [CardIOCreditCardInfo logoForCardType:cardInfo.cardType];
    
    [self.bridge.eventDispatcher
     sendAppEventWithName:@"didScanCard"
     body:@{
            @"cardNumber": ObjectOrNull(cardInfo.cardNumber),
            @"redactedCardNumber": ObjectOrNull(cardInfo.redactedCardNumber),
            @"expiryMonth": ObjectOrNull(@(cardInfo.expiryMonth)),
            @"expiryYear": ObjectOrNull(@(cardInfo.expiryYear)),
            @"cvv": ObjectOrNull(cardInfo.cvv),
            @"postalCode": ObjectOrNull(cardInfo.postalCode),
            @"scanned": @(cardInfo.scanned),
            @"cardImage": [UIImagePNGRepresentation(cardInfo.cardImage) base64EncodedStringWithOptions:kNilOptions],
            @"cardType": cardType,
            @"logoForCardType": [UIImagePNGRepresentation(cardLogo) base64EncodedStringWithOptions:kNilOptions]
            }];
}

@end
