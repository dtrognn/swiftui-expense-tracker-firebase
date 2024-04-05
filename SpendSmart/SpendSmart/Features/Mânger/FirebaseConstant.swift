//
//  FirebaseConstant.swift
//  SpendSmart
//
//  Created by dtrognn on 02/04/2024.
//

import FirebaseFirestore
import Foundation

let FIRUsersCollection = Firestore.firestore().collection("users")
let FIRTransactionsCollection = Firestore.firestore().collection("transactions")
let FIRCategoryCollection = Firestore.firestore().collection("categories")
