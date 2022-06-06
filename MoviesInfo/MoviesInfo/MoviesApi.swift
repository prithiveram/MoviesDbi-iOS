//
//  MoviesApi.swift
//  MoviesInfo
//
//  Created by Mac-mini 2 on 03/06/22.
//


import UIKit

class MoviesApi: NSObject,URLSessionDelegate {
    
    static let getInstance = MoviesApi()
    let apiCall = ApiClass()
    
    func getMoviesDetails(urlString: String,completionHandler: @escaping(_ error:ErrorCode,_ response: [String: AnyObject]) ->()) {
        print(urlString)
        apiCall.createRequest(urlString: urlString) {(errorMessage, jsonData) in
            if errorMessage == ErrorCode.success {
                do {
                    
                    if let result = jsonData["results"] as? NSMutableArray {
                        print(result)
                        
                        
                        var requestResult =  ["moviesnDetail": result] as [String:AnyObject]
                        requestResult.updateValue(jsonData["recordCount"] as? Int as AnyObject, forKey: "recordCount")
                        completionHandler(ErrorCode.success,requestResult)
                        
                    } else {
                        if let errorDescription = jsonData["Message"] as? String {
                            completionHandler(ErrorCode.failure, ["error": errorDescription as AnyObject])
                        } else {
                            completionHandler(ErrorCode.failure, ["error": "Error in API" as AnyObject])
                        }
                    }
                } catch {
                    completionHandler(ErrorCode.failure, ["error": error.localizedDescription as AnyObject])
                }
            }  else if errorMessage == ErrorCode.sessionOut{
                completionHandler(ErrorCode.sessionOut,["error": jsonData["Message"]! as AnyObject])
            }else {
                completionHandler(ErrorCode.failure,["error": jsonData["error"]! as AnyObject])
            }
        }
    }
    
    
    
}
