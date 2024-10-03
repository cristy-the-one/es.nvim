local M = {}

function M.es_search()
	-- Prompt the user for a search query
	vim.ui.input({ prompt = "Locate: " }, function(input)
		if not input or input == "" then
			return
		end
		-- Execute the 'es' command with the user's query
		local results = vim.fn.systemlist("es " .. vim.fn.shellescape(input))
		if vim.v.shell_error ~= 0 then
			print("Error running es: " .. table.concat(results, "\n"))
			return
		end
		if #results == 0 then
			print("No results found")
			return
		end
		local entries = {}
		local devicons = require("nvim-web-devicons")
		for _, filepath in ipairs(results) do
			local icon = ""
			local filename = vim.fn.fnamemodify(filepath, ":t")
			local extension = vim.fn.fnamemodify(filename, ":e")
			if vim.fn.isdirectory(filepath) == 1 then
				icon = devicons.get_icon("folder", "", { default = true }) or "📁"
			else
				icon = devicons.get_icon(filename, extension, { default = true }) or "📄"
			end
			local display_text = icon .. " " .. filepath
			table.insert(entries, {
				text = filepath, -- The actual file path
				display = display_text, -- What fzf-lua will display
				path = filepath, -- Path field (optional but useful)
			})
		end
		-- Use fzf-lua to display the search results
		require("fzf-lua").fzf_exec(entries, {
			prompt = "Fuzzy > ",
			actions = {
				-- Open the selected file when the user confirms their choice
				["default"] = function(selected)
					local item = selected[1]
					local filepath = item.text or item.path
					if not filepath then
						print("Error: Unable to find the selected file. ")
						return
					end
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
