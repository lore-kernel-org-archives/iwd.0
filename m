Content-Type: multipart/mixed; boundary="===============8152652954228858550=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] doc: move EnableIPv6 under Network
Date: Wed, 30 Dec 2020 12:29:25 -0600
Message-ID: <bf3d6182-2e56-786a-fbea-1dde4ec4d1e7@gmail.com>
In-Reply-To: <CAG17S_MDtKWxmWaN0SO7ELS8X7ammR4M6kcDqUbinrzvBBvW+A@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8152652954228858550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

> This is interesting to me. I am using connman and iwd (1.10) and have ipv=
6 =


If you're using connman, then this discussion isn't really relevant for you=
. =

You should let connman manage IPv4/IPv6 details.

> enabled on my home network. On my RPi, the ipv6 addresses are listed:
> The /etc/iwd/main.conf lists only:
> [General]
> UseDefaultInterface=3Dtrue
> NameResolvingService=3Dresolvconf

In fact, this setting is useless without EnableNetworkConfiguration=3DTrue.=
  And =

you should NOT set it if you're using connman.  EnableNetworkConfiguration =
and =

NameResolvingService are only needed if you're running iwd standalone or do=
 not =

want to use an external network manager, like NM/connman/networkd, for mana=
ging =

wifi connections.

> =

> There is nothing referencing ipv6 in connman's main.conf nor in the psk f=
or the =

> AP I am using.=C2=A0 Yet, I get these addresses when iwd negotiates the c=
onnection:
> =

> wlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST> =C2=A0mtu 1500
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet 192.168.2.41 =C2=A0netmask 255.255.255.=
0 =C2=A0broadcast 192.168.2.255
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 fd21:98c8:1d28:0:ba27:xxff:fexx:xxxx=
=C2=A0 prefixlen 64 =C2=A0scopeid =

> 0x0<global>
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 fd21:98c8:1d28::41 =C2=A0prefixlen 64 =
=C2=A0scopeid 0x0<global>
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 2600:1700:4320:6caf:ba27:xxff:fexx:xxx=
x=C2=A0 prefixlen 64 =C2=A0scopeid =

> 0x0<global>
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 fe80::ba27:xxff:fexx:xxxx=C2=A0 prefix=
len 64 =C2=A0scopeid 0x20<link>
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 ether b8:27:xx:xx:xx:xx=C2=A0 txqueuelen 100=
0 =C2=A0(Ethernet)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 RX packets 11056898 =C2=A0bytes 8907204479 (=
8.2 GiB)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 RX errors 0 =C2=A0dropped 0 =C2=A0overruns 0=
 =C2=A0frame 0
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 TX packets 3810279 =C2=A0bytes 415445265 (39=
6.1 MiB)
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 TX errors 0 =C2=A0dropped 0 overruns 0 =C2=
=A0carrier 0 =C2=A0collisions 0
> =

> How should I disable it? Should I?

That is a question for the connman mailing list.  iwd isn't doing any netwo=
rk =

configuration in your case.

Regards,
-Denis
--===============8152652954228858550==--

