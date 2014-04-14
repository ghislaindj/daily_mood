module Mongoid
  module Group
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
     def group_by(frequency, field)
      hash = {  year: :getFullYear,
                month: :getMonth,
                day: :getDate,
                hours: :getHours,
                minute: :getMinutes
              }
      string = ''
      hash.keys.each do |k|
        string << "this.#{field}.#{hash[k]}(),"
        string = string.chomp(',') and break if k.to_s == frequency.to_s
      end
      map = %Q{
        function() {
          var created_at = new Date(#{string});
          emit(created_at, {count: 1});
        }
      }
      self.group_by_time(map)
     end
      def group_by_minute(field)
        map = %Q{
          function() {
            var created_at = new Date(this.#{field}.getFullYear(),
                                              this.#{field}.getMonth(),
                                              this.#{field}.getDate(),
                                              this.#{field}.getHours(),
                                              this.#{field}.getMinutes()
                                            );
            emit(created_at, {count: 1});
          }
        }

        self.group_by_time(map)
      end

      def group_by_hour(field)
        map = %Q{
          function() {
            var created_at = new Date(this.#{field}.getFullYear(),
                                              this.#{field}.getMonth(),
                                              this.#{field}.getDate(),
                                              this.#{field}.getHours()
                                            );
            emit(created_at, {count: 1});
          }
        }

        self.group_by_time(map)
      end

      def group_by_day(field)
        map = %Q{
          function() {
            var created_at = new Date(this.#{field}.getFullYear(),
                                              this.#{field}.getMonth(),
                                              this.#{field}.getDate()
                                            );
            emit(created_at, {count: 1});
          }
        }

        self.group_by_time(map)
      end

      def group_by_month(field)
        map = %Q{
          function() {
            var created_at = new Date(this.#{field}.getFullYear(),
                                              this.#{field}.getMonth()
                                            );
            emit(created_at, {count: 1});
          }
        }

        self.group_by_time(map)
      end

      def group_by_time(map)

        reduce = %Q{
          function(key, values) {
             var total = 0;
             for(var i = 0; i < values.length; i++) { total += values[i].count; }
             return {count: total};
          }
        }

        output = []

        self.map_reduce(map, reduce).out(inline: true).each do |item|
          output << [item["_id"], item["value"]["count"]]
        end

        output
      end

    end
  end
end