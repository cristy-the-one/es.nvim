local M = {}

function M.es_search()
	-- Prompt the user for a search query
	vim.ui.input({ prompt = "Locate: " }, function(input)
		if not input or input == "" then
			return
		end
		-- Execute the 'es' command with the user's query
		local output = vim.fn.systemlist("es " .. vim.fn.shellescape(input))
		if vim.v.shell_error ~= 0 then
			print("Error running es: " .. table.concat(output, "\n"))
			return
		end
		if #output == 0 then
			print("No results found")
			return
		end
		-- Use fzf-lua to display the search results
		require("fzf-lua").fzf_exec(output, {
			prompt = "Fuzzy > ",
			actions = {
				-- Open the selected file when the user confirms their choice
				["default"] = function(selected)
					local filepath = selected[1]
					if vim.fn.isdirectory(filepath) == 1 then
						vim.cmd("cd " .. vim.fn.fnameescape(filepath))
						require("neo-tree.command").execute({
							action = "focus",
							source = "filesystem",
							position = "left",
							reveal = true,
							dir = filepath,
						})
					else
						vim.cmd("edit " .. vim.fn.fnameescape(filepath))
					end
				end,
			},
		})
	end)
end

function M.setup()
	-- Create a user command for easy access
	vim.api.nvim_create_user_command("EsSearch", M.es_search, {})
	-- Optional: Set up a key mapping
	-- vim.api.nvim_set_keymap("n", "<leader>se", '<cmd>lua require("es").es_search()<CR>', { noremap = true, silent = true })
end

return M
