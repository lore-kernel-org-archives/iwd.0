Content-Type: multipart/mixed; boundary="===============6822406912414970754=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459 at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Wed, 11 May 2022 19:41:32 +0100
Message-ID: <CACsRnHVkzS2RSAJese9FOx5W-Rn+EfZRuV4i7VZMrJ=piArNYw@mail.gmail.com>
In-Reply-To: 3060872f-32b5-6faa-92b7-de0e8f3a1800@gmail.com

--===============6822406912414970754==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Right, I was imagining a reduced set of information more user targeted
that is shown by default. Something similar to dhclient:

```
May 08 08:51:16 p3-2019 dhclient[852]: DHCPDISCOVER on wlp2s0 to
255.255.255.255 port 67 interval 3 (xid=3D0x8f5cca6b)
May 08 08:51:19 p3-2019 dhclient[852]: DHCPDISCOVER on wlp2s0 to
255.255.255.255 port 67 interval 5 (xid=3D0x8f5cca6b)
May 08 08:51:24 p3-2019 dhclient[852]: DHCPDISCOVER on wlp2s0 to
255.255.255.255 port 67 interval 13 (xid=3D0x8f5cca6b)
May 08 08:51:25 p3-2019 dhclient[852]: DHCPREQUEST of 10.133.65.248 on
wlp2s0 to 255.255.255.255 port 67 (xid=3D0x6bca5c8f)
May 08 08:51:25 p3-2019 dhclient[852]: DHCPOFFER of 10.133.65.248 from
10.133.64.2
May 08 08:51:25 p3-2019 dhclient[852]: DHCPACK of 10.133.65.248 from 10.133=
.64.2
May 08 08:51:25 p3-2019 dhclient[852]: bound to 10.133.65.248 --
renewal in 3419 seconds.
May 08 09:48:24 p3-2019 dhclient[1222]: DHCPREQUEST of 10.133.65.248
on wlp2s0 to 10.133.64.2 port 67 (xid=3D0x6bca5c8f)
May 08 09:48:24 p3-2019 dhclient[1222]: DHCPACK of 10.133.65.248 from
10.133.64.2
May 08 09:48:24 p3-2019 dhclient[1222]: bound to 10.133.65.248 --
renewal in 3400 seconds.
May 08 10:45:04 p3-2019 dhclient[1222]: DHCPREQUEST of 10.133.65.248
on wlp2s0 to 10.133.64.2 port 67 (xid=3D0x6bca5c8f)
May 08 10:45:04 p3-2019 dhclient[1222]: DHCPACK of 10.133.65.248 from
10.133.64.2
May 08 10:45:04 p3-2019 dhclient[1222]: bound to 10.133.65.248 --
renewal in 3159 seconds.
```

I would be happy to contribute something like this if you were open to it.

Regards,
Michael

On Wed, 11 May 2022 at 19:21, Denis Kenzior <denkenz(a)gmail.com> wrote:
>
> Hi Michael,
>
> > One thing I was wondering is if some level of info logging would be
> > possible for the dhcp client. This could be similar in verbosity to
> > dhclient or networkd which would make it easier to see what happened
> > with this kind of thing. DHCP happens on a relatively slow basis so it
> > wouldn't spam much. I attempted to add this but I couldn't really find
> > a good place for it.
>
> You can start iwd with IWD_DHCP_DEBUG set but not '-d'.  So it would only=
 print
> the DHCP info and not anything else.
>
> Or do you mean a reduced set of information prints from the dhcp_client? =
 Should
> be possible by introducing something like l_dhcp_client_set_debug_level().
>
> Or do you mean something else?
>
> Regards,
> -Denis
--===============6822406912414970754==--

