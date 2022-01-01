//
//  CryptoViewController.swift
//  CryptoTracker
//
//  Created by Shamim Rahman on 11/28/21.

// view controller when you segue from ViewController
// shows the specific crypto details when clicking on a cell
// api link to get the crypto info
//https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin&order=market_cap_desc&per_page=100&page=1&sparkline=false

// sources used
// I used this youtube tutorial to create a UIviewTable thats shows the data when you create a segue
//https://www.youtube.com/watch?v=FNkS_QIngg8&list=LL&index=4&t=287s&ab_channel=PlanetVeracity

import UIKit

class CryptoViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var crypto:Crypto?
    var singleCryptos = [cryptoPrice]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        downloadSingleJSON {
            self.tableView.reloadData()
            //print(self.singleCryptos[0].name)
            //print(self.singleCryptos[0].current_price as Any)
            
        }
        
        tableView.delegate = self
        tableView.dataSource = self
       
        _ = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    }
    
    @objc func refreshData() -> Void {
        viewDidLoad()
    }
    
    // get the number of rows for the UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return singleCryptos.count
    }
    
    // what I want to show in each of my cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "informationCell", for: indexPath) as! CryptoDetailViewTableViewCell
        //print(singleCryptos[0].usd)
        cell.usdLabel.text = "price: \((singleCryptos[0].current_price)!)"
        cell.NameLabel.text = crypto?.name
        
       
        let imageUrlString = singleCryptos[0].image
        let imageUrl:URL = URL(string: imageUrlString)!
        let imageData:NSData = NSData(contentsOf: imageUrl)!
        cell.imageLabel.image = UIImage(data: imageData as Data)
        
        cell.high24Label.text = "High_24h: \((singleCryptos[0].high_24h)!)"
        cell.low24Label.text = "Low_24h: \((singleCryptos[0].low_24h)!)"
        cell.marketCapLabel.text = "Market Cap Rank: \((singleCryptos[0].market_cap_rank)!)"
        cell.totalVolumeLabel.text = "Total Volume: \((singleCryptos[0].total_volume)!)"
        cell.lastUpDateLabel.text = "Last Updated: \((singleCryptos[0].last_updated))"
        cell.priceChangeLabel.text = "Price change 24 hours: \((singleCryptos[0].price_change_24h)!)"
        cell.totalMarketLabel.text = "Market Cap: \((singleCryptos[0].market_cap)!)"
        
        return cell
    }
    
    
    func downloadSingleJSON(completed: @escaping () -> ()) {
        singleCryptos.removeAll()
        let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=\((crypto?.id)!)&order=market_cap_desc&per_page=100&page=1&sparkline=false")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do {
                    self.singleCryptos = try JSONDecoder().decode([cryptoPrice].self, from: data!)
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("JSON Error")
                }
            }
        }.resume()
    }
    
}
