//
//  DayController.swift
//  Forecast
//
//  Created by Chase on 2/21/23.
//

import Foundation

class DayController {
    
    static func fetchDays(completion: @escaping ([Day]?) -> Void) {
        
        // MARK: - Construct URL
        
        guard let baseURL = URL(string: Constants.DayURL.baseURL) else { completion(nil) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Constants.DayURL.dailyPath)
        
        let apiQuery = URLQueryItem(name: Constants.DayURL.apiQueryKey1, value: Constants.DayURL.apiQueryKeyValue1)
        let cityQuery = URLQueryItem(name: Constants.DayURL.apiParameterKey2, value: Constants.DayURL.apiParameterKeyValue2)
        let unitQuery = URLQueryItem(name: Constants.DayURL.apiParameterKey3, value: Constants.DayURL.apiParameterKeyValue3)
        urlComponents?.queryItems = [apiQuery, cityQuery, unitQuery]
        
        guard let finalURL = urlComponents?.url else { completion(nil) ; return }
        print("Final URL: \(finalURL)")
        
        // MARK: - DataTask
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(nil) ; return }
            
            do {
                
                if let topLevel = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any],
                   let dayArray = topLevel["data"] as? [[String : Any]] {
                   
                    let days = dayArray.compactMap { Day(dayDictionary: $0, cityName: Constants.DayURL.apiQueryKeyValue1) }
                    completion(days)
                }
                
            } catch {
                
                print(error.localizedDescription)
                completion(nil) ; return
                
            }
        } .resume()
    }
}
