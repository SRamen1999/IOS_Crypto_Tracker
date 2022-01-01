//
//  cryptoInfo.swift
//  CryptoTracker
//
//  Created by Shamim Rahman on 11/28/21.
//

// codable file

import Foundation

struct Crypto: Codable {
    let id: String
    let name: String
    let current_price: Float?
    let image: String
    let high_24h: Float?
    let low_24h: Float?
    let market_cap_rank: Float?
    let total_volume: Float?
    
    let last_updated: String
}

struct CryptoNews: Codable {
    let title: String
    let url: String
}

struct cryptoPrice: Codable {
    let current_price: Float?
    let name: String
    let market_cap_rank: Float?
    let total_volume: Float?
    let high_24h: Float?
    let low_24h: Float?
    let last_updated: String
    let price_change_24h: Float?
    let market_cap: Float?
    let image: String
    
}


/*
 3:{2 items
 "title":"Bitcoin Drops $9K in an Hour on Spot Market Selling; El Salvador Again Buys the Dip"
 "url":"https://coindesk.com/markets/2021/12/04/bitcoin-drops-9k-in-an-hour/"
 }
 4:{2 items
 "title":"Market Wrap: Bitcoin Extends Losses While Traders Remain Bullish on Ether"
 "url":"https://coindesk.com/markets/2021/12/03/market-wrap-bitcoin-extends-losses-while-traders-remain-bullish-on-ether/"
 }
*/



/*
 {
    "id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
    "current_price": 56904,
    "market_cap": 1074013991188,
    "market_cap_rank": 1,
    "fully_diluted_valuation": 1194209404912,
    "total_volume": 30857621716,
    "high_24h": 58129,
    "low_24h": 53672,
    "price_change_24h": 2646.83,
    "price_change_percentage_24h": 4.87827,
    "market_cap_change_24h": 47524039994,
    "market_cap_change_percentage_24h": 4.62976,
    "circulating_supply": 18886381,
    "total_supply": 21000000,
    "max_supply": 21000000,
    "ath": 69045,
    "ath_change_percentage": -17.72533,
    "ath_date": "2021-11-10T14:24:11.849Z",
    "atl": 67.81,
    "atl_change_percentage": 83674.06593,
    "atl_date": "2013-07-06T00:00:00.000Z",
    "roi": null,
    "last_updated": "2021-11-29T15:25:31.811Z"
  },
 
 
 */
