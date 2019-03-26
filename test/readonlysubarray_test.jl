using Test

array = Dict('a'=>1, 'b'=>2, 'c'=>3)

@testset "ReadOnlySubArray" begin
    @testset "Constructor" begin
        ro = ReadOnlySubArray(array)
        @test ro['a'] == 1
        @test ro['b'] == 2
    end

    @testset "Basics methods" begin
        ro = ReadOnlySubArray(array)
        @test length(ro) == 3
        @test Set(keys(ro)) == Set(['a', 'b', 'c'])
        @test Set(values(ro)) == Set([1, 2, 3])
        @test Set(v for v in ro) == Set(['a'=>1, 'b'=>2, 'c'=>3])
        @test ro == array
        @test get(ro, 'b', 10) == 2
        @test get(ro, 'v', 10) == 10
    end

    @testset "Unmodifiable and other errors" begin
        ro = ReadOnlySubArray(array)
        @test_throws ErrorException ro['a'] = 5
        @test_throws MethodError get(ro, 'b', 10.5)
        @test_throws MethodError ro[2]
        @test_throws MethodError ro['a'] = 'a'
        @test_throws KeyError ro['v']
    end

    @testset "Test readonly_view function" begin
        ro = readonly_view(array)
        @test ro == array
        @test isa(ro, ReadOnlySubArray)
        @test_throws ErrorException ro['a'] = 5
    end

end

