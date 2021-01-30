Content-Type: multipart/mixed; boundary="===============7425652704046885444=="
MIME-Version: 1.0
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: broadcom fmac ap mode testing - how to set iwd as dhcp server?
Date: Sat, 30 Jan 2021 12:47:23 +0100
Message-ID: <00ac4f92-db56-32ee-66db-27697823ef5d@molgen.mpg.de>
In-Reply-To: <c8c2dfe5bed4a02bade21f0a12cf71f0da2c97ca.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7425652704046885444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Dear James, Dear Keith,


Am 29.01.21 um 02:37 schrieb James Prestwood:

> <snip>
>> When I restart the AP from iwctl, I can connect again.
>> What I do not yet know how to do, though, is assign an ip address to
>> the ap and then have it be a dhcp server to serve out a dhcp address
>> to the connecting computer. I found this online and took a stab, but
>> it did not assign an address, though the computer did 'attach'.
> =

> Yes this is exactly the behavior we are seeing as well. I do have a
> patch which fixes the disconnect issue and allows the same client to
> connect again but we've actually got more problems than this. My recent
> patches 'fixing' AP mode is somewhat of a hack in all honesty. It
> allows the 4-way handshake to happen but not the GTK handshake. This
> means no group traffic which breaks DHCP.
> =

> I won't bore you with details but it boils down to brcmfmac being (as
> far as we can tell) broken when used this way.

Are the Linux kernel subsystem maintainers (BROADCOM BRCM80211 =

IEEE802.11n WIRELESS DRIVER) aware of this issue?

> We are going to investigate handshake offloading which might fix it,
> but we just don't know yet. I am expecting offloading to work  but if
> not we need to talk with linux-wireless/broadcom about why its broken
> or how it supposed to work. Anyways, we hope to have this sorted
> soon.
[=E2=80=A6]


Kind regards,

Paul
--===============7425652704046885444==--

