

function wait_for_key(io = stdin)::Char
    setraw!(raw) = ccall(:jl_tty_set_mode, Int32, (Ptr{Cvoid},Int32), io.handle, raw)
    setraw!(true)
    res = read(io, Char)
    setraw!(false)
    return res
end
