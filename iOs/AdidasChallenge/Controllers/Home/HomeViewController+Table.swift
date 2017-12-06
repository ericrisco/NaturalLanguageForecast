//
//  AdidasChallenge
//
//  Created by Eric Risco de la Torre on 05/12/2017.
//  Copyright © 2017 ERISCO. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func initTable(){
        possibleQuestions.append("Can you give me temperature, wind and precipitation for the next 3 hours?")
        possibleQuestions.append("Can I go for a run this afternoon?")
        possibleQuestions.append("Can you give me the forecast for tomorrow morning?")
        possibleQuestions.append("Can I go for a ride with my bicycle this Sunday?")
        possibleQuestions.append("Is it raining right now?")        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return possibleQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "possibleQuestionCell", for: indexPath) as? PossibleQuestionsCell else {
            return PossibleQuestionsCell()
        }
        cell.backgroundColor = .clear
        cell.question = possibleQuestions[indexPath.row]
        return cell
    }
    

}
