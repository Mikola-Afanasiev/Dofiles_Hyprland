-- lazy vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

--
--
-- -- Функция для поиска и замены переменных с использованием telescope
-- function RenameVariablesWithTelescope()
--     local variables = {}
--     local current_buf = vim.api.nvim_get_current_buf()
--     local lines = vim.api.nvim_buf_get_lines(current_buf, 0, -1, false)
--
--     -- Переменная для отслеживания многострочных комментариев
--     local inside_multiline_comment = false
--
--     -- Регулярные выражения для поиска комментариев и строк
--     local single_line_comment = "^%s*//"  -- Для однострочных комментариев
--     local multiline_comment_start = "^%s*/%*"  -- Начало многострочного комментария
--     local multiline_comment_end = "%*/"  -- Конец многострочного комментария
--     local string_literal = '"[^"]*"'  -- Строковый литерал (для одиночных кавычек можно добавить)
--    
--     -- Перебираем строки и ищем переменные
--     for _, line in ipairs(lines) do
--         -- Пропускаем строки, если они находятся в многострочном комментарии
--         if inside_multiline_comment then
--             if line:match(multiline_comment_end) then
--                 inside_multiline_comment = false  -- Закрываем многострочный комментарий
--             end
--         elseif not line:match(single_line_comment) then
--             -- Пропускаем многострочные комментарии
--             if line:match(multiline_comment_start) then
--                 inside_multiline_comment = true
--             end
--
--             -- Пропускаем строки внутри строковых литералов
--             local modified_line = line
--             for str in modified_line:gmatch(string_literal) do
--                 modified_line = modified_line:gsub(str, "")  -- Убираем строки, чтобы не искать переменные внутри них
--             end
--
--             -- Ищем переменные только в строках, которые не являются комментариями или строками
--             for var in string.gmatch(modified_line, "%w+") do
--                 -- Добавляем найденные переменные в список, если еще не добавлены
--                 if not vim.tbl_contains(variables, var) then
--                     table.insert(variables, var)
--                 end
--             end
--         end
--     end
--
--     -- Если переменные найдены
--     if #variables > 0 then
--         -- Используем vim.ui.select для выбора старой переменной
--         vim.ui.select(variables, {
--             prompt = "Select the old variable to rename",
--         }, function(oldVar)
--             -- После выбора старой переменной, запрашиваем новую переменную
--             if oldVar then
--                 local newVar = vim.fn.input("Enter the new variable name: ")
--
--                 -- Выполняем замену по всему файлу
--                 vim.cmd(string.format('%%s/\\<%s\\>/%s/g', oldVar, newVar))
--             end
--         end)
--     else
--         print("No variables found in the current buffer.")
--     end
-- end
--
-- -- Привязываем команду для вызова через командный режим
-- vim.api.nvim_create_user_command('RenameVars', RenameVariablesWithTelescope, {})






-- -- Функция для переименования переменных
-- function RenameVariables()
--   -- Запрашиваем старую и новую переменную
--   local oldVar = vim.fn.input('Enter the old variable name: ')
--   local newVar = vim.fn.input('Enter the new variable name: ')
--
--   -- Выполняем замену по всему файлу
--   vim.cmd(string.format('%%s/\\<%s\\>/%s/g', oldVar, newVar))
-- end
--
-- -- Привязываем команду к удобному бинду
-- vim.api.nvim_set_keymap('n', '<leader>rn', ':lua RenameVariables()<CR>', { noremap = true, silent = true })
--
-- vim.api.nvim_create_user_command('RenameVars', RenameVariables, {})
