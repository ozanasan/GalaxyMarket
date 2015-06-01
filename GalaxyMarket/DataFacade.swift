//
//  DataFacade.swift
//  GalaxyMarket
//
//  Created by Ozan Asan on 25/05/15.
//  Copyright (c) 2015 OzanAsan. All rights reserved.
//

import UIKit

func GetGalaxyItems() -> [GalaxyItem] {
    var returnValue : [GalaxyItem] = []
    
    let jediDescription = "Jedi Knights are the most powerful fighters in the galaxy." //They can use the force to bend known physical limits for living beings."
    let storDescription = "Storm Troopers are elit soldiers that can be deadly when they are guided in a right way."
    let bounDescription = "Bounty Hunters are perfect for a one mission impossible duty." //Tell them the job, and you can forget about it. They won`t."
    let smugglerDescription = "Some Smuggler."
    let pilotDescription = "Pilot is some pilot.."
    let ewokDescription = "Ewok description.. Yes. I will."
    let atatDescription = "At-At description will be added."
    let stardestroyerDescription = "Stardestroyer description will be added.."
    let xwingDescription = "X-Wing fighters are very strong"
    let deathstarDescription = "Deathstar is the ultimate weapon."
    
    var item1 =  GalaxyItem(name: "Storm Trooper", price: 10, image: UIImage(named:"GIStormTrooper"), description: storDescription)
    var item2 =  GalaxyItem(name: "Jedi", price: 1500, image: UIImage(named:"GIJedi"), description: jediDescription)
    var item3 =  GalaxyItem(name: "Bounty Hunter", price: 60, image: UIImage(named:"GIBountyHunter"), description: bounDescription)
    var item4 =  GalaxyItem(name: "Pilot", price: 45, image: UIImage(named:"GIPilot"), description: pilotDescription)
    var item5 =  GalaxyItem(name: "Smuggler", price: 55, image: UIImage(named:"GISmuggler"), description: smugglerDescription)
    var item6 =  GalaxyItem(name: "Ewok", price: 1, image: UIImage(named:"GIEwk"), description: ewokDescription)
    var item7 =  GalaxyItem(name: "AT-AT", price: 100, image: UIImage(named:"GIAtat"), description: atatDescription)
    var item8 =  GalaxyItem(name: "Stardestroyer", price: 450, image: UIImage(named:"GIStardestroyer"), description: stardestroyerDescription)
    var item9 =  GalaxyItem(name: "X-Wing", price: 350, image: UIImage(named:"GIXwing"), description: xwingDescription)
    var item10 =  GalaxyItem(name: "Deathstar", price: 1499, image: UIImage(named:"GIDeathstar"), description: deathstarDescription)
    
    returnValue.append(item1); returnValue.append(item2); returnValue.append(item3)
    returnValue.append(item4); returnValue.append(item5); returnValue.append(item6)
    returnValue.append(item7); returnValue.append(item8); returnValue.append(item9); returnValue.append(item10);
    
    return returnValue
}
