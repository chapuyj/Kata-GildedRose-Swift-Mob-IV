@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {

    func testAgedBrie_SellIn2_AfterOneDay_QualityShouldIncreaseByOne_SellInShouldDecreaseByOne() {
        let items = [Item(name: "Aged Brie", sellIn: 2, quality: 0)]
        let app = GildedRose(items: items);

        app.updateQuality();

        XCTAssertEqual(1, app.items[0].sellIn);
        XCTAssertEqual(1, app.items[0].quality);
    }

    func testAgedBrie_SellInNegative_AfterOneDay_QualityShouldIncreaseByTwo_SellInShouldDecreaseByOne() {
        let items = [Item(name: "Aged Brie", sellIn: -2, quality: 0)]
        let app = GildedRose(items: items);

        app.updateQuality();

        XCTAssertEqual(-3, app.items[0].sellIn);
        XCTAssertEqual(2, app.items[0].quality);
    }

    func testUpdateQuality_SellIn20() {
        let items = [
            Item(name: "+5 Dexterity Vest", sellIn: 20, quality: 20),
            Item(name: "Aged Brie", sellIn: 20, quality: 20),
            Item(name: "Elixir of the Mongoose", sellIn: 20, quality: 20),
            Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 20, quality: 20),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 20, quality: 20)
        ]
        let app = GildedRose(items: items);

        app.updateQuality();

        let expectedItemsAfterOneDay = [
            Item(name: "+5 Dexterity Vest", sellIn: 19, quality: 19),
            Item(name: "Aged Brie", sellIn: 19, quality: 21),
            Item(name: "Elixir of the Mongoose", sellIn: 19, quality: 19),
            Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 20, quality: 20),
            Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 19, quality: 21)
        ]

        XCTAssertEqual(expectedItemsAfterOneDay, app.items)
    }

    static var allTests : [(String, (GildedRoseTests) -> () throws -> Void)] {
        return [
            ("testAgedBrie_SellIn2_AfterOneDay_QualityShouldIncreaseByOne_SellInShouldDecreaseByOne", testAgedBrie_SellIn2_AfterOneDay_QualityShouldIncreaseByOne_SellInShouldDecreaseByOne),
            ("testAgedBrie_SellInNegative_AfterOneDay_QualityShouldIncreaseByTwo_SellInShouldDecreaseByOne", testAgedBrie_SellInNegative_AfterOneDay_QualityShouldIncreaseByTwo_SellInShouldDecreaseByOne),
            ("testUpdateQuality_SellIn20", testUpdateQuality_SellIn20)
        ]
    }
}

extension Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.description == rhs.description
    }
}