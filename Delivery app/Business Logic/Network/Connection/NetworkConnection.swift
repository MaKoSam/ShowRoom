//
//  NetworkConnection.swift
//  Ohotnichyi Sesony
//
//  Created by Sam Mazniker on 07/05/2020.
//  Copyright © 2020 Sam Mazniker. All rights reserved.
//

import Network

final class NetworkConnection {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    func isInternetConnected(completionHandler: @escaping (Bool) -> Void) {
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
        monitor.start(queue: queue)
    }
}
