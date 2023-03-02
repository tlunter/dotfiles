local lspconfig = require('lspconfig')

-- vim.lsp.set_log_level("debug")

local format_async = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then return end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
        local view = vim.fn.winsaveview()
        vim.lsp.util.apply_text_edits(result, bufnr)
        vim.fn.winrestview(view)
        if bufnr == vim.api.nvim_get_current_buf() then
            vim.api.nvim_command("noautocmd :update")
        end
    end
end

vim.lsp.handlers["textDocument/formatting"] = format_async

local on_attach = function(client, bufnr)
  vim.api.nvim_exec([[
   augroup LspAutocommands
       autocmd! * <buffer>
       autocmd BufWritePre <buffer> LspFormatting
   augroup END
   ]], true)
end

local eslint = {
  lintCommand = "node_modules/.bin/eslint -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
}

local prettier = {
  formatCommand = "ASDF_NODEJS_VERSION=10.24.1 eslint_d --fix-to-stdout --stdin --stdin-filename ${INPUT}",
  formatStdin = true
}

local languages = {
    javascript = {prettier, eslint},
    javascriptreact = {prettier, eslint},
    typescript = {prettier, eslint},
    typescriptreact = {prettier, eslint},
}

lspconfig.efm.setup {
    root_dir = lspconfig.util.root_pattern(".git"),
    filetypes = vim.tbl_keys(languages),
    init_options = {documentFormatting = true},
    settings = {languages = languages, log_level = 1, log_file = '~/.cache/nvim/efm.log'},
    on_attach = on_attach,
}

lspconfig.tsserver.setup {
}

vim.cmd("command! LspFormatting lua vim.lsp.buf.format({ timeout_ms = 1000 })")
vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
vim.cmd("command! LspFloat lua vim.diagnostic.open_float()")
