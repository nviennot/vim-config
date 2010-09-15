"=============================================================================
" Copyright (c) 2007-2010 Takeshi NISHIDA
"
" GetLatestVimScripts: 1984 1 :AutoInstall: FuzzyFinder
"=============================================================================
" LOAD GUARD {{{1

if !l9#guardScriptLoading(expand('<sfile>:p'), 702, 100)
  finish
endif

" }}}1
"=============================================================================
" LOCAL FUNCTIONS {{{1

"
function s:initialize()
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_modes'  , [
        \   'buffer', 'file', 'dir', 'mrufile', 'mrucmd',
        \   'bookmark', 'tag', 'taggedfile',
        \   'jumplist', 'changelist', 'quickfix', 'line', 'help',
        \   'givenfile', 'givendir', 'givencmd',
        \   'callbackfile', 'callbackitem',
        \ ])
  call l9#defineVariableDefault('g:fuf_modesDisable'     , [ 'mrufile', 'mrucmd', ])
  call l9#defineVariableDefault('g:fuf_keyOpen'          , '<CR>')
  call l9#defineVariableDefault('g:fuf_keyOpenSplit'     , '<C-j>')
  call l9#defineVariableDefault('g:fuf_keyOpenVsplit'    , '<C-k>')
  call l9#defineVariableDefault('g:fuf_keyOpenTabpage'   , '<C-l>')
  call l9#defineVariableDefault('g:fuf_keyPreview'       , '<C-@>')
  call l9#defineVariableDefault('g:fuf_keyNextMode'      , '<C-t>')
  call l9#defineVariableDefault('g:fuf_keyPrevMode'      , '<C-y>')
  call l9#defineVariableDefault('g:fuf_keyPrevPattern'   , '<C-s>')
  call l9#defineVariableDefault('g:fuf_keyNextPattern'   , '<C-_>')
  call l9#defineVariableDefault('g:fuf_keySwitchMatching', '<C-\><C-\>')
  call l9#defineVariableDefault('g:fuf_infoFile'         , '~/.vim-fuf')
  call l9#defineVariableDefault('g:fuf_abbrevMap'        , {})
  call l9#defineVariableDefault('g:fuf_patternSeparator' , ';')
  call l9#defineVariableDefault('g:fuf_promptHighlight'  , 'Question')
  call l9#defineVariableDefault('g:fuf_ignoreCase'       , 1)
  call l9#defineVariableDefault('g:fuf_splitPathMatching', 1)
  call l9#defineVariableDefault('g:fuf_smartBs'          , 1)
  call l9#defineVariableDefault('g:fuf_reuseWindow'      , 1)
  call l9#defineVariableDefault('g:fuf_timeFormat'       , '(%Y-%m-%d %H:%M:%S)')
  call l9#defineVariableDefault('g:fuf_learningLimit'    , 100)
  call l9#defineVariableDefault('g:fuf_enumeratingLimit' , 50)
  call l9#defineVariableDefault('g:fuf_maxMenuWidth'     , 78)
  call l9#defineVariableDefault('g:fuf_previewHeight'    , 10)
  call l9#defineVariableDefault('g:fuf_autoPreview'      , 1)
  call l9#defineVariableDefault('g:fuf_useMigemo'        , 0)
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_buffer_prompt'     , '>Buffer[]>')
  call l9#defineVariableDefault('g:fuf_buffer_switchOrder', 10)
  call l9#defineVariableDefault('g:fuf_buffer_mruOrder'   , 1)
  call l9#defineVariableDefault('g:fuf_buffer_keyDelete'  , '<C-]>')
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_file_prompt'     , '>File[]>')
  call l9#defineVariableDefault('g:fuf_file_switchOrder', 20)
  call l9#defineVariableDefault('g:fuf_file_exclude'    , '\v\~$|\.(o|exe|dll|bak|sw[po])$|(^|[/\\])\.(hg|git|bzr)($|[/\\])')
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_dir_prompt'     , '>Dir[]>')
  call l9#defineVariableDefault('g:fuf_dir_switchOrder', 30)
  call l9#defineVariableDefault('g:fuf_dir_exclude'    , '\v(^|[/\\])\.(hg|git|bzr)($|[/\\])')
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_mrufile_prompt'     , '>Mru-File[]>')
  call l9#defineVariableDefault('g:fuf_mrufile_switchOrder', 40)
  call l9#defineVariableDefault('g:fuf_mrufile_exclude'    , '\v\~$|\.(bak|sw[po])$|^(\/\/|\\\\|\/mnt\/|\/media\/)')
  call l9#defineVariableDefault('g:fuf_mrufile_maxItem'    , 200)
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_mrucmd_prompt'     , '>Mru-Cmd[]>')
  call l9#defineVariableDefault('g:fuf_mrucmd_switchOrder', 50)
  call l9#defineVariableDefault('g:fuf_mrucmd_exclude'    , '^$')
  call l9#defineVariableDefault('g:fuf_mrucmd_maxItem'    , 200)
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_bookmark_prompt'     , '>Bookmark[]>')
  call l9#defineVariableDefault('g:fuf_bookmark_switchOrder', 60)
  call l9#defineVariableDefault('g:fuf_bookmark_searchRange', 400)
  call l9#defineVariableDefault('g:fuf_bookmark_keyDelete'  , '<C-]>')
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_tag_prompt'     , '>Tag[]>')
  call l9#defineVariableDefault('g:fuf_tag_switchOrder', 70)
  call l9#defineVariableDefault('g:fuf_tag_cache_dir'  , '~/.vim-fuf-cache/tag')
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_taggedfile_prompt'     , '>Tagged-File[]>')
  call l9#defineVariableDefault('g:fuf_taggedfile_switchOrder', 80)
  call l9#defineVariableDefault('g:fuf_taggedfile_cache_dir'  , '~/.vim-fuf-cache/taggedfile')
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_jumplist_prompt'     , '>Jump-List[]>')
  call l9#defineVariableDefault('g:fuf_jumplist_switchOrder', 90)
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_changelist_prompt'     , '>Change-List[]>')
  call l9#defineVariableDefault('g:fuf_changelist_switchOrder', 100)
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_quickfix_prompt'     , '>Quickfix[]>')
  call l9#defineVariableDefault('g:fuf_quickfix_switchOrder', 110)
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_line_prompt'     , '>Line[]>')
  call l9#defineVariableDefault('g:fuf_line_switchOrder', 120)
  "---------------------------------------------------------------------------
  call l9#defineVariableDefault('g:fuf_help_prompt'     , '>Help[]>')
  call l9#defineVariableDefault('g:fuf_help_switchOrder', 130)
  call l9#defineVariableDefault('g:fuf_help_cache_dir'  , '~/.vim-fuf-cache/help')
  "---------------------------------------------------------------------------
  call filter(g:fuf_modes, 'count(g:fuf_modesDisable, v:val) == 0')
  for m in g:fuf_modes
    call fuf#{m}#renewCache()
    call fuf#{m}#onInit()
  endfor
  "---------------------------------------------------------------------------
  command! -bang -narg=0 FufEditInfo   call fuf#editInfoFile()
  command! -bang -narg=0 FufRenewCache call s:renewCachesOfAllModes()
  "---------------------------------------------------------------------------
  for m in g:fuf_modes
    if fuf#{m}#requiresOnCommandPre()
      " cnoremap has a problem, which doesn't expand cabbrev.
      cmap <silent> <expr> <CR> <SID>onCommandPre()
      break
    endif
  endfor
  "---------------------------------------------------------------------------
endfunction

"
function s:initMisc()
endfunction

"
function s:renewCachesOfAllModes()
  for m in g:fuf_modes 
    call fuf#{m}#renewCache()
  endfor
endfunction

"
function s:onBufEnter()
  for m in g:fuf_modes 
    call fuf#{m}#onBufEnter()
  endfor
endfunction

"
function s:onBufWritePost()
  for m in g:fuf_modes
    call fuf#{m}#onBufWritePost()
  endfor
endfunction

"
function s:onCommandPre()
  for m in filter(copy(g:fuf_modes), 'fuf#{v:val}#requiresOnCommandPre()')
      call fuf#{m}#onCommandPre(getcmdtype() . getcmdline())
  endfor
  " lets last entry become the newest in the history
  call histadd(getcmdtype(), getcmdline())
  " this is not mapped again (:help recursive_mapping)
  return "\<CR>"
endfunction

" }}}1
"=============================================================================
" INITIALIZATION {{{1

call s:initialize()

" }}}1
"=============================================================================
" vim: set fdm=marker:
