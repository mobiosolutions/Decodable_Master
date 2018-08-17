//
//  CountryListViewController.swift
//  DecodableDemo
//
//  Created by Apple on 15/06/18.
//  Copyright © 2018 Mobio. All rights reserved.
//

import UIKit

struct Country: Decodable {
    
    var flag: String?
    var name: String?
    
    var nativeName: String?
    var capital: String?
    var region: String?
    
    var population: Double?
    var area: Double?
    
    var callingCodes: [String]?
}

class CountryListViewController: UIViewController {

    // MARK : - Properties
    @IBOutlet var tableCountriesList: UITableView!
    
    var countryList = [Country]()
    
    // MARK : - UIViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getCountryList()
    }
    
    // MARK : - WebService(s)
    func getCountryList() {
     
        //Prepare
        
        let jsonURLString = "https://restcountries.eu/rest/v2/all"
        guard let url = URL(string: jsonURLString) else {
            return
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async(execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            
            guard let data = data else { return }
            
            do {
                self.countryList = try JSONDecoder().decode([Country].self, from: data)
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    self.tableCountriesList.reloadData()
                })
            }
            catch let jsonErr {
                print(jsonErr.localizedDescription)
            }
        }.resume()
    }
}


extension CountryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView Delegate & DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.countryList[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountryDetailViewController") as! CountryDetailViewController
        vc.countryData = self.countryList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}





