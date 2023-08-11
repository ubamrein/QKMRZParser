//
//  MRZField.swift
//  
//
//  Created by Roman Mazeev on 15.06.2021.
//

enum MRZFieldType {
    case documentType, countryCode, names, documentNumber, nationality, birthdate, sex,
         expiryDate, personalNumber, optionalData, hash
}

// MARK: - BasicFields
typealias NamesField = (surnames: String, givenNames: String)

struct Field {
    let value: String
    let rawValue: String
}

// MARK: ValidatedField
protocol ValidatedFieldProtocol {
    var rawValues: [String] { get }
    var rawValue: String { get }
    var checkDigit: String { get }
    var isValid: Bool { get }
}

extension ValidatedFieldProtocol {
    var isValid: Bool {
        for rv in rawValues {
            if  MRZFieldFormatter.isValueValid(rv, checkDigit: checkDigit) {
                return true
            }
        }
        return false
    }
}

struct ValidatedField<T>: ValidatedFieldProtocol {
    let value: T
    let rawValues: [String]
    let rawValue : String
    let checkDigit: String
}
