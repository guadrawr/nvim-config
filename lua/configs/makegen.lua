local libs = {
    raylib = {
        cflags = '-I"C:/DevLib/raylib/include"',
        ldflags = '-L"C:/DevLib/raylib/lib" -lraylib -lopengl32 -lgdi32 -lwinmm',
        dlls = { "raylib.dll" },
        bin_path = "C:/DevLib/raylib/bin",
        compiler = "g++",
        src = "main.cpp",
        out = "raylib_game.exe",
    },
    SDL3 = {
        cflags = '-I"C:/DevLib/SDL3/include"',
        ldflags = '-L"C:/DevLib/SDL3/lib" -lSDL3',
        dlls = { "SDL3.dll" },
        bin_path = "C:/DevLib/SDL3/bin",
        compiler = "g++",
        src = "main.cpp",
        out = "sdl_game.exe",
    },
    SFML3 = {
        cflags = '-I"C:/DevLib/SFML/include"',
        ldflags = '-L"C:/DevLib/SFML/lib" -lsfml-graphics -lsfml-window -lsfml-system',
        dlls = { "sfml-graphics-3.dll", "sfml-window-3.dll", "sfml-system-3.dll" },
        bin_path = "C:/DevLib/SFML/bin",
        compiler = "g++",
        src = "main.cpp",
        out = "sfml_game.exe",
    },
}

local function copy_dlls(lib)
    local cwd = vim.fn.getcwd()
    for _, dll in ipairs(lib.dlls or {}) do
        local src = lib.bin_path .. "/" .. dll
        local dst = cwd .. "/" .. dll
        local ok = os.execute(string.format('copy "%s" "%s"', src, dst))
        if ok then
            print("📦 Copied: " .. dll)
        else
            print("❌ Failed to copy: " .. dll)
        end
    end
end

local function generate_makefile()
    vim.ui.select(vim.tbl_keys(libs), { prompt = "Select Lib:" }, function(choice)
        if not choice then
            return
        end
        local lib = libs[choice]

        local content = string.format(
            "CC = %s\n"
                .. "CFLAGS = %s\n"
                .. "LDFLAGS = %s\n\n"
                .. "SRC = %s\n"
                .. "OUT = %s\n\n"
                .. "all:\n"
                .. "\t$(CC) $(SRC) -o $(OUT) $(CFLAGS) $(LDFLAGS)\n",
            lib.compiler,
            lib.cflags,
            lib.ldflags,
            lib.src,
            lib.out
        )

        local file = io.open("Makefile", "w")
        file:write(content)
        file:close()

        print("✅ Makefile has create for lib " .. choice)
        copy_dlls(lib)
    end)
end

return {
    generate_makefile = generate_makefile,
}
