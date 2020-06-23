Content-Type: multipart/mixed; boundary="===============5086374336419267603=="
MIME-Version: 1.0
From: caljorden@hotmail.com
Subject: iwd 1.8 causes kernel oops
Date: Tue, 23 Jun 2020 11:09:41 +0000
Message-ID: <20200623110941.2644.7970@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5086374336419267603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I have observed on my two main machines that I am getting a kernel oops whe=
n I boot that only occurs when I am running IWD 1.8.  When I downgrade to I=
WD 1.7, the oops goes away.  I have observed this on kernels 5.7.4 and 5.7.=
5 (at least).  The kernel oops does not seem to negatively impact the opera=
tion of the system, and wireless works fine after this as well.

Here are the oops details:

[    2.951230] ------------[ cut here ]------------
[    2.951235] WARNING: CPU: 13 PID: 3703 at net/wireless/nl80211.c:7259 nl=
80211_get_reg_do+0x1f1/0x220
[    2.951235] Modules linked in: algif_aead algif_skcipher md4 algif_hash =
af_alg amd64_edac_mod(-) pcc_cpufreq(-) iwlmvm btusb btrtl btbcm btintel bl=
uetooth ecdh_generic iwlwifi ecc snd_hda_codec_realtek snd_hda_codec_generi=
c snd_hda_codec_hdmi crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_in=
tel crypto_simd cryptd snd_hda_intel glue_helper snd_intel_dspcfg snd_hda_c=
odec k10temp snd_hwdep snd_hda_core
[    2.951245] CPU: 13 PID: 3703 Comm: iwd Tainted: G                T 5.7.=
5 #2
[    2.951246] Hardware name: Micro-Star International Co., Ltd. MS-7B93/MP=
G X570 GAMING PRO CARBON WIFI (MS-7B93), BIOS 1.50 11/06/2019
[    2.951248] RIP: 0010:nl80211_get_reg_do+0x1f1/0x220
[    2.951249] Code: 24 0c 01 00 00 00 e8 7e 13 7b ff 85 c0 0f 84 01 ff ff =
ff eb a6 48 89 ef 48 89 04 24 e8 48 5b e4 ff 48 8b 04 24 e9 43 ff ff ff <0f=
> 0b 48 89 ef e8 35 5b e4 ff b8 ea ff ff ff e9 2f ff ff ff e9 78
[    2.951250] RSP: 0018:ffffaff480b9fc10 EFLAGS: 00010202
[    2.951251] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00000000000=
00000
[    2.951252] RDX: ffff8bcf874c0008 RSI: 0000000000000000 RDI: ffff8bcf874=
c0300
[    2.951252] RBP: ffff8bcf8d5d7700 R08: 0000000000000004 R09: ffff8bcf911=
cb014
[    2.951253] R10: 0000000000000017 R11: ffffffff8874a580 R12: ffffaff480b=
9fc68
[    2.951254] R13: 0000000000000000 R14: ffff8bcf911cb014 R15: ffff8bcf874=
c0300
[    2.951255] FS:  00007f715bc30740(0000) GS:ffff8bcf9eb40000(0000) knlGS:=
0000000000000000
[    2.951256] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.951256] CR2: 00007f715bbcca55 CR3: 0000000fd16b8000 CR4: 00000000003=
40ee0
[    2.951257] Call Trace:
[    2.951261]  ? _cond_resched+0x15/0x30
[    2.951264]  genl_rcv_msg+0x1bd/0x320
[    2.951266]  ? genl_family_rcv_msg_attrs_parse+0xf0/0xf0
[    2.951268]  netlink_rcv_skb+0x49/0x110
[    2.951269]  genl_rcv+0x24/0x40
[    2.951271]  netlink_unicast+0x191/0x230
[    2.951272]  netlink_sendmsg+0x21e/0x430
[    2.951275]  __sys_sendto+0x1a4/0x1c0
[    2.951278]  __x64_sys_sendto+0x25/0x30
[    2.951280]  do_syscall_64+0x48/0x130
[    2.951282]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.951283] RIP: 0033:0x7f715bd31c7c
[    2.951284] Code: c0 ff ff ff ff eb bc 0f 1f 80 00 00 00 00 41 89 ca 64 =
8b 04 25 18 00 00 00 85 c0 75 21 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 6c c3 66 66 2e 0f 1f 84 00 00 00 00 00 55 48
[    2.951285] RSP: 002b:00007ffe48183bd8 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002c
[    2.951286] RAX: ffffffffffffffda RBX: 000055bff8539870 RCX: 00007f715bd=
31c7c
[    2.951286] RDX: 000000000000001c RSI: 000055bff854da30 RDI: 00000000000=
00004
[    2.951287] RBP: 000055bff8544bc0 R08: 0000000000000000 R09: 00000000000=
00000
[    2.951287] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe481=
83c30
[    2.951288] R13: 00007ffe48183c2c R14: 000055bff8543500 R15: 00000000000=
00000
[    2.951289] ---[ end trace 4fa37a5b4f72d39c ]---

Note that I am using Intel wireless cards in both of my systems.  This syst=
em has the AX200 Intel card, and my other system has an older low-end singl=
e-stream 433Mbps 802.11ac chipset (I think the Intel 3165).  This system is=
 Gentoo, Ryzen 9 3900x, AMD x570 chipset.  The other system is Arch Linux, =
Ryzen 7 2700x, AMD B350 chipset.  Both recently updated to IWD 1.8, which i=
s when I started seeing this.

I have tried to run the current git master branch (currently f7c036a8018213=
d3b8ce3fe36fdceeb633c00c54), but I can't get iwd to start on that commit (i=
t just exits with a non-zero return.  I tried to strace it, and it seems to=
 be having some issue with accessing the kernel keystore, maybe?)

I wanted to report this here so that it would be noticed, and possibly fixe=
d in a future release.  I am happy to test patches.
--===============5086374336419267603==--

