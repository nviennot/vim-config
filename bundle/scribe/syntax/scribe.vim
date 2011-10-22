if exists("b:current_syntax")
    finish
endif
syn case match

syn match pid "^\[[0-9]\+\]"
syn match syscall "\w.\+()"
syn match rdtsc "rdtsc"
syn match signal "signal"
syn match fence "--fence(.*)--"
syn match resource "resource lock.*"
syn match str "\".\+\"" contained
syn match data "data: .\+" contains=string
syn match regs "regs: .\+"
syn match queue_oef "queue EOF"

hi link pid Identifier
hi link syscall Keyword
hi link rdtsc Keyword
hi link signal Keyword
hi link fence Comment
hi link resource Type
hi link data String
hi link str Function
hi link regs Comment
hi link queue_oef Identifier

let b:current_syntax = "scribe"
