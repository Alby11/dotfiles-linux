nmap <leader>TT :TagbarToggle<CR>
nmap <leader>T :TagbarOpen fj<CR>

let g:tagbar_type_ansible = {
			\ 'ctagstype' : 'ansible',
			\ 'kinds' : [
			\ 't:tasks'
			\ ],
			\ 'sort' : 0
			\ }

let g:tagbar_type_css = {
			\ 'ctagstype' : 'Css',
			\ 'kinds'     : [
			\ 'c:classes',
			\ 's:selectors',
			\ 'i:identities'
			\ ]
			\ }

let g:tagbar_type_json = {
			\ 'ctagstype' : 'json',
			\ 'kinds' : [
			\ 'o:objects',
			\ 'a:arrays',
			\ 'n:numbers',
			\ 's:strings',
			\ 'b:booleans',
			\ 'z:nulls'
			\ ],
			\ 'sro' : '.',
			\ 'scope2kind': {
			\ 'object': 'o',
			\ 'array': 'a',
			\ 'number': 'n',
			\ 'string': 's',
			\ 'boolean': 'b',
			\ 'null': 'z'
			\ },
			\ 'kind2scope': {
			\ 'o': 'object',
			\ 'a': 'array',
			\ 'n': 'number',
			\ 's': 'string',
			\ 'b': 'boolean',
			\ 'z': 'null'
			\ },
			\ 'sort' : 0
			\ }

let g:tagbar_type_make = {
			\ 'kinds':[
			\ 'm:macros',
			\ 't:targets'
			\ ]
			\}

let g:tagbar_type_markdown = {
			\ 'ctagstype'	: 'markdown',
			\ 'kinds'		: [
			\ 'c:chapter:0:1',
			\ 's:section:0:1',
			\ 'S:subsection:0:1',
			\ 't:subsubsection:0:1',
			\ 'T:l4subsection:0:1',
			\ 'u:l5subsection:0:1',
			\ ],
			\ 'sro'			: '""',
			\ 'kind2scope'	: {
			\ 'c' : 'chapter',
			\ 's' : 'section',
			\ 'S' : 'subsection',
			\ 't' : 'subsubsection',
			\ 'T' : 'l4subsection',
			\ },
			\ 'scope2kind'	: {
			\ 'chapter' : 'c',
			\ 'section' : 's',
			\ 'subsection' : 'S',
			\ 'subsubsection' : 't',
			\ 'l4subsection' : 'T',
			\ },
			\ }

let g:tagbar_type_ps1 = {
			\ 'ctagstype' : 'powershell',
			\ 'kinds'     : [
			\ 'f:function',
			\ 'i:filter',
			\ 'a:alias'
			\ ]
			\ }

let g:tagbar_type_snippets = {
			\ 'ctagstype' : 'snippets',
			\ 'kinds' : [
			\ 's:snippets',
			\ ]
			\ }
