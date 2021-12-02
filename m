Content-Type: multipart/mixed; boundary="===============6278822919923917887=="
MIME-Version: 1.0
From: Daniel Wagner <wagi at monom.org>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Thu, 02 Dec 2021 16:47:13 +0100
Message-ID: <8aa819a1-4fd4-b989-713b-6480d0dfd236@monom.org>
In-Reply-To: 31be7914-5c78-f1c9-1225-a271204ba153@gmail.com

--===============6278822919923917887==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 30.11.21 23:42, Denis Kenzior wrote:
> Note that for iwd + connman, connman would be the one performing DHCP =

> and iwd should use EnableNetworkConfiguration=3Dfalse.=C2=A0 Daniel can c=
orrect =

> me if I'm wrong.

This is correct. Though I think it should be possible to change this. =

For example for VPN the VPN service tells ConnMan the IP configuration =

to use. The iwd plugin could do the amse and tell the ConnMan core which =

IP configuration to use.
--===============6278822919923917887==--

