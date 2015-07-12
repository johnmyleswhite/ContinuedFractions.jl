using OEIS
using Iterators

function test_cf_oeis(c,id)
    # quotients of pi
    s = oeis(id)
    for (o,q) = zip(s.values, continuedfraction(c))
        @test o == q
    end
end

function test_conv_oeis(c, idn, idd, ofn=0, ofd=ofn)
    sn = oeis(idn)
    sd = oeis(idd)
    for (on,od,r) in zip(sn.values[(ofn+1):end], sd.values[(ofd+1):end], convergents(c))
        @test on//od == r
    end
end

test_cf_oeis(pi, :A001203)
test_cf_oeis(e,  :A003417)
test_cf_oeis(γ,  :A002852)
test_cf_oeis(catalan, :A014538)
test_cf_oeis(golden, :A000012)

test_conv_oeis(pi, :A002485, :A002486, 2)
test_conv_oeis(e,  :A007676, :A007677)
test_conv_oeis(γ,  :A046114, :A046115)
test_conv_oeis(catalan,  :A153069, :A153070, 2)
test_conv_oeis(golden, :A000045, :A000045, 2, 1)

# 
