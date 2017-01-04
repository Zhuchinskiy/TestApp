//
//  Attr.swift
//
//  Created by Alexandr Zhuchinskiy on 1/4/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Attr: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let total = "total"
    static let totalPages = "totalPages"
    static let perPage = "perPage"
    static let page = "page"
    static let country = "country"
  }

  // MARK: Properties
  public var total: String?
  public var totalPages: String?
  public var perPage: String?
  public var page: String?
  public var country: String?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    total = json[SerializationKeys.total].string
    totalPages = json[SerializationKeys.totalPages].string
    perPage = json[SerializationKeys.perPage].string
    page = json[SerializationKeys.page].string
    country = json[SerializationKeys.country].string
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = total { dictionary[SerializationKeys.total] = value }
    if let value = totalPages { dictionary[SerializationKeys.totalPages] = value }
    if let value = perPage { dictionary[SerializationKeys.perPage] = value }
    if let value = page { dictionary[SerializationKeys.page] = value }
    if let value = country { dictionary[SerializationKeys.country] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.total = aDecoder.decodeObject(forKey: SerializationKeys.total) as? String
    self.totalPages = aDecoder.decodeObject(forKey: SerializationKeys.totalPages) as? String
    self.perPage = aDecoder.decodeObject(forKey: SerializationKeys.perPage) as? String
    self.page = aDecoder.decodeObject(forKey: SerializationKeys.page) as? String
    self.country = aDecoder.decodeObject(forKey: SerializationKeys.country) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(total, forKey: SerializationKeys.total)
    aCoder.encode(totalPages, forKey: SerializationKeys.totalPages)
    aCoder.encode(perPage, forKey: SerializationKeys.perPage)
    aCoder.encode(page, forKey: SerializationKeys.page)
    aCoder.encode(country, forKey: SerializationKeys.country)
  }

}
