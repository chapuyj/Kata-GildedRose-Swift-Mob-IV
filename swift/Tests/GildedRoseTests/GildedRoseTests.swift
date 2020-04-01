@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {

    //MARK:- Basic tests

    // aged brie

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

    func testUpdateQuality_WithIncreasingQualityItem_WithQuality50_ShouldNotIncreaseQuality() {
        let items = [Item(name: "Aged Brie", sellIn: -10, quality: 50)]
        let app = GildedRose(items: items);

        app.updateQuality();

        XCTAssertEqual(-11, app.items[0].sellIn);
        XCTAssertEqual(50, app.items[0].quality);
    }

    //MARK:- Characterization tests, with multiple entries

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

    //MARK:- Parametrized Tests

    // utils

    func parametrizedTest_updateItem(givenItem: Item, expectedSellIn: Int, expectedQuality: Int) {
        let items = [givenItem]
        let app = GildedRose(items: items)

        app.updateQuality()

        XCTAssertEqual(givenItem.name, items.first?.name)
        XCTAssertEqual(expectedSellIn, items.first?.sellIn)
        XCTAssertEqual(expectedQuality, items.first?.quality)
    }

    // common item

    func testUpdateQuality_withCommonItem_positiveSellIn() {
        let item = Item(name: "+5 Dexterity Vest", sellIn: 19, quality: 15)

        parametrizedTest_updateItem(givenItem: item, expectedSellIn: 18, expectedQuality: 14)
    }

    func testUpdateQuality_withCommonItem_reachedSellIn() {
        let item = Item(name: "+5 Dexterity Vest", sellIn: 1, quality: 12)

        parametrizedTest_updateItem(givenItem: item, expectedSellIn: 0, expectedQuality: 11)
    }
        
    func testUpdateQuality_withCommonItem_negativeSellIn() {
        let item = Item(name: "+5 Dexterity Vest", sellIn: 0, quality: 12)

        parametrizedTest_updateItem(givenItem: item, expectedSellIn: -1, expectedQuality: 10)
    }

    func testUpdateQuality_withCommonItem_neverNegativeQuality() {
        let item = Item(name: "+5 Dexterity Vest", sellIn: 0, quality: 0)

        parametrizedTest_updateItem(givenItem: item, expectedSellIn: -1, expectedQuality: 0)
    }

    // legendary item 
    
    func testUpdateQuality_WithLegendaryItem_AndPositiveSellIn_ShouldNotChangeQualityNorSellIn() {
        let item = Item(name: "Sulfuras, Hand of Ragnaros", sellIn: 10, quality: 80)

        parametrizedTest_updateItem(givenItem: item, expectedSellIn: 10, expectedQuality: 80)
    }
    
    func testUpdateQuality_WithLegendaryItem_AndNegativeSellIn_ShouldNotChangeQualityNorSellIn() {
        let item = Item(name: "Sulfuras, Hand of Ragnaros", sellIn: -5, quality: 80)

        parametrizedTest_updateItem(givenItem: item, expectedSellIn: -5, expectedQuality: 80)
    }

    // Backstage passes

    func testUpdateQuality_WithBackstagePasses_WithSellInGreaterThan10_ShouldIncreaseQualityByOne() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 22, quality: 40)

        parametrizedTest_updateItem(givenItem: item, expectedSellIn: 21, expectedQuality: 41)
    }

    func testUpdateQuality_WithBackstagePasses_WithSellInBetween10IncludedAnd5Excluded_ShouldIncreaseQualityByTwo() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 10, quality: 40)

        parametrizedTest_updateItem(givenItem: item, expectedSellIn: 9, expectedQuality: 42)
    }

    func testUpdateQuality_WithBackstagePasses_WithSellInBetween5IncludedAnd0Excluded_SellIn5_ShouldIncreaseQualityByThree() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 5, quality: 30)

        parametrizedTest_updateItem(givenItem: item, expectedSellIn: 4, expectedQuality: 33)
    }

    func testUpdateQuality_WithBackstagePasses_WithSellInBetween5IncludedAnd0Excluded_SellIn1_ShouldIncreaseQualityByThree() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 1, quality: 30)

        parametrizedTest_updateItem(givenItem: item, expectedSellIn: 0, expectedQuality: 33)
    }

    func testUpdateQuality_WithBackstagePasses_WithSellIn0_ShouldDropQualityTo0() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 30)

        parametrizedTest_updateItem(givenItem: item, expectedSellIn: -1, expectedQuality: 0)
    }

    func testUpdateQuality_WithBackstagePasses_WithSellInNegative_ShouldKeepQualityTo0() {
        let item = Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: -1, quality: 0)

        parametrizedTest_updateItem(givenItem: item, expectedSellIn: -2, expectedQuality: 0)
    }

    //MARK:- Listing all tests for runner

    static var allTests : [(String, (GildedRoseTests) -> () throws -> Void)] {
        return [
            ("testAgedBrie_SellIn2_AfterOneDay_QualityShouldIncreaseByOne_SellInShouldDecreaseByOne", testAgedBrie_SellIn2_AfterOneDay_QualityShouldIncreaseByOne_SellInShouldDecreaseByOne),
            ("testAgedBrie_SellInNegative_AfterOneDay_QualityShouldIncreaseByTwo_SellInShouldDecreaseByOne", testAgedBrie_SellInNegative_AfterOneDay_QualityShouldIncreaseByTwo_SellInShouldDecreaseByOne),
            ("testUpdateQuality_SellIn20", testUpdateQuality_SellIn20),
            ("testUpdateQuality_withCommonItem_positiveSellIn", testUpdateQuality_withCommonItem_positiveSellIn),
            ("testUpdateQuality_withCommonItem_reachedSellIn", testUpdateQuality_withCommonItem_reachedSellIn),
            ("testUpdateQuality_withCommonItem_negativeSellIn", testUpdateQuality_withCommonItem_negativeSellIn),
            ("testUpdateQuality_withCommonItem_neverNegativeQuality", testUpdateQuality_withCommonItem_neverNegativeQuality),
            ("testUpdateQuality_WithIncreasingQualityItem_WithQuality50_ShouldNotIncreaseQuality", testUpdateQuality_WithIncreasingQualityItem_WithQuality50_ShouldNotIncreaseQuality),
            ("testUpdateQuality_WithLegendaryItem_AndPositiveSellIn_ShouldNotChangeQualityNorSellIn", testUpdateQuality_WithLegendaryItem_AndPositiveSellIn_ShouldNotChangeQualityNorSellIn),
            ("testUpdateQuality_WithLegendaryItem_AndNegativeSellIn_ShouldNotChangeQualityNorSellIn", testUpdateQuality_WithLegendaryItem_AndNegativeSellIn_ShouldNotChangeQualityNorSellIn),
            ("testUpdateQuality_WithBackstagePasses_WithSellInGreaterThan10_ShouldIncreaseQualityByOne", testUpdateQuality_WithBackstagePasses_WithSellInGreaterThan10_ShouldIncreaseQualityByOne),
            ("testUpdateQuality_WithBackstagePasses_WithSellInBetween10IncludedAnd5Excluded_ShouldIncreaseQualityByTwo", testUpdateQuality_WithBackstagePasses_WithSellInBetween10IncludedAnd5Excluded_ShouldIncreaseQualityByTwo),
            ("testUpdateQuality_WithBackstagePasses_WithSellInBetween5IncludedAnd0Excluded_SellIn5_ShouldIncreaseQualityByThree", testUpdateQuality_WithBackstagePasses_WithSellInBetween5IncludedAnd0Excluded_SellIn5_ShouldIncreaseQualityByThree),
            ("testUpdateQuality_WithBackstagePasses_WithSellInBetween5IncludedAnd0Excluded_SellIn1_ShouldIncreaseQualityByThree", testUpdateQuality_WithBackstagePasses_WithSellInBetween5IncludedAnd0Excluded_SellIn1_ShouldIncreaseQualityByThree),
            ("testUpdateQuality_WithBackstagePasses_WithSellIn0_ShouldDropQualityTo0", testUpdateQuality_WithBackstagePasses_WithSellIn0_ShouldDropQualityTo0),
            ("testUpdateQuality_WithBackstagePasses_WithSellInNegative_ShouldKeepQualityTo0", testUpdateQuality_WithBackstagePasses_WithSellInNegative_ShouldKeepQualityTo0)
        ]
    }
}

//MARK:- Utils

extension Item: Equatable {
    public static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.description == rhs.description
    }
}