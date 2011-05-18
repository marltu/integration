f = lambda { |x| Math.sin(3*x) }
a = 0.0
b = Math::PI/3
e = 0.00000001

def simpson(f, a, b, e = 0.001, n = 10, sn2 = 1.0/0)

    fi = lambda do |i|
        case i
        when 0 then f.call(a)
        when n then f.call(b)
        else f.call(a + i*(b-a)/n)
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
    else
        return sn
    end
end

simpson(f, a, b, e)
