//
//  MedicineDataManager.swift
//  WHE
//
//  Created by Rajesh Gaddam on 31/01/23.
//

import Foundation

struct MedicinesViewModel: Equatable {
  var id: Int
  var title: String
  var subTitle: String
  var prescription : String
  var date: String
  var address: String
  var notes: String
  var condition: String
}

public class MedicineDataManager {
  var medicineArray: [MedicinesViewModel] = []
  var selectedMedList: [MedicinesViewModel] = []
  static let shared = MedicineDataManager()
  let NoSelectedMedsTitle = "Select Meds"
  let squarTickImg = "SquarTick"
  let squarUnTickImg = "SquarUnTick"
  let noMedsIconImg = "pill_capsule_white"
  let notificationImg = "Notification"
  let warningImg = "warning"
  let errorDesciptionText = "We couldn’t retrieve your medications.\nPlease try again later."
  let errorHeaderText = "Something Went Wrong"
  let noMedsDescriptionText = "There’re no medications to add right now. New medications from prescription claims may take up to 2 days to appear. \n\nPlease try again later."
  let noMedsHeaderText = "No medications found"
  let addMedsTitle = "Add Meds"
  let noMedicationHeaderTitle =  "You Have No Meds"
  let medicationsAppearHeaderTitle = "Your Meds"
  let noMedicationDescription  = "You currently have no medications. New medications from prescription claims may take up to 2 days to appear."
  let medicationsAppearDescription = "New medications from prescription claims may take up to 2 days to appear."
  
  //  private init() {}
  
  func getMedInfo() -> [MedicinesViewModel]? {
    var medicineArray1: [MedicinesViewModel] = []
    medicineArray1.append(MedicinesViewModel(id : 1,title: "Diovan HCT", subTitle: "160mg Oral Tablet", prescription: "Dr.Judy Jones on July 21,2022", date: "31/01/2023", address: "Pharmacy Name on Jan 31 ,2023, 3170 Abrams Drive Twinsburg,Ohio,44087" , notes: "General tablet", condition: "Every Day Morning"))
    medicineArray1.append(MedicinesViewModel(id : 1,title: "Diovan HCT 44", subTitle: "160mg Oral Tablet 444", prescription: "Dr.Judy Jones on July 21,2022", date: "31/01/2023", address: "Pharmacy Name on Jan 31 ,2023, 3170 Abrams Drive Twinsburg,Ohio,44087" , notes: "General tablet4444", condition: "Every Day Morning 444"))
    medicineArray1.append(MedicinesViewModel(id : 1,title: "Diovan HCT 444", subTitle: "160mg Oral Tablet 444", prescription: "Dr.Judy Jones on July 21,2022", date: "31/01/2023", address: "Pharmacy Name on Jan 31 ,2023, 3170 Abrams Drive Twinsburg,Ohio,44087" , notes: "General tablet4444", condition: "Every Day Morning 444"))
    medicineArray1.append(MedicinesViewModel(id : 1,title: "Example Medication that goes over 3 lines And That we should cap it like that we should cap it like this.", subTitle: "160mg Oral Tablet 444", prescription: "Dr.Judy Jones on July 21,2022", date: "31/01/2023", address: "Pharmacy Name on Jan 31 ,2023, 3170 Abrams Drive Twinsburg,Ohio,44087" , notes: "General tablet4444", condition: "Every Day Morning 444"))
    medicineArray1.append(contentsOf: forAddLongMedications()  ?? [])
    return medicineArray1
  }
  
  // for long medication
  func forAddLongMedications() -> [MedicinesViewModel]?  {
    var longMedicineArray: [MedicinesViewModel] = []
    for item in 1...6 {
      longMedicineArray.append(MedicinesViewModel(id: 1, title: "Diovan HCT \(item)", subTitle: "160mg Oral Tablet \(item)", prescription: "Dr.Judy Jones on July 21,2022 \(item)", date: "31/01/2023", address: "Pharmacy Name on Jan 31 ,2023, 3170 Abrams Drive Twinsburg,Ohio,44087 \(item)", notes: "General tablet\(item)", condition: "Every Day Morning \(item)"))
    }
    return longMedicineArray
  }
  
  static func hasMedicationDetails() -> Bool {
    let medArrayCount = shared.getMedInfo()?.count ?? 0
    if medArrayCount > 0 {
      return true
    }
    return false
  }
  
  func addMedDetails() -> [MedicinesViewModel]? {
    return medicineArray
  }
  
  
  
  func updateMedInformation(updateMedInfo : [MedicinesViewModel]) -> () {
    medicineArray = updateMedInfo
  }
  
  func selectedMedDetails() -> [MedicinesViewModel]? {
    return selectedMedList
  }
  
  func updateselectedMedInformation(add: Bool = false,updateMedInfo : [MedicinesViewModel]) -> () {
     if add {
      selectedMedList.append(contentsOf: updateMedInfo)
    } else {
      selectedMedList = updateMedInfo
    }
  }
}
