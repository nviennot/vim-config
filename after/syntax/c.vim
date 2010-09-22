syn match ErrorLeadSpace /^ \+/
syn match ErrorTailSpace /\s\+$/
match Error80 /\%>80v.\+/
set textwidth=78

syn keyword cOperator likely unlikely
syn keyword cType BUG BUG_ON

syn keyword cRepeat list_for_each list_for_each_entry list_for_each_entry_continue list_for_each_entry_safe __list_for_each list_for_each_prev list_for_each_safe list_for_each_prev_safe list_for_each_entry_reverse list_for_each_entry_continue_reverse list_for_each_entry_from list_for_each_entry_safe_continue list_for_each_entry_safe_from list_for_each_entry_safe_reverse
syn keyword cRepeat hlist_for_each hlist_for_each_safe hlist_for_each_entry hlist_for_each_entry_continue hlist_for_each_entry_from hlist_for_each_entry_safe

syn keyword cPreCondit mutex_lock mutex_unlock
syn keyword cPreCondit spin_lock spin_unlock spin_lock_irqsave spin_unlock_irqrestore
syn keyword cPreCondit read_lock read_unlock
syn keyword cPreCondit rcu_read_lock rcu_read_unlock

syn keyword cPreCondit kmalloc vmalloc kfree vfree
syn keyword cPreCondit up_write down_write up_read down_read

syn keyword cConstant GFP_ZONEMASK GFP_NOWAIT GFP_ATOMIC GFP_NOIO GFP_NOFS GFP_KERNEL GFP_TEMPORARY GFP_USER GFP_HIGHUSER GFP_HIGHUSER_MOVABLE GFP_IOFS GFP_THISNODE GFP_THISNODE GFP_MOVABLE_MASK GFP_RECLAIM_MASK GFP_BOOT_MASK GFP_CONSTRAINT_MASK GFP_SLAB_BUG_MASK GFP_DMA GFP_DMA32 GFP_ZONE_TABLE GFP_ZONE_BAD

set nofoldenable
set foldmethod=syntax
