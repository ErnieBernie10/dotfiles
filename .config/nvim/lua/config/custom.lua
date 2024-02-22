local api = vim.api
local cmd = vim.cmd

-- Function to decrypt and load the file into a buffer
local function decrypt_and_load(filename)
  local decrypted_content = vim.fn.system("gpg -d " .. filename)
  local buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(buf, 0, -1, true, vim.split(decrypted_content, "\n"))
  api.nvim_set_current_buf(buf)
end

-- Function to encrypt and write the buffer content to file
local function encrypt_and_save(filename)
  local buf_content = api.nvim_buf_get_lines(0, 0, -1, true)
  local content = table.concat(buf_content, "\n")
  local encrypted_content = vim.fn.system('echo "' .. content .. '" | gpg -e -o ' .. filename)
  -- You may want to handle errors and feedback to the user here
end

-- Command to decrypt and load the file
cmd("command! -nargs=1 Decrypt call decrypt_and_load(<f-args>)")

-- Command to encrypt and save the file
cmd("command! -nargs=1 Encrypt call encrypt_and_save(<f-args>)")
