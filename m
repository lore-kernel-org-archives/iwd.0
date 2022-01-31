Content-Type: multipart/mixed; boundary="===============9217883426210999828=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Mon, 31 Jan 2022 09:28:37 -0800
Message-ID: <5d57b20ed52e4d70d64ae3cba74adbd760b5891e.camel@gmail.com>
In-Reply-To: 20220129200358.2828.46152@ml01.vlan13.01.org

--===============9217883426210999828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 2022-01-29 at 20:03 +0000,
54d22547-afc0-4701-b1fc-5a2a2e411646(a)simplelogin.co wrote:
> Sorry, didn't know that. I reproduced the problem again and uploaded
> the file here: https://transfer.sh/get/jiEvOg/dhcp.pcap
> =

> Hope this helps!

Thanks for getting this. For some reason your DHCP server is sending
two offers, and IWD is ignoring the second:

- DHCP offers 192.168.1.33
- IWD responds with a request for .33
- 2 seconds go by and DHCP offers 192.168.1.35
- IWD ignores offer as its already waiting for a reply from its
original request
- IWD continues to retransmit requests for .35 but the server ignores
them.

It seems the server wants .35 as this is what works later when (I
assume) you restarted IWD.

A quick fix could be that we automatically restart DHCP after some
timeout (same effect as you restarting IWD). The proper fix would be to
handle this multiple offer case.

Out of curiosity what kind of network hardware are you using? Are you
just using an off the shelf router or some custom openwrt/hostapd
setup?

Thanks,
James


> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============9217883426210999828==--

