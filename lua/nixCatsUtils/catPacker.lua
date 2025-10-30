--[[
  This directory is the luaUtils template.
  You can choose what things from it that you would like to use.
  And then delete the rest.
  Everything in this directory is optional.
--]]

local M = {}
-- NOTE: This function is for defining a paq.nvim fallback method of downloading plugins
-- when nixCats was not used to install your config.
-- If you only ever load your config using nixCats, you don't need this file.

-- it literally just only runs it when not on nixCats
-- all neovim package managers that use the regular plugin loading scheme
-- can be used this way, just do whatever the plugin manager needs to put it in the
-- opt directory for lazy loading, and add the build steps so that when theres no nix the steps are ran
function M.setup(v)
    if not vim.g[ [[nixCats-special-rtp-entry-nixCats]] ] then
        local function clone_paq()
            local path = vim.fn.stdpath("data") .. "/site/pack/paqs/start/paq-nvim"
            local is_installed = vim.fn.empty(vim.fn.glob(path)) == 0
            if not is_installed then
                vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/savq/paq-nvim.git", path })
                return true
            end
        end
        local function bootstrap_paq(packages)
            local first_install = clone_paq()
            vim.cmd.packadd("paq-nvim")
            local paq = require("paq")
            if first_install then
                vim.notify("Installing plugins... If prompted, hit Enter to continue.")
            end
            paq(packages)
            local pkg_count = #require("paq").query("to_install")
            if pkg_count > 0 then
                vim.notify(string.format("There are %d packages to install", pkg_count))
                paq.install()
            end
        end
        bootstrap_paq(vim.list_extend({ "savq/paq-nvim" }, v))
    end
end
return M
