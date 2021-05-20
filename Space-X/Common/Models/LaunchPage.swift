//
//  LaunchPage.swift
//  Space-X
//
//  Created by mohammadSaadat on 2/29/1400 AP.
//

import Foundation

// MARK: - PageLaunch
struct PageLaunch: Codable {
    let docs: [LaunchData]?
    let totalDocs, limit, totalPages, page: Int?
    let pagingCounter: Int?
    let hasPrevPage, hasNextPage: Bool?
    let prevPage: Int?
    let nextPage: Int?
}

// MARK: - Doc
struct LaunchData: Codable {
    let fairings: Fairings?
    let links: Links?
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let tbd, net: Bool?
    let window: Int?
    let success: Bool?
    let details: String?
    let ships, capsules, payloads: [String]?
    let autoUpdate: Bool?
    let failures: [Failure]?
    let flightNumber: Int?
    let name, dateUTC: String?
    let dateUnix: Int?
    let dateLocal: Date?
    let datePrecision: DatePrecision?
    let upcoming: Bool?
    let cores: [Core]?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case fairings, links
        case staticFireDateUTC = "static_fire_date_utc"
        case staticFireDateUnix = "static_fire_date_unix"
        case tbd, net, window, success, details, ships, capsules, payloads
        case autoUpdate = "auto_update"
        case failures
        case flightNumber = "flight_number"
        case name
        case dateUTC = "date_utc"
        case dateUnix = "date_unix"
        case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case upcoming, cores, id
    }
}

extension LaunchData: Equatable {}

// MARK: - Core
struct Core: Codable {
    let core: String?
    let flight: Int?
    let gridfins, legs, reused, landingAttempt: Bool?

    enum CodingKeys: String, CodingKey {
        case core, flight, gridfins, legs, reused
        case landingAttempt = "landing_attempt"
    }
}

extension Core: Equatable {}

enum DatePrecision: String, Codable {
    case hour = "hour"
}

extension DatePrecision: Equatable {}

// MARK: - Failure
struct Failure: Codable {
    let time: Int?
    let altitude: Int?
    let reason: String?
}

extension Failure: Equatable {}

// MARK: - Fairings
struct Fairings: Codable {
    let reused, recoveryAttempt, recovered: Bool?

    enum CodingKeys: String, CodingKey {
        case reused
        case recoveryAttempt = "recovery_attempt"
        case recovered
    }
}

extension Fairings: Equatable {}

// MARK: - Links
struct Links: Codable {
    let patch: Patch?
    let reddit: Reddit?
    let presskit: String?
    let webcast: String?
    let youtubeID: String?
    let article: String?
    let wikipedia: String?

    enum CodingKeys: String, CodingKey {
        case patch, reddit, presskit, webcast
        case youtubeID = "youtube_id"
        case article, wikipedia
    }
}

extension Links: Equatable {}

// MARK: - Patch
struct Patch: Codable {
    let small, large: String?
}

extension Patch: Equatable {}

// MARK: - Reddit
struct Reddit: Codable {
    let launch: String?
}

extension Reddit: Equatable {}
