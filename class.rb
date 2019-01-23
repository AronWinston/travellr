class Adventures
    attr_accessor :activity, :image, :price, :thrill

    def initialize (activity, image, price, thrill)
        @activity = activity
        @image = image
        @price = price
        @thrill = thrill
    end

    def activity()
        @activity
    end

    def image()
        @image
    end

    def price()
        @price
    end

    def thrill()
        @thrill
    end
end


    