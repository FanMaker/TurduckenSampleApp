//
//  AppViewModel.swift
//  Turducken
//
//  Created by Érik Escobedo on 20/06/22.
//

import Combine
import FanMaker
import Foundation

struct BeaconAction : Identifiable {
    var id : Int
    var major : Int
    var minor : Int
    var seenAt : Date
    var posted : Bool
}

extension BeaconAction {
    init(from fmAction: FanMakerSDKBeaconRangeAction, id: Int) {
        self.id = id
        self.major = fmAction.major
        self.minor = fmAction.minor
        self.seenAt = fmAction.seenAt
        self.posted = true
    }
}

struct Region : Identifiable {
    var id : Int
    var uuid : String
    var major : Int
    var within : Bool = false
    var actions : [BeaconAction] = []

    func beacons() -> [Beacon] {
        var minors : Set<Int> = []
        for action in actions {
            if (major == action.major) {
                minors.insert(action.minor)
            }
        }
        
        return minors.map({ Beacon(id: $0, region: self)})
    }
}

class FanMakerViewModel : NSObject, ObservableObject, FanMakerSDKBeaconsManagerDelegate {
    
    @Published var beaconRegions : [Region]
    
    private let beaconsManager : FanMakerSDKBeaconsManager
    
    override init() {
        beaconsManager = FanMakerSDKBeaconsManager()
        beaconRegions = []
        
        super.init()
        beaconsManager.delegate = self
    }
    
    func updateRegions() {
        beaconsManager.requestAuthorization()
    }
    
    func beaconsManager(_ manager: FanMakerSDKBeaconsManager, didChangeAuthorization status: FanMakerSDKBeaconsAuthorizationStatus) {
        switch(status) {
            case .notDetermined:
                NSLog("FANMAKER ERROR: Authorization Not determined")
            case .restricted:
                NSLog("FANMAKER ERROR: Authorization Restricted")
            case .denied:
                NSLog("FANMAKER ERROR: Authorization Denied")
            case .authorizedAlways:
                NSLog("FANMAKER SUCCESS: Authorization Always")
                beaconsManager.fetchBeaconRegions()
            case .authorizedWhenInUse:
                NSLog("FANMAKER SUCCESS: Authorization When in use")
                beaconsManager.fetchBeaconRegions()
            }
    }
    
    func beaconsManager(_ manager: FanMakerSDKBeaconsManager, didReceiveBeaconRegions regions: [FanMakerSDKBeaconRegion]) {
        
        manager.startScanning(regions)
        DispatchQueue.main.async {
            self.beaconRegions = regions.map {
                Region(id: $0.id, uuid: $0.uuid, major: Int($0.major) ?? 0)
            }
        }
    }
    
    func beaconsManager(_ manager: FanMakerSDKBeaconsManager, didEnterRegion region: FanMakerSDKBeaconRegion) {
     
        NSLog("Enter FM region: \(region.uuid)")
        DispatchQueue.main.async {
            self.beaconRegions = self.beaconRegions.map {
                var beaconRegion = $0
                if beaconRegion.id == region.id {
                    beaconRegion.within = true
                }
                return beaconRegion
            }
        }
    }
    
    func beaconsManager(_ manager: FanMakerSDKBeaconsManager, didExitRegion region: FanMakerSDKBeaconRegion) {
     
        NSLog("Exit FM region: \(region.uuid)")
        DispatchQueue.main.async {
            self.beaconRegions = self.beaconRegions.map {
                var beaconRegion = $0
                if beaconRegion.id == region.id {
                    beaconRegion.within = false
                }
                return beaconRegion
            }
        }
    }
    
    func beaconsManager(_ manager: FanMakerSDKBeaconsManager, didUpdateBeaconRangeActionsHistory queue: [FanMakerSDKBeaconRangeAction]) {

        NSLog("the queue was updated to \(queue.count) items")
        DispatchQueue.main.async {
            self.beaconRegions = self.beaconRegions.map { region in
                let actions : [BeaconAction] = queue.filter({ action in
                    return action.uuid.uppercased() == region.uuid.uppercased()
                }).enumerated().map({ index, action in
                    return BeaconAction(from: action, id: index)
                })
                
                var newRegion = region
                newRegion.actions = actions
                return newRegion
            }
        }
    }
    
    func beaconsManager(_ manager: FanMakerSDKBeaconsManager, didUpdateBeaconRangeActionsSendList queue: [FanMakerSDKBeaconRangeAction]) {
        
    }
    
    func beaconsManager(_ manager: FanMakerSDKBeaconsManager, didFailWithError error: FanMakerSDKBeaconsError) {
        switch(error) {
            case .userSessionNotFound:
                NSLog("FANMAKER ERROR: User session not found")
            case .serverError:
                NSLog("FANMAKER ERROR: Server error")
            case .unknown:
                NSLog("FANMAKER ERROR: Unknown")
            }
    }
}
