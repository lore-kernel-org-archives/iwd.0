Content-Type: multipart/mixed; boundary="===============5437807421046878890=="
MIME-Version: 1.0
From: salahaldeen.altous at leica-camera.com
To: iwd at lists.01.org
Subject: Re: IWD is running as AP with the build-in DHCP but android phones
 report no internet connection and switch back to WiFi home network
Date: Sun, 07 Nov 2021 09:32:47 +0000
Message-ID: <20211107093247.2830.83151@ml01.vlan13.01.org>
In-Reply-To: 2459d9b7-2ba9-8798-21f6-35708f3ec8cc@gmail.com

--===============5437807421046878890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,
thanks again for your quick help.
> Hi Salahaldeen,
> =

> =

> So looking at ell/dhcp-server.c, we shouldn't be sending DNS server info =
unless =

> l_dhcp_server_set_dns has been called.  So this part seems OK.
Thanks for  your confirmation.
> =

> In iwd, src/ap.c...  We do not call l_dhcp_server_set_dns unless the prof=
ile =

> specifies it.  So if IPv4.DNSList isn't set, we should not be sending thi=
s =

> option in the lease.
> =

> Can you look (or share) pcaps of iwd & dnsmasq DHCP exchanges to see / co=
mpare =

> what is actually happening?

The dnsmasq DHCP solution was running at different hardware which is using =
openwrt. =

I will try to run iwd with dnsmasq and dropping DHCP option 3 and 6 and che=
ck if it work.
After that I can compare between both DHCP.
> =

> Regards,
> -Denis

Regards,
Salahaldeen
--===============5437807421046878890==--

