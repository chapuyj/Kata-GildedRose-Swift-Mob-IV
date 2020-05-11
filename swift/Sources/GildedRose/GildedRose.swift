public class GildedRose {
    var items:[Item]
    
    public init(items:[Item]) {
        self.items = items
    }

    // updateQuality()
    // Switch (name)
    // -> updateQualityForAgeBrie()
    // -> updateQualityForCommon()
    // ...

    //public func update() {
    //  items.forEach { item in
    //      item.updateSellin()
    //      item.updateQuality()
    //  }
    //}

    // items.map {
    //    return item.update()

    // items.map {
    //    return Updator.update(item: item)

    public func update() {
        items.forEach { item in
            if isConjured(item: item) {
                item.updateQuality()
                item.updateSellIn()
            } else {
                legacy_update(item: item)
            }          
        }
    }

    public func legacy_update(item: Item) {
        if isLoosingQualityEachDay(item: item) {
            decreaseQuality(item: item)
                if isConjured(item: item) {
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

        updateSellIn(item: item)

        if isItemExpired(item: item) {
            if isAgedBrie(item: item) {
                increaseQuality(item: item)   
            } else if isBackstagePasses(item: item) {
                item.quality = 0
            } else {
                decreaseQuality(item: item)
                if isConjured(item: item) {
                    decreaseQuality(item: item)
                }
            }
        }
    }

    private func updateSellIn(item: Item) {
        if isLegendary(item: item) == false {
            item.sellIn -= 1
        }
    }

    private func isItemExpired(item: Item) -> Bool {
        return item.sellIn < 0
    }

    private func isLoosingQualityEachDay(item: Item) -> Bool {
        return isAgedBrie(item: item) == false && isBackstagePasses(item: item) == false
    }   

    private func isAgedBrie(item: Item) -> Bool {
        return item.name == "Aged Brie"
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
        if qualityCanBeDecreased(item: item) {
            item.quality -= 1
        }
    }

    private func increaseQuality(item: Item) {        
        if hasNotReachedMaximumQuality(item: item) {
            item.quality += 1
        }
    }

    private func hasNotReachedMaximumQuality(item: Item) -> Bool {
        return item.quality < 50
    }

    private func isConjured(item: Item) -> Bool {
        return item.name == "Conjured Mana Cake"
    }
}

//MARK:- Update Item

private extension Item {

    func updateQuality() {
        if isConjured {
            updateQualityForConjuredItem()
        }
    }   

    private func updateQualityForConjuredItem() {
        if isExpired { 
            quality -= 4
        } else {
            quality -= 2
        } 
    }

    func updateSellIn() {
        guard isLegendary == false else { return }
        sellIn -= 1
    } 
}

//MARK:- Item Kind

private extension Item {

    var isLegendary: Bool {
        return name == "Sulfuras, Hand of Ragnaros"
    }

    var isConjured: Bool {
        return name == "Conjured Mana Cake"
    }
}

//MARK:- Item State

private extension Item {

    var isExpired: Bool {
        return sellIn <= 0
    }
}
