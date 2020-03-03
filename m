Content-Type: multipart/mixed; boundary="===============5668466331652302247=="
MIME-Version: 1.0
From: Prestwood, James <james.prestwood@intel.com>
Subject: Re: MAC changing really needed
Date: Tue, 03 Mar 2020 16:38:49 +0000
Message-ID: <4c892d95bdf36bfeee97b3a47bf83187dfc1c141.camel@intel.com>
In-Reply-To: <20200303111156.2640.7918@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5668466331652302247==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 2020-03-03 at 11:11 +0000, pavel(a)noa-labs.com wrote:
> Hello,
> =

> I want to have MAC changing functionality. It's really useful. My
> coworking uses "MAC security" for example, and I can't do anything
> about it, and I think thousands of other people will have the same
> situation.

IWD does support randomized MAC addresses using the following config
option:

AddressRandomization=3Donce

This will randomize the MAC address when IWD starts up. This is only
when IWD starts though, and not per network/SSID.

Thanks,
James

> =

> Regus is a no joke coworking network... 3000+ locations after all.
> Please implement MAC changing from the config file.
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============5668466331652302247==--

