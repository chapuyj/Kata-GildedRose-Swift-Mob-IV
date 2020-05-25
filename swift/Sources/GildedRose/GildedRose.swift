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
            item.updateQuality()
            item.updateSellIn()         
        }
    }
}

//MARK:- Update Item

private extension Item {

    func updateQuality() {
        if isConjured {
            decreaseQuality(whenExpired: 4, nominal: 2)
        } else if isAgedBrie {
            increaseQuality(whenExpired: 2, nominal: 1)
        } else if isBackstagePasses {
            updateBackstagePassesQuality()
        } else if isLegendary {
            doNotChange()
        } else {
            decreaseQuality(whenExpired: 2, nominal: 1)
        }
    }

    private func decreaseQuality(whenExpired: Int, nominal: Int) { 
        let decrementValue = isExpired ? whenExpired : nominal
        quality = max(0, quality - decrementValue)        
    }   
    
    private func increaseQuality(by value: Int) {
        quality = min(50, quality + value)
    }

    private func increaseQuality(whenExpired: Int, nominal: Int) { 
        let incrementValue = isExpired ? whenExpired : nominal
        increaseQuality(by: incrementValue)    
    }

    private func updateBackstagePassesQuality() {
        if isExpired {
            quality = 0
            return
        }
        
        let incrementValue: Int
        switch sellIn {
            case 1...5:
                incrementValue = 3
            case 6...10:
                incrementValue = 2
            default:
                incrementValue = 1
        }
        increaseQuality(by: incrementValue)
    }

    private func doNotChange() {}

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

    var isAgedBrie: Bool {
        return name == "Aged Brie"
    }

    var isBackstagePasses: Bool {
        return name == "Backstage passes to a TAFKAL80ETC concert"
    }
}

//MARK:- Item State

private extension Item {

    var isExpired: Bool {
        return sellIn <= 0
    }
}
