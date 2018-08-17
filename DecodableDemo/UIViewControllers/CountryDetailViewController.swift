//
//  CountryDetailViewController.swift
//  DecodableDemo
//
//  Created by Harsh Prajapati on 13/08/18.
//  Copyright © 2018 Mobio. All rights reserved.
//

import UIKit
import WebKit

class CountryDetailViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var lblNativeName: UILabel!
    
    @IBOutlet weak var lblCapital: UILabel!
    @IBOutlet weak var lblRegion: UILabel!
    
    
    @IBOutlet weak var lblPopulation: UILabel!
    @IBOutlet weak var lblArea: UILabel!
    
    @IBOutlet weak var lblCallingCodes: UILabel!
    
    var countryData = Country()
    
    // MARK: - UIViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.countryData.name ?? ""
        
        let url = URL(string: self.countryData.flag ?? "")!
        webView.load(URLRequest(url: url))
        
        self.lblNativeName.text = "NativeName: " + self.countryData.nativeName!
        
        self.lblCapital.text = "Capital: " + self.countryData.capital!
        self.lblRegion.text = "Region: " + self.countryData.region!
        
        self.lblPopulation.text = "Population: " + "\(self.countryData.population ?? 0)"
        self.lblArea.text = "Area: " + "\(self.countryData.area ?? 0)"
        
        self.lblCallingCodes.text = "CallingCodes: " + (self.countryData.callingCodes?.joined(separator: ", "))!
        
    }
}
