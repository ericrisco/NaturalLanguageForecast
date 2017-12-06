//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 06/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import UIKit

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func initTable(){
        
        tableValues = [Forecast]()
        
        if isInterval == true {
            tableValues = result.hourly
            tableValues.append(contentsOf: result.daily)
            tableValues = tableValues.filter({ (forecast) -> Bool in
                return forecast.time >= from && forecast.time < to
            })
        } else {
            tableValues = result.hourly
        }
        
        forecastTable.isHidden = tableValues.count == 0
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as? ForecastTableViewCell else {
            return ForecastTableViewCell()
        }
        cell.forecast = tableValues[indexPath.row]
        return cell
    }
    
    
}
