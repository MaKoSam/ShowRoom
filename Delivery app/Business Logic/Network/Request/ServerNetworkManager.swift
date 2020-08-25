//
//  ServerNetworkManager.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 26/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Alamofire

enum ServerState {
    case online
    case offline
    case nightMode //Night time -> not accepting new orders
}

final class ServerNetworkManager {
    func establishConnection(completionHandler: @escaping (ServerState) -> Void) {
        self.isServerOnline() { isOnline in
            if isOnline {
                self.isWorkingHours() { isWorking in
                    if isWorking {
                        completionHandler(.online)
                    } else {
                        completionHandler(.nightMode)
                    }
                }
            } else {
                completionHandler(.offline)
            }
        }
    }
    
    private func isServerOnline(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
    
    private func isWorkingHours(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
    }
}
