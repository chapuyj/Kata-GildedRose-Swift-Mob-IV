// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import XCTest
import GildedRoseTests

extension GildedRoseTests {
    static var allTests: [(String, (GildedRoseTests) -> () throws -> Void)] = [
            ("testAgedBrie_SellIn2_AfterOneDay_QualityShouldIncreaseByOne_SellInShouldDecreaseByOne", testAgedBrie_SellIn2_AfterOneDay_QualityShouldIncreaseByOne_SellInShouldDecreaseByOne),
            ("testAgedBrie_SellInNegative_AfterOneDay_QualityShouldIncreaseByTwo_SellInShouldDecreaseByOne", testAgedBrie_SellInNegative_AfterOneDay_QualityShouldIncreaseByTwo_SellInShouldDecreaseByOne),
            ("testUpdateQuality_WithIncreasingQualityItem_WithQuality50_ShouldNotIncreaseQuality", testUpdateQuality_WithIncreasingQualityItem_WithQuality50_ShouldNotIncreaseQuality),
            ("testUpdateQuality_SellIn20", testUpdateQuality_SellIn20),
            ("testUpdateQuality_withCommonItem_positiveSellIn", testUpdateQuality_withCommonItem_positiveSellIn),
            ("testUpdateQuality_withCommonItem_reachedSellIn", testUpdateQuality_withCommonItem_reachedSellIn),
            ("testUpdateQuality_withCommonItem_negativeSellIn", testUpdateQuality_withCommonItem_negativeSellIn),
            ("testUpdateQuality_withCommonItem_neverNegativeQuality", testUpdateQuality_withCommonItem_neverNegativeQuality),
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

