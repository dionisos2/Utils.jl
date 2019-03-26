import Base

struct ReadOnlySubArray{TK <: Any, TV <:Any, P<:AbstractDict{TK, TV}} <: AbstractDict{TK, TV}
    parent::P
end

Base.get(collection::ReadOnlySubArray{TK, TV}, key::TK, default::TV) where TK where TV = get(collection.parent, key, default)
Base.get(collection::ReadOnlySubArray{TK}, key::TK, default::Symbol) where TK  = get(collection.parent, key, default)
Base.haskey(collection::ReadOnlySubArray{TK, TV}, key::TK) where TK where TV = haskey(collection.parent, key)
Base.length(collection::ReadOnlySubArray) = length(collection.parent)
Base.iterate(collection::ReadOnlySubArray, i) = iterate(collection.parent, i)
Base.iterate(collection::ReadOnlySubArray) = iterate(collection.parent)
Base.setindex!(collection::ReadOnlySubArray{TK, TV}, ::TV, ::TK) where TK where TV = error("ReadOnlySubArray are readonly (no joke)")

function readonly_view(collection::AbstractDict)
    return ReadOnlySubArray(collection)
end
