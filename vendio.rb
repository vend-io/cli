require 'singleton'

class Item
    def initialize(id, name, price)
        #maybe add check to make sure these are acceptable types
        @id = id
        @name = name
        @price = price
    end
    attr_reader :id, :name, :price
end

class ItemManager
    include Singleton #may not be necessary, but should have private new
    #again, I can add checks to ensure these are good types
    #(via reflection) if needed
    def initialize
        @slot = {}
    end
    attr_reader :slot
    def add(item)
        @slot[item.id] = item
    end
    def remove(item)
        if item.is_a? Item
            @slot.delete item.id
        elsif item.is_a? Numeric or item.is_a? String
            @slot.delete item
        end
    end
end


