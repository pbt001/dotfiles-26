scriptencoding utf-8

let s:VIM_MINPAC_FOLDER = expand(g:DOTFILES_VIM_FOLDER . '/pack/minpac')
let s:CURRENT_FILE = expand('<sfile>')

function! plugins#installMinpac() abort
  execute 'silent !git clone https://github.com/k-takata/minpac.git ' . expand(s:VIM_MINPAC_FOLDER . '/opt/minpac')
endfunction

function! plugins#loadPlugins() abort
  silent! packadd minpac

  if !exists('*minpac#init')
    finish
  endif

  command! -bar PackUpdate call plugins#init() | call minpac#update('', {'do': 'call minpac#status()'})
  command! -bar PackStatus call plugins#init() | call minpac#status()
  command! -bar PackClean call plugins#init() | call minpac#clean()

  call minpac#init({ 'verbose': 3 })
  call minpac#add('https://github.com/k-takata/minpac', { 'type': 'opt' })

  " General {{{
  call minpac#add('https://github.com/andymass/vim-matchup')
  call minpac#add('https://github.com/tpope/vim-sensible', { 'type': 'opt' })
  call minpac#add('https://github.com/jiangmiao/auto-pairs')
  call minpac#add('https://github.com/SirVer/ultisnips')

  if !empty(glob($FZF_VIM_PATH))
    call minpac#add('https://github.com/junegunn/fzf.vim')
    set runtimepath^=$FZF_VIM_PATH
  endif
  call minpac#add('https://github.com/justinmk/vim-dirvish')
  call minpac#add('https://github.com/kristijanhusak/vim-dirvish-git')
  call minpac#add('https://github.com/junegunn/vim-peekaboo')
  call minpac#add('https://github.com/junegunn/rainbow_parentheses.vim')
  call minpac#add('https://github.com/mbbill/undotree', { 'type': 'opt' })
  call minpac#add('https://github.com/mhinz/vim-grepper', { 'type': 'opt' })
  call minpac#add('https://github.com/mhinz/vim-sayonara', { 'type': 'opt' })
  call minpac#add('https://github.com/mhinz/vim-startify')
  call minpac#add('https://github.com/nelstrom/vim-visual-star-search')
  call minpac#add('https://github.com/tpope/tpope-vim-abolish')
  call minpac#add('https://github.com/tpope/vim-apathy')
  call minpac#add('https://github.com/tpope/vim-characterize')
  call minpac#add('https://github.com/tpope/vim-commentary')
  call minpac#add('https://github.com/tpope/vim-eunuch')
  call minpac#add('https://github.com/tpope/vim-projectionist')
  call minpac#add('https://github.com/tpope/vim-repeat')
  call minpac#add('https://github.com/tpope/vim-scriptease')
  call minpac#add('https://github.com/tpope/vim-speeddating')
  call minpac#add('https://github.com/tpope/vim-surround')
  call minpac#add('https://github.com/wellle/targets.vim')
  call minpac#add('https://github.com/wincent/loupe')
  call minpac#add('https://github.com/wincent/terminus')
  call minpac#add('https://github.com/tommcdo/vim-lion')
  call minpac#add('https://github.com/christoomey/vim-tmux-navigator', {'type': 'opt'})
  " }}}

  " Autocompletion {{{
  let s:coc_extensions = [
        \ 'coc-css',
        \ 'coc-rls',
        \ 'coc-html',
        \ 'coc-json',
        \ 'coc-pyls',
        \ 'coc-yaml',
        \ 'coc-emoji',
        \ 'coc-tsserver',
        \ 'coc-ultisnips',
        \ 'coc-highlight'
        \ ]
  function! s:PlugCoc(hooktype, name) abort
    call coc#util#install()
    call coc#util#install_extension(join(get(s:, 'coc_extensions', [])))
  endfunction

  call minpac#add('https://github.com/neoclide/coc.nvim', {'do': function('s:PlugCoc')})
  call minpac#add('https://github.com/Shougo/neco-vim')
  call minpac#add('https://github.com/neoclide/coc-neco')
  " }}}

  " Syntax {{{
  " call minpac#add('https://github.com/chrisbra/Colorizer')
  call minpac#add('https://github.com/sheerun/vim-polyglot')
  call minpac#add('https://github.com/styled-components/vim-styled-components')
  call minpac#add('https://github.com/reasonml-editor/vim-reason-plus')
  call minpac#add('https://github.com/jez/vim-github-hub')
  call minpac#add('https://github.com/jxnblk/vim-mdx-js')
  call minpac#add('https://github.com/neoclide/vim-jsx-improve')
  " }}}

  " Linters & Code quality {{{
  call minpac#add('https://github.com/w0rp/ale', { 'do': '!yarn global add prettier' })
  " }}}

  " Git {{{
  call minpac#add('https://github.com/airblade/vim-gitgutter')
  call minpac#add('https://github.com/lambdalisue/vim-gista')
  call minpac#add('https://github.com/tpope/vim-fugitive')
  call minpac#add('https://github.com/tpope/vim-rhubarb')
  call minpac#add('https://github.com/shumphrey/fugitive-gitlab.vim')
  call minpac#add('https://github.com/tommcdo/vim-fubitive')
  call minpac#add('https://github.com/AGhost-7/critiq.vim')
  " }}}

  " Writing {{{
  call minpac#add('https://github.com/junegunn/goyo.vim', { 'type': 'opt' })
  call minpac#add('https://github.com/junegunn/limelight.vim', { 'type': 'opt' })
  " }}}

  " Themes, UI & eye cnady {{{
  call minpac#add('https://github.com/tomasiser/vim-code-dark', { 'type': 'opt' })
  call minpac#add('https://github.com/tyrannicaltoucan/vim-deep-space', { 'type': 'opt' })
  call minpac#add('https://github.com/rakr/vim-two-firewatch', { 'type': 'opt' })
  call minpac#add('https://github.com/logico-dev/typewriter', { 'type': 'opt' })
  call minpac#add('https://github.com/agreco/vim-citylights', { 'type': 'opt'  })
  call minpac#add('https://github.com/andreypopp/vim-colors-plain', { 'type': 'opt' })
  " }}}

  call minpac#add('https://github.com/wakatime/vim-wakatime', { 'type': 'opt'  })
  if getcwd() =~ 'Sites/work'
    silent! packadd vim-wakatime
  endif
endfunction

if !exists('*plugins#init')
  function! plugins#init() abort
    exec 'source ' . s:CURRENT_FILE

    if empty(glob(s:VIM_MINPAC_FOLDER))
      call plugins#installMinpac() | call plugins#loadPlugins() | call minpac#update('', {'do': 'quit'})
    else
      call plugins#loadPlugins()
    endif
  endfunction
endif
