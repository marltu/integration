f = lambda { |x| Math.sin(3*x) }
a = 0.0
b = Math::PI/3
e = 0.00000001

def simpson(f, a, b, e = 0.001, n = 10, sn2 = 1.0/0)

    fi = lambda do |i|
        if i == 0
            return f.call(a)
        elsif i == n
            return f.call(b)
        else
            return f.call(a + i*(b-a)/n)
        end
    end

    sn = fi.call(0) + fi.call(n)
    sn += 4 * (1 .. n-1).step(2).collect { |i| fi.call(i) }.inject { |sum, y| sum += y }
    sn += 2 * (2 .. n-2).step(2).collect { |i| fi.call(i) }.inject { |sum, y| sum += y }
    sn = sn * (b - a)/(3*n)

    diff = (sn - sn2).abs / (2 ** 3 - 1)

    print "n = #{n}; Sn = #{sn} diff: #{diff}\n"

    if (diff > e)
        return simpson(f, a, b, e, n * 2, sn)
    end
end

simpson(f, a, b, e)
