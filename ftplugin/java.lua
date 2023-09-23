local fn = vim.fn

local path_to_java = os.getenv("JAVA_HOME") .. '/bin/java'
local jdtls_dir = fn.stdpath('data') .. '/mason/packages/jdtls'

local config_dir = jdtls_dir .. '/config_mac'
local plugins_dir = jdtls_dir .. '/plugins/'

local path_to_jar = plugins_dir .. 'org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar'
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == "" then
    return
end

local home = os.getenv("HOME")
local project_name = fn.fnamemodify(fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/.cache/jdtls/workspace/' .. project_name
os.execute("mkdir " .. workspace_dir)


-- On attach function
package.path = package.path .. ";../?.lua"
local keymaps = require("core.keymaps")
-- print('keymaps not nil: ', keymaps.map_java_keys ~= nil)
-- local keymaps = loadfile "../lua/core/keymaps.lua"
local on_attach = function(client, bufnr)
    keymaps.map_java_keys(bufnr)
end

-- Main Config
-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    on_attach = on_attach,
    -- The command that starts ,the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {
        -- 💀
        path_to_java, -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
        -- 💀
        '-jar', path_to_jar,
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version
        -- 💀
        '-configuration', config_dir,
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.
        -- 💀
        -- See `data directory configuration` section in the README
        '-data', workspace_dir,
    },

    root_dir = root_dir,

    settings = {
        java = {
            home = path_to_java,
            eclipse = {
                downloadSources = true,
            },
            configuration = {
                updateBuildConfiguration = "interactive",
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = "/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home",
                        javadoc = "https://docs.oracle.com/en/java/javase/17/docs/api/",
                        default = true
                    },
                    {
                        name = "JavaSE-11",
                        path = "/Library/Java/JavaVirtualMachines/jdk-11.0.15.jdk/Contents/Home"
                    }
                }
            },
            maven = {
                downloadSources = true,
            },
            implementationsCodeLens = {
                enabled = true,
            },
            referencesCodeLens = {
                enabled = true,
            },
            references = {
                includeDecompiledSources = true,
            },
            format = {
                enabled = true,
                settings = {
                    url = fn.stdpath "config" .. "/formatters/charter-gateway-eclipse-formatter.xml",
                    profile = "CharterStyle",
                },
            },
        },

        signatureHelp = { enabled = true },

        completion = {
            favoriteStaticMembers = {
                "org.hamcrest.MatcherAssert.assertThat",
                "org.hamcrest.Matchers.*",
                "org.hamcrest.CoreMatchers.*",
                "org.junit.jupiter.api.Assertions.*",
                "java.util.Objects.requireNonNull",
                "java.util.Objects.requireNonNullElse",
                "org.mockito.Mockito.*",
            },
            importOrder = {
                "java",
                "javax",
                "com",
                "org"
            },
        },

        sources = {
            organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
            },
        },

        codeGeneration = {
            toString = {
                template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
            },
            useBlocks = true,
        },

        flags = {
            allow_incremental_sync = true,
        },

        init_options = {
            bundles = {},
        },
    }
}

-- -- Setup an attach function
-- config['on_attach'] = function(client, bufnr)
--     require("keymaps").map_java_keys(bufnr)
-- end

require('jdtls').start_or_attach(config)
