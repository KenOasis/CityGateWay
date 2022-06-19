//
//  CivilData.swift
//  CityGateWay
//
//  Created by Jinjian Tan on 6/15/22.
//
// Google Civil Information data
import Foundation

struct NormalizeInputData: Decodable {
    let city: String
    let state: String
}

struct OfficeData: Decodable {
    let name: String
    let officialIndices: [Int]
}

struct OfficialData: Decodable {
    let name: String
    let party: String
}

struct CivilData: Decodable {
    let normalizedInput: NormalizeInputData
    let offices: [OfficeData]
    let officials: [OfficialData]
}

