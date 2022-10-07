-- set config environment variable for DOS
local configFile = os.getenv('OneDriveCommercial') .. "profileFiles\\starship.toml"
-- os.setenv('STARSHIP_CONFIG', configFile)

load(io.popen('starship init cmd'):read("*a"))()
