module RawkLog

  class Stat

    DEFAULT_LABEL_SIZE = 30

    HEADER = "Count Sum(secs)     Max  Median     Avg     Min     Std"

    def initialize(key)
      @key=key
      @min = nil
      @max = nil
      @sum = 0
      @sum_squares = 0
      @count = 0
      @values = []
    end

    def add(value)
      value=1.0*value
      @count+=1
      @min = value unless @min
      @min = value if value<@min
      @max = value unless @max
      @max = value if value>@max
      @sum += value
      @sum_squares += value*value
      @values << value
    end

    def header(label_size = DEFAULT_LABEL_SIZE)
      sprintf "%*s  %s" % [-label_size, "Request", HEADER]
    end

    def key
      @key
    end

    def count
      @count
    end

    def sum
      @sum
    end

    def min
      @min
    end

    def max
      @max
    end

    def average
      @count > 0 ? @sum/@count : @sum
    end

    def median
      return nil unless @values
      l = @values.length
      return nil unless l>0
      @values.sort!
      return (@values[l/2-1]+@values[l/2])/2 if l%2==0
      @values[(l+1)/2-1]
    end

    def standard_deviation
      return 0 if @count<=1
      Math.sqrt((@sum_squares - (@sum*@sum/@count))/ (@count))
    end

    def to_s(label_size = DEFAULT_LABEL_SIZE)
      if count > 0
        sprintf("%*s %6d %9.2f %7d %7d %7d %7d %7d", -label_size, key, count, sum, max*1000.0, median*1000.0, average*1000.0, min*1000.0, standard_deviation*1000.0)
      else
        sprintf("%*s %6d", -label_size, key, 0)
      end
    end

    def self.test
      stat = Stat.new(30)
      stat.add(5)
      stat.add(6)
      stat.add(8)
      stat.add(9)
      results = [7==stat.median ? "median Success" : "median Failure"]
      results <<= (7==stat.average ? "average Success" : "average Failure")
      results <<= (158==(stat.standard_deviation*100).round ? "std Success" : "std Failure")
      puts results.join("\n")
      exit (results.select { |m| m =~ /Failure/ }.size)
    end

  end

end
