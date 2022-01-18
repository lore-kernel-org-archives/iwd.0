Content-Type: multipart/mixed; boundary="===============3875114976751905577=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [Feature discussion] Allow overriding of network-specific options
 globally
Date: Tue, 18 Jan 2022 09:07:14 -0600
Message-ID: <d123e190-b560-51ae-b1fc-8f72dfce77ac@gmail.com>
In-Reply-To: CAGTBY+ucQ_kWfzxrZaaeL233-Xp28Cq9Kyor_Y+NeCNbGqDqcA@mail.gmail.com

--===============3875114976751905577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rhys,

> Right- My programming skills aren't the best, but I'll give it a go
> :). Where do you think the DNS option should go in the main config
> file? Something like `DNSv4` and `DNSv6` in the `Network` section, or
> should the `IPv4` and `IPv6` sections be added, each with their own
> respective `DNS` entries?

I would just mirror the way the network profiles do this.  So exact same =

structure as in src/iwd.network.rst.

> =

> Also, apologies to Denis for accidentally doing a reply instead of a
> reply-all initially, I don't participate in mailing lists that often.
> =


No worries.

Regards,
-Denis

--===============3875114976751905577==--

