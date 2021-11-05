Content-Type: multipart/mixed; boundary="===============7375960914043668125=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: IWD is running as AP with the build-in DHCP but android phones
 report no internet connection and switch back to WiFi home network
Date: Fri, 05 Nov 2021 13:17:53 -0500
Message-ID: <2459d9b7-2ba9-8798-21f6-35708f3ec8cc@gmail.com>
In-Reply-To: 20211105174731.2830.19174@ml01.vlan13.01.org

--===============7375960914043668125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Salahaldeen,

> I have tested the attached patch but still not working. I have checked ag=
ain. We have dropped DHCP option 6 to report Domain Name servers
> +dhcp-option=3Doption:dns-server
> +dhcp-option=3Doption:router
> =

> How I can also drop dhcp option 6 to report Domain Name servers?

So looking at ell/dhcp-server.c, we shouldn't be sending DNS server info un=
less =

l_dhcp_server_set_dns has been called.  So this part seems OK.

In iwd, src/ap.c...  We do not call l_dhcp_server_set_dns unless the profil=
e =

specifies it.  So if IPv4.DNSList isn't set, we should not be sending this =

option in the lease.

Can you look (or share) pcaps of iwd & dnsmasq DHCP exchanges to see / comp=
are =

what is actually happening?

Regards,
-Denis
--===============7375960914043668125==--

