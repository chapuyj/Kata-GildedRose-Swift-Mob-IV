public class GildedRose {
    var items:[Item]
    
    public init(items:[Item]) {
        self.items = items
    }

    public func updateQuality() {
        items.forEach { item in
            if isLoosingQualityEachDay(item: item) {
                if qualityCanBeDecreased(item: item) {
                    decreaseQuality(item: item)
                }
            } else {         
                increaseQuality(item: item)
                
                if isBackstagePasses(item: item) {
                    if item.sellIn < 11 {
                        increaseQuality(item: item)
                    }
                    
                    if item.sellIn < 6 {
                        increaseQuality(item: item)
                    }
                }
            }

            if isLegendary(item: item) == false {
                item.sellIn = item.sellIn - 1
            }
            
            if (item.sellIn < 0) {
                if (item.name != "Aged Brie") {
                    if isBackstagePasses(item: item) == false {
                        if (item.quality > 0) {
                            if isLegendary(item: item) == false {
                                decreaseQuality(item: item)
                            }
                        }
                    } else {
                        item.quality = item.quality - item.quality
                    }
                } else {                  
                    increaseQuality(item: item)                    
                }
            }
        }
    }

    private func isLoosingQualityEachDay(item: Item) -> Bool {
        return item.name != "Aged Brie" && isBackstagePasses(item: item) == false
    }   

    private func isLegendary(item: Item) -> Bool {
        return item.name == "Sulfuras, Hand of Ragnaros"
    }

    private func isBackstagePasses(item: Item) -> Bool {
        return item.name == "Backstage passes to a TAFKAL80ETC concert"
    }

    private func qualityCanBeDecreased(item: Item) -> Bool {
        return item.quality > 0 && isLegendary(item: item) == false
    }

    private func decreaseQuality(item: Item) {
        item.quality -= 1
    }

    private func increaseQuality(item: Item) {        
        if hasNotReachedMaximumQuality(item: item) {
            item.quality += 1
        }
    }

    private func hasNotReachedMaximumQuality(item: Item) -> Bool {
        return item.quality < 50
    }
}
