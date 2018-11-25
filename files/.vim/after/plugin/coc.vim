scriptencoding utf-8

if !exists('g:did_coc_loaded')
  finish
endif

let s:LSP_CONFIG = {
      \ 'flow': {
      \   'config': {
      \     'command': exepath('flow-language-server'),
      \     'args': ['--stdio'],
      \     'filetypes': ['javascript', 'javascript.jsx'],
      \     'rootPatterns': ['.flowconfig']
      \    }
      \ },
      \ 'ocaml': {
      \   'config': {
      \     'command': exepath('ocaml-language-server'),
      \     'args': ['--stdio'],
      \     'filetypes': ['ocaml', 'reason']
      \    }
      \ },
      \ 'bash': {
      \   'config': {
      \     'command': exepath('bash-language-server'),
      \     'args': ['start'],
      \     'filetypes': ['sh', 'bash'],
      \     'ignoredRootPaths': ['~']
      \    }
      \ },
      \ 'docker': {
      \   'config': {
      \     'command': exepath('docker-langserver'),
      \     'args': ['--stdio'],
      \     'filetypes': ['dockerfile']
      \    }
      \ },
      \ 'clojure': {
      \    'command': [exepath('clojure-lsp')],
      \    'config': {
      \      'command': exepath('clojure-lsp'),
      \      'filetypes': ['clojure']
      \     }
      \  },
      \ }

call coc#config('coc.preferences', {
      \ 'autoTrigger': 'always',
      \ 'colorSupport': 1,
      \ 'diagnostic.errorSign': '×',
      \ 'diagnostic.warningSign': '●',
      \ 'diagnostic.infoSign': '!',
      \ 'diagnostic.hintSign': '!',
      \ })

call coc#config('highlight', {
      \ 'colors': 1,
      \ 'disableLanguages': ['vim']
      \ })

let s:languageservers = {}
for [lsp, config] in items(s:LSP_CONFIG)
  if lsp ==# 'flow' | call coc#config('tsserver', { 'enableJavascript': 1 }) | endif
  let s:languageservers[lsp] = get(config, 'config')
endfor

if !empty(s:languageservers)
  call coc#config('languageserver', s:languageservers)
endif
