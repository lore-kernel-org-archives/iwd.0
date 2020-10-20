Content-Type: multipart/mixed; boundary="===============4497307171441078225=="
MIME-Version: 1.0
From: m1027@posteo.net
Subject: >=iwd-1.8: crash in dmesg at boot
Date: Tue, 20 Oct 2020 18:14:22 +0200
Message-ID: <20201020161422.GD1676@host>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4497307171441078225==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I am forwarding the following issue from Gentoo linux to you here.
Please see: https://bugs.gentoo.org/746539

I hope this is the right place to continue with this issue.

This is the summary:

iwd-1.7 was not hit, but 1.8 and 1.9 have been hit by the issue.

The kernel has been bisected down to this commit:
https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=3Db43e91=
5b989dcbb0fa763fb7f256e30fe7426f14
However, it may not be the real cause, maybe only revealing the
issue. Still happening with linux 5.9.1.

In the testbed iwd gets started via systemd (at least here). Note:
Starting the service *after* the boot process manually does *not*
crash. So, currently everything works, as the service gets restarted
after the initial crash.

Last but not least, the output of dmesg:

[   16.086329] ------------[ cut here ]------------
[   16.086333] WARNING: CPU: 0 PID: 370 at net/wireless/nl80211.c:7284 nl80=
211_get_reg_do+0x1fc/0x230
[   16.086334] CPU: 0 PID: 370 Comm: iwd Not tainted 5.8.13 #15
[   16.086335] Hardware name: LENOVO 20KFCTO1WW/20KFCTO1WW, BIOS N20ET55W (=
1.40 ) 06/01/2020
[   16.086336] RIP: 0010:nl80211_get_reg_do+0x1fc/0x230
[   16.086338] Code: 00 00 00 48 89 ef e8 13 ff 85 ff 85 c0 0f 84 01 ff ff =
ff eb a6 48 89 ef 48 89 04 24 e8 4d ff e0 ff 48 8b 04 24 e9 43 ff ff ff <0f=
> 0b 48 89 ef e8 3a ff e0 ff b8 ea ff ff ff e9 2f ff ff ff e9 78
[   16.086338] RSP: 0018:ffff9ab9c041bb98 EFLAGS: 00010202
[   16.086339] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000=
00000
[   16.086340] RDX: ffff95472b7b0008 RSI: 0000000000000000 RDI: ffff95472b7=
b02e0
[   16.086340] RBP: ffff9547264c1d00 R08: 0000000000000004 R09: ffff9547285=
85014
[   16.086340] R10: ffff954728581000 R11: 0000000000000001 R12: ffff9ab9c04=
1bbf0
[   16.086341] R13: 0000000000000000 R14: ffff954728585014 R15: ffff95472b7=
b02e0
[   16.086341] FS:  00007f346c24e740(0000) GS:ffff95472e400000(0000) knlGS:=
0000000000000000
[   16.086342] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   16.086342] CR2: 000055f2e8fc3010 CR3: 00000004222c2002 CR4: 00000000003=
606f0
[   16.086343] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   16.086343] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   16.086344] Call Trace:
[   16.086346]  genl_rcv_msg+0x1ae/0x2f0
[   16.086348]  ? genl_family_rcv_msg_attrs_parse.isra.0+0xd0/0xd0
[   16.086349]  netlink_rcv_skb+0x46/0x110
[   16.086350]  genl_rcv+0x1f/0x30
[   16.086351]  netlink_unicast+0x197/0x230
[   16.086352]  netlink_sendmsg+0x1ed/0x400
[   16.086353]  __sys_sendto+0x1d3/0x1f0
[   16.086355]  __x64_sys_sendto+0x21/0x30
[   16.086356]  do_syscall_64+0x4d/0x1d0
[   16.086358]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   16.086360] RIP: 0033:0x7f346c3d862c
[   16.086361] Code: 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 41 89 ca 64 =
8b 04 25 18 00 00 00 85 c0 75 21 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 6c e9 91 0c 04 00 0f 1f 80 00 00 00 00 55 48
[   16.086361] RSP: 002b:00007fff38eb6978 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002c
[   16.086362] RAX: ffffffffffffffda RBX: 000055f2e8faab00 RCX: 00007f346c3=
d862c
[   16.086362] RDX: 000000000000001c RSI: 000055f2e8fc2ac0 RDI: 00000000000=
00004
[   16.086363] RBP: 000055f2e8fc1910 R08: 0000000000000000 R09: 00000000000=
00000
[   16.086363] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff38e=
b6a08
[   16.086364] R13: 000055f2e8fb4910 R14: 000055f2e8fb4790 R15: 00000000000=
00000
[   16.086364] ---[ end trace a7bf7b4f3a41fe0a ]---

Thanks!

--===============4497307171441078225==--

