//
//  DetailViewController.swift
//  GalaxyMarket
//
//  Created by Ozan Asan on 26/05/15.
//  Copyright (c) 2015 OzanAsan. All rights reserved.
//

import UIKit
import PassKit


class DetailViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
    
    let SupportedPaymentNetworks = [PKPaymentNetworkVisa, PKPaymentNetworkMasterCard, PKPaymentNetworkAmex]
    let GalaxyMerchantID = "merchant.com.ozan.asan"
    
    @IBOutlet weak var dImage: UIImageView!
    var DetailItem : GalaxyItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dImage.image = DetailItem?.ItemImage
        self.navigationItem.title = "\(DetailItem!.ItemName) - \(DetailItem!.ItemPrice)$"
    }
    
    func createStripeTestPaymentCard() -> STPCard {
        let card = STPCard()
        card.number = "4242424242424242"; card.expMonth = 12; card.expYear = 2020; card.cvc = "123"
        return card
    }
    
    func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didAuthorizePayment payment: PKPayment!, completion: ((PKPaymentAuthorizationStatus) -> Void)!) {
        Stripe.setDefaultPublishableKey("pk_test_XQBX3iYDX6ldrq92uXvFEh9U")
        let testCard = createStripeTestPaymentCard()
        
        STPAPIClient.sharedClient().createTokenWithCard(testCard,
            completion: {(token, error) -> Void in
                if(error != nil) {
                    println("There is an error \(error)")
                    completion(PKPaymentAuthorizationStatus.Failure)
                }
        
                let url = NSURL(string: "http://ozandeneme.herokuapp.com/pay")
                let request = NSMutableURLRequest(URL: url!)
                request.HTTPMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                
                let body = ["stripeToken": token!.tokenId,
                    "amount": NSDecimalNumber(integer : self.DetailItem!.ItemPrice * 100), //because we sent amount in cents.
                    "description": self.DetailItem!.ItemName,
                    "shipping": [
                        "city": "Santa Clara",
                        "state": "CA",
                        "zip": "95050",
                        "firstName": "Ozan",
                        "lastName": "Asan"]
                ]
                
                var error: NSError?
                request.HTTPBody = NSJSONSerialization.dataWithJSONObject(body, options: NSJSONWritingOptions(), error: &error)
                
                // 7
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                    if (error != nil) {
                        completion(PKPaymentAuthorizationStatus.Failure)
                    } else {
                        completion(PKPaymentAuthorizationStatus.Success)
                    }
                }
        })
    }
    
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didSelectShippingAddress address: ABRecord!, completion: ((PKPaymentAuthorizationStatus, [AnyObject]!, [AnyObject]!) -> Void)!) {
        let b = 2
    }
    
    func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController!, didSelectShippingMethod shippingMethod: PKShippingMethod!, completion: ((PKPaymentAuthorizationStatus, [AnyObject]!) -> Void)!) {
        let a = 3
    }
    
    @IBAction func purchase(sender: AnyObject) {
        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = GalaxyMerchantID
        paymentRequest.supportedNetworks = SupportedPaymentNetworks
        paymentRequest.merchantCapabilities = PKMerchantCapability.Capability3DS
        paymentRequest.countryCode = "US"
        paymentRequest.currencyCode = "USD"
        
        
        if let GalaxyItem = DetailItem {
            paymentRequest.paymentSummaryItems = [ PKPaymentSummaryItem(label: GalaxyItem.ItemName, amount: NSDecimalNumber(integer: GalaxyItem.ItemPrice)), PKPaymentSummaryItem(label: "Shipping", amount : 4), PKPaymentSummaryItem(label : "Galaxy Market", amount: NSDecimalNumber(integer: GalaxyItem.ItemPrice + 4) ) ]
        }
        
        
        // TRying
        
        let freeAmount = NSDecimalNumber(integer: 0)
        let freeShipping  : PKShippingMethod = PKShippingMethod(label: "Free Shipping", amount: 5)
        paymentRequest.shippingMethods = [freeShipping ]
        
        /*
        NSDecimalNumber *freeAmount = [NSDecimalNumber decimalNumberWithString:@"0.00"];
        PKShippingMethod *freeShipping = [PKShippingMethod summaryItemWithLabel:@"Free Shipping" amount:freeAmount];
        freeShipping.detail = @"Arrives by July 2";
        freeShipping.identifier = @"free";
        
        NSDecimalNumber *standardAmount = [NSDecimalNumber decimalNumberWithString:@"3.21"];
        PKShippingMethod *standardShipping = [PKShippingMethod summaryItemWithLabel:@"Standard Shipping" amount:standardAmount];
        standardShipping.detail = @"Arrives by June 29";
        standardShipping.identifier = @"standard";
        
        NSDecimalNumber *expressAmount = [NSDecimalNumber decimalNumberWithString:@"24.63"];
        PKShippingMethod *expressShipping = [PKShippingMethod summaryItemWithLabel:@"Express Shipping" amount:expressAmount];
        expressShipping.detail = @"Ships within 24 hours";
        expressShipping.identifier = @"express";
        
        paymentRequest.shippingMethods = @[freeShipping, standardShipping, expressShipping];
        
        paymentRequest.shippingMethods = []
        
        */

        //with apple examoek
        
        
        
        
        let applePayController = STPTestPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        //let applePayController = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest))
        applePayController.delegate = self
        self.presentViewController(applePayController, animated: true, completion: nil)
    }

}
