Content-Type: multipart/mixed; boundary="===============4046411495775299547=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/2] test-runner: increase RAM size to 1GB
Date: Mon, 21 Mar 2022 16:25:15 -0700
Message-ID: <20220321232515.931923-2-prestwoj@gmail.com>
In-Reply-To: 20220321232515.931923-1-prestwoj@gmail.com

--===============4046411495775299547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As a temporary solution to kernel/python OOM exceptions increase the
RAM size to 1GB.

For quite a while test-runner has run into frequent OOM exceptions when
running many tests in a row. Its not completely known exactly why, but
seems to point to the 9p driver which is used for sharing the root fs
between the test-runner VM and the host.

With debugging enabled (-d) one can see the available memory available
relatively stable. If a test fails it may spike ~3-4kb but this quickly
recovers as python garbage collects.

At some point the kernel faults failing to allocate which (usually) is
shown by a python OOM exception. At this point there is plenty of
available memory.

Dumping the kernel trace its seen that the 9p driver is involved:

[  248.962949] test-runner: page allocation failure: order:7, mode:0x40dc0(=
GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=3D(null),cpuset=3D/,mems_allowe=
d=3D0
[  248.962958] CPU: 2 PID: 477 Comm: test-runner Not tainted 5.16.0 #91
[  248.962960] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.1=
4.0-4.fc34 04/01/2014
[  248.962961] Call Trace:
[  248.962964]  <TASK>
[  248.962965]  dump_stack_lvl+0x34/0x44
[  248.962971]  warn_alloc.cold+0x78/0xdc
[  248.962975]  ? __alloc_pages_direct_compact+0x14c/0x1e0
[  248.962979]  __alloc_pages_slowpath.constprop.0+0xbfe/0xc60
[  248.962982]  __alloc_pages+0x2d5/0x2f0
[  248.962984]  kmalloc_order+0x23/0x80
[  248.962988]  kmalloc_order_trace+0x14/0x80
[  248.962990]  v9fs_alloc_rdir_buf.isra.0+0x1f/0x30
[  248.962994]  v9fs_dir_readdir+0x51/0x1d0
[  248.962996]  ? __handle_mm_fault+0x6e0/0xb40
[  248.962999]  ? inode_security+0x1d/0x50
[  248.963009]  ? selinux_file_permission+0xff/0x140
[  248.963011]  iterate_dir+0x16f/0x1c0
[  248.963014]  __x64_sys_getdents64+0x7b/0x120
[  248.963016]  ? compat_fillonedir+0x150/0x150
[  248.963019]  do_syscall_64+0x3b/0x90
[  248.963021]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  248.963024] RIP: 0033:0x7fedd7c6d8c7
[  248.963026] Code: 00 00 0f 05 eb b7 66 2e 0f 1f 84 00 00 00 00 00 0f 1f =
00 f3 0f 1e fa b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 01 c3 48 8b 15 81 a5 0f 00 f7 d8 64 89 02 48
[  248.963028] RSP: 002b:00007ffd06cd87e8 EFLAGS: 00000293 ORIG_RAX: 000000=
00000000d9
[  248.963031] RAX: ffffffffffffffda RBX: 000056090d87dd20 RCX: 00007fedd7c=
6d8c7
[  248.963032] RDX: 0000000000080000 RSI: 000056090d87dd50 RDI: 00000000000=
0000f
[  248.963033] RBP: 000056090d87dd50 R08: 0000000000000030 R09: 00007fedc7d=
37af0
[  248.963035] R10: 00007fedc7d7d730 R11: 0000000000000293 R12: fffffffffff=
fff88
[  248.963038] R13: 000056090d87dd24 R14: 0000000000000000 R15: 000056090d0=
485e8

Here its seen an allocation of 512k is being requested (order:7), but fault=
s.
In this run it there was ~35MB of available memory on the system.

Available Memory: 35268 kB
Last Test Delta: -2624 kB
Per-test Usage:
[  0] **        			37016
[  1] ********* 			41584
[  2] *         			36280
[  3] ********* 			41452
[  4] ********  			40940
[  5] ******    			39284
[  6] ****      			38348
[  7] ***       			37496
[  8] ****      			37892
[  9]           			35268

This can be reproduced by running all autotests (changing the ram down to
~128MB helps trigger it faster):

./tools/test-runner -k <kernel> -d
---
 tools/test-runner | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index cd110411..eaa107ff 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -1887,12 +1887,15 @@ class Main:
 			smp =3D int(nproc / 2)
 =

 		#
-		# Increase RAM if valgrind is being used
+		# TODO: Its unclear exactly what causes it (leak, fragmentation,
+		# or ?), but after many test runs the kernel starts running out
+		# of memory. This is sometimes non-fatal, e.g. a python call
+		# fails, but other times the kernel fully panics.
 		#
-		if self.args.valgrind:
-			ram =3D 512
-		else:
-			ram =3D 384
+		# For now increase the RAM which allows full test runs to
+		# complete.
+		#
+		ram =3D 1024
 =

 		print("Using %d cores, %d RAM for VM" % (smp, ram))
 =

-- =

2.34.1

--===============4046411495775299547==--

