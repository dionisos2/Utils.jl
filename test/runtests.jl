using Test
using Utils


tests = ["readonlysubarray_test.jl"]

for test in tests
  include(test)
end
