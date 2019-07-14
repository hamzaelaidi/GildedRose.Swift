import Foundation

class GildedRose {
    
    var items: [Item]
    
    init(items: [Item]) {
        self.items = items
    }
    
    func updateQuality() {
        for item in items {
            var category = ItemCategory()
            if item.name.contains("Sulfuras") {
                category = Legendary()
            } else if item.name.contains("Aged Brie") {
                category = AgedBrie()
            } else if item.name.contains("Backstage passes") {
                category = BackstagePass()
            } else if item.name.contains("Conjured") {
                category = Conjured()
            }
            category.updateOneItem(item: item)
        }
    }
}

class ItemCategory {
    
    func incrementQuality(item: Item) {
        if item.quality < 50 {
            item.quality = item.quality + 1
        }
    }
    
    func decrementQuality(item: Item) {
        if item.quality > 0 {
            item.quality = item.quality - 1
        }
    }
    
    func updateExpired(item: Item) {
        decrementQuality(item: item)
    }
    
    func updateSellIn(item: Item) {
        item.sellIn = item.sellIn - 1
    }
    
    func updateQuality(item: Item) {
        decrementQuality(item: item)
    }
    
    func updateOneItem(item: Item) {
        updateQuality(item: item)
        updateSellIn(item: item)
        if item.sellIn < 0 {
            updateExpired(item: item)
        }
    }
}

class Legendary: ItemCategory {
    override func updateExpired(item: Item) {}
    override func updateSellIn(item: Item) {}
    override func updateQuality(item: Item) {}
}

class AgedBrie: ItemCategory {
    override func updateExpired(item: Item) {
        incrementQuality(item: item)
    }
    
    override func updateQuality(item: Item) {
        incrementQuality(item: item)
    }
}

class BackstagePass: ItemCategory {
    
    override func updateExpired(item: Item) {
        item.quality = 0
    }
    
    override func updateQuality(item: Item) {
        incrementQuality(item: item)
        
        if item.sellIn <= 10 {
            incrementQuality(item: item)
        }
        
        if item.sellIn <= 5 {
            incrementQuality(item: item)
        }
    }
}

class Conjured: ItemCategory {
    
    override func updateExpired(item: Item) {
        decrementQuality(item: item)
        decrementQuality(item: item)
    }
    
    override func updateQuality(item: Item) {
        decrementQuality(item: item)
        decrementQuality(item: item)
    }
}
