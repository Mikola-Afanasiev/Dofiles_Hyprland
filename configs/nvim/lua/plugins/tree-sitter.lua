return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
--    ensure_installed = {
--      "bash", "yaml", "toml", "ini",  
--      "lua", "python",                
--      "c", "cpp", "go",               
--      "dockerfile", "terraform", "hcl",  
      -- "json", "jsonc", "xml",         
      -- "html", "css", "javascript", "typescript", "tsx", 
      -- "vim", "vimdoc",                
      -- "sql", "pgsql", "sqlite",       
      -- "markdown", "markdown_inline",  
      -- "gitignore", "git_config",      
      -- "regex", "comment",             
      -- "ninja", "make",               
      -- "java", "kotlin", "scala",     
      -- "rust", "go",                  
      -- "haskell", "ocaml",            
      -- "dockerfile", "nginx", "apache" 
--    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true }
  })
  end
}
