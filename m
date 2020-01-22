Content-Type: multipart/mixed; boundary="===============5386672253905129276=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] monitor: Add message length check to nlmon_receice
Date: Wed, 22 Jan 2020 19:41:00 +0100
Message-ID: <20200122184100.fehnsonqagforfx7@beryllium.lan>
In-Reply-To: <448ecb92-848c-a2b2-8aad-ebe4a1b1772e@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5386672253905129276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2020 at 11:53:47AM -0600, Denis Kenzior wrote:
> I still think the last message isn't *actually* aligned, but without crash
> data I can't prove it :)  It may be that most messages are indeed aligned,
> but the ones you're seeing this on are somehow special. Otherwise I don't
> see how we haven't detected this crash for so long.

Let me help out with that :)

(gdb) bt full
#0  0x000000000041ba55 in nlmon_receive (io=3D0x4da210, user_data=3D0x4d4cc=
0) at monitor/nlmon.c:6930
        nlmon =3D 0x4d4cc0
        nlmsg =3D 0x800000ffd2f4
        msg =3D {msg_name =3D 0x7fffffffe920, msg_namelen =3D 20, msg_iov =
=3D 0x7fffffffe910, msg_iovlen =3D 1, =

          msg_control =3D 0x7fffffffc8c0, msg_controllen =3D 32, msg_flags =
=3D 0}
        sll =3D {sll_family =3D 17, sll_protocol =3D 0, sll_ifindex =3D 6, =
sll_hatype =3D 824, sll_pkttype =3D 4 '\004', =

          sll_halen =3D 0 '\000', sll_addr =3D "\000\000\000\000\000\000\00=
0"}
        iov =3D {iov_base =3D 0x7fffffffc8e0, iov_len =3D 8192}
        cmsg =3D 0x0
        copy_tv =3D {tv_sec =3D 1579718221, tv_usec =3D 657974}
        copy_tp =3D {tp_status =3D 0, tp_len =3D 0, tp_snaplen =3D 0, tp_ma=
c =3D 0, tp_net =3D 0, tp_vlan_tci =3D 0, =

          tp_vlan_tpid =3D 0}
        tv =3D 0x7fffffffe900
        tp =3D 0x0
        proto_type =3D 0
        buf =3D "\021\000\000\000\026\000\001\003\000\000\000\000wU\000\000=
\000\200\200\000\376\t\000\001\000\000\000\000\b\000\017\000\376\000\000\00=
0\024\000\001\000*\002&\360\000@\000\000\000\000\000\000\027\333[\033\024\0=
00\002", '\000' <repeats 17 times>, "\024\000\a\000\376\200\000\000\000\000=
\000\000\342\325^\377\376\343\036\024\f\000\b\000\b\000\n\000@\000\000\000\=
b\000\006\000\000\004\000\000\024\000\005\000\376\200\000\000\000\000\000\0=
00\362\237\302\377\376=C2=AC\337\b\000\004\000\002\000\000\000$\000\f\000\0=
02\000\000\000\000\316\065", '\000' <repeats 25 times>, "\005\000\024\000\0=
01\000\000\000\024\000\006\000\377\377\377\377\377\377\377\377\375"...
        control =3D " \000\000\000\000\000\000\000\001\000\000\000\035\000\=
000\000M\226(^\000\000\000\000\066\n\n\000\000\000\000"
        bytes_read =3D 17
        nlmsg_len =3D 18446744073692771837
        fd =3D 7
(gdb) p iov.iov_base
$1 =3D (void *) 0x7fffffffc8e0
(gdb) p *(struct nlmsghdr *)iov.iov_base
$2 =3D {nlmsg_len =3D 17, nlmsg_type =3D 22, nlmsg_flags =3D 769, nlmsg_seq=
 =3D 0, nlmsg_pid =3D 21879}

> > Do you want me to send a new patch or are you going to fix it
> > yourself? I don't mind :)
> =

> I went ahead and pushed 8b489d5df283 ("monitor: Fix crash") with your name
> on the Reported-By.

Thanks!
Daniel
--===============5386672253905129276==--

