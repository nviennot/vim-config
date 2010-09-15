syn match ErrorLeadSpace /^ \+/
syn match ErrorTailSpace /\s\+$/
match Error80 /\%>80v.\+/
set textwidth=78

syn keyword cOperator likely unlikely
syn keyword cType BUG BUG_ON

syn keyword cRepeat list_for_each list_for_each_entry list_for_each_entry_continue list_for_each_entry_safe

syn keyword cPreCondit mutex_lock mutex_unlock
syn keyword cPreCondit spin_lock spin_unlock spin_lock_irqsave spin_unlock_irqrestore
syn keyword cPreCondit kmalloc vmalloc
syn keyword cPreCondit up_write down_write up_read down_read

syn keyword cConstant GFP_ZONEMASK GFP_NOWAIT GFP_ATOMIC GFP_NOIO GFP_NOFS GFP_KERNEL GFP_TEMPORARY GFP_USER GFP_HIGHUSER GFP_HIGHUSER_MOVABLE GFP_IOFS GFP_THISNODE GFP_THISNODE GFP_MOVABLE_MASK GFP_RECLAIM_MASK GFP_BOOT_MASK GFP_CONSTRAINT_MASK GFP_SLAB_BUG_MASK GFP_DMA GFP_DMA32 GFP_ZONE_TABLE GFP_ZONE_BAD

set nofoldenable
set foldmethod=syntax
