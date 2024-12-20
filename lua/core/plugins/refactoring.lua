local refactor = require("refactoring")

refactor.setup({
	prompt_func_return_type = {
		go = false,
		java = false,
        javascript = false,
		cpp = false,
		c = false,
		h = false,
		hpp = false,
		cxx = false,
	},
	prompt_func_param_type = {
		go = false,
		java = false,

		cpp = false,
		c = false,
		h = false,
		hpp = false,
		cxx = false,
	},
	printf_statements = {},
	print_var_statements = {
        javascript = {
            'console.log(":: %s: ", %s);'
        }
    },
	show_success_message = true, -- shows a message with information about the refactor on success
	-- i.e. [Refactor] Inlined 3 variable occurrences
})
