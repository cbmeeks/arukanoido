c_setzw=1
c_setsd=2
c_clrmb=3
c_clrmw=4
c_setmb=5
c_setmw=6
c_apply=7
syscall_vectors_l: <setzw <setsd <clrmb <clrmw <setmb <setmw <apply
syscall_vectors_h: >setzw >setsd >clrmb >clrmw >setmb >setmw >apply
syscall_args_l: <args_setzw <args_setsd <args_clrmb <args_clrmw <args_setmb <args_setmw <args_apply
syscall_args_h: >args_setzw >args_setsd >args_clrmb >args_clrmw >args_setmb >args_setmw >args_apply
args_setzw: 3 a0 a1 a2
args_setsd: 4 a0 a1 a2 a3
args_clrmb: 3 a0 a1 a2
args_clrmw: 4 a0 a1 a2 a3
args_setmb: 4 a0 a1 a2 a3
args_setmw: 5 a0 a1 a2 a3 a4
args_apply: 0
