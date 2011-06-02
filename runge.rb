require "gnuplot"


f = lambda { |x, u| u * Math.cos(u - x/2.0)**2 + 0.1 * x**2 }
#f = lambda { |x, y| (1 - Math.sin(y + 2 * x) + ((0.5 * y) / (2 + x))) }
a = 0
b = 1
h = [0.1, 0.05, 0.025, 0.0125]
#h = [0.1, 0.05, 0.025, 0.0125]
#yi = (0.1..1.5).step(0.1).collect
yi = [1.0]


def runge(f, a, b, h, yi)
    print "h: #{h}\n"

    x = []
    y = []

    interval = a..b
    interval.step(h) do |xi| 
# o = 1/2
        k1 = f.call(xi, yi)
        k2 = f.call(xi + h, yi + k1*h)

        yi1 = yi + (k1 + k2).fdiv(2) * h
# o = 1
#        k1 = f.call(xi, yi)
#        k2 = f.call(xi + 0.5*h, yi + 0.5*k1*h)
#        yi1 = yi + k2 * h


        print "xi: #{xi} yi: #{yi}\n"
        x << xi
        y << yi

        yi = yi1
    end

    return [x, y]
end

Gnuplot.open do |gp|
    Gnuplot::Plot.new(gp) do |plot|
        yi.each do |cy|
            uh = 1/0.0
            diff = 1/0.0
            h.each do |h1|
                xy = runge(f, a, b, h1, cy)
                    
                uh2 = xy[1][xy[1].size() -1]
                diff1 = (uh2 - uh).abs.fdiv(2**2 -1)

                ddiff = diff.fdiv(diff1)

                plot.data << Gnuplot::DataSet.new(xy) do |ds|
                  ds.with = "lines"
                  ds.linewidth = 1
                  ds.title = ""
                  ds.title = "y0: #{cy} h:#{h1} d:(%.6f) dd:(#{ddiff})" % diff1
                end
                uh = uh2
                diff = diff1
            end
        end
    end
end





