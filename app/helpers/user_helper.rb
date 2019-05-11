module UserHelper
    def shorten(number)
        number = number.split(" ").map do |i|
            if i.to_i != 0
                i
            else
                case i
                when "Thousand"
                    "K"
                else
                    "M"
                end
            end
        end.join("")
    end
end
