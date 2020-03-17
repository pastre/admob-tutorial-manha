//
//  ViewController.swift
//  tutorial-admob
//
//  Created by Bruno Pastre on 17/03/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {

    var rewardedAd: GADRewardedAd!
    var ad: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton(frame: self.view.frame)
        
        self.view.addSubview(button)
        
        button.setTitle("Mostra ai", for: .normal)
        self.view.backgroundColor = .blue
        button.addTarget(self, action: #selector(self.onDisplayAd), for: .touchDown)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadAd()
    }
    
    @objc func onDisplayAd()  {
        self.presentAd()
    }


}

extension ViewController: GADRewardedAdDelegate {
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        print("O usuario ganhou", reward.amount, reward.type)
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        self.loadAd()
    }
    
    func loadAd() {
        let id = "ca-app-pub-3760704996981292/2151153210"
//        let id = "ca-app-pub-3940256099942544/1712485313"
        let newAd = GADRewardedAd(adUnitID: id)
        
        newAd.load(GADRequest()) { (error) in
            if let error = error {
                print("Erro ao carregar o ad!")
                return
            }
            
            print("Loaded ad!")
        }
        
        self.rewardedAd = newAd
        
    }
    
    func presentAd() {
        guard self.rewardedAd.isReady else {
            print("Sem ad!")
            return
        }
        self.rewardedAd.present(fromRootViewController: self, delegate: self)
    }
    
}


extension ViewController: GADInterstitialDelegate {

        
        func loadInterAd() {
    //        let id = "ca-app-pub-3760704996981292/1312714262" // REAL AD
            print("Loaded ad")
            let id = "ca-app-pub-3940256099942544/4411468910" // TEST AD
            let newAd = GADInterstitial(adUnitID: id)
            
            newAd.delegate = self
            newAd.load(GADRequest())
            
            self.ad = newAd
        }
        
        func presentInterAd() {
            guard self.ad.isReady else { return }
            
            self.ad.present(fromRootViewController: self)
        }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("Failed to receive ad!", error)
    }
    
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.loadAd()
    }
    
}
