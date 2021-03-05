Content-Type: multipart/mixed; boundary="===============7456222382927438050=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 04/10] ap: Add subnet address selection logic
Date: Fri, 05 Mar 2021 16:35:51 -0600
Message-ID: <175612f5-354f-a076-d601-a2590125aba4@gmail.com>
In-Reply-To: <20210305150936.868546-4-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7456222382927438050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> +		/*
> +		 * Ignore the subnet(s) set on the target interface, we'll be
> +		 * overwriting it if everything goes well.
> +		 */
> +		if (rec->ifindex =3D=3D ifindex)
> +			continue;

Ok, I'm a bit confused here.  I thought we're adding on to the address list=
, not =

flushing the addresses?  So shouldn't any addresses set on the target inter=
face =

still be taken into account as 'used'?

Regards,
-Denis
--===============7456222382927438050==--

