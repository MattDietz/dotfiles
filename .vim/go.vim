""" Use gopls language server
let g:go_gopls_enabled = 0

""" turn on auto-completion
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
"""-go settings

let g:go_highlight_extra_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

""" Turn on native neovim LSP client
""" lua require("lsp_config")
""" autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
""" autocmd BufWritePre *.go lua goimports(1000)

""" Vim-go settings
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

python3 << EOF
import vim
import json

gopls_cfg = json.loads("""{
	"formatting.gofumpt": true,
	"ui.diagnostic.staticcheck": true,
	"ui.diagnostic.analyses": {
		"ST1000": false,
		"ST1003": false,
		"SA5001": false,
		"nilness": true,
		"unusedwrite": true,
		"fieldalignment": true,
		"shadow": false,
		"composites": false
	},
	"ui.codelenses": {
		"generate": true,
		"regenerate_cgo": true,
		"test": true,
		"vendor": true,
		"tidy": true,
		"upgrade_dependency": true,
		"gc_details": true
	},
	"ui.diagnostic.annotations": {
		"bounds": true,
		"inline": true,
		"escape": true,
		"nil": true
	},

	"ui.completion.usePlaceholders": true,
	"ui.navigation.importShortcut": "Definition",
	"ui.completion.completionBudget": "500ms",

	"build.allowImplicitNetworkAccess": true,
	"build.directoryFilters": ["-node_modules", "-data"],

	"ui.diagnostic.diagnosticsDelay": "300ms",
	"ui.completion.experimentalPostfixCompletions": true,
	"build.experimentalPackageCacheKey": true
}""")
EOF

let g:go_gopls_settings = py3eval("gopls_cfg")

function! s:go_guru_scope_from_git_root()
  let gitroot = system("git rev-parse --show-toplevel | tr -d '\n'")
  let pattern = escape(go#util#gopath() . "/src/", '\ /')
  return substitute(gitroot, pattern, "", "") . "/... -vendor/"
endfunction

au FileType go silent exe "GoGuruScope " . s:go_guru_scope_from_git_root()
