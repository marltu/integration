f = lambda { |x| Math.sin(3*x) }
a = 0.0
b = Math::PI/3
e = 0.00000001

def simpson(f, a, b, e = 0.001, n = 10, sn2 = 1.0/0, diff = 1.0/0)

    fi = lambda { |i| f.call(a + i*(b-a)/n) }

    sum_collect = lambda do |interval| 
        interval.step(2).collect { |i| fi.call(i) }.inject { |s, y| s + y } 
    end

    sn = (b - a) / (3*n) * (
        f.call(a) + 
        4 * sum_collect.call( (1 .. n-1) ) + 
        2 * sum_collect.call( (2 .. n-2) ) + 
        f.call(b)
    )

    diff1 = (sn - sn2).abs / (2 ** 3 - 1)

    print "n = #{n}; Sn = #{sn} diff: #{diff1} ddiff #{diff/diff1}\n"

    if (diff > e)
        simpson(f, a, b, e, n * 2, sn, diff1)
    else
        sn
    end
end

simpson(f, a, b, e)
