Content-Type: multipart/mixed; boundary="===============1277854939493766629=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 7/7] doc: document access point scanning
Date: Wed, 23 Feb 2022 12:43:31 -0600
Message-ID: <db615d8d-a416-e3d2-ec7f-80ffdc5d1ead@gmail.com>
In-Reply-To: 20220222225718.2485794-7-prestwoj@gmail.com

--===============1277854939493766629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/22/22 16:57, James Prestwood wrote:
> ---
>   doc/access-point-api.txt | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> =


<snip>

> +		array(dict) GetOrderedNetworks()
> +
> +			Gets the list of networks found after scanning sorted
> +			based on signal strength. Each item in the array is a
> +			dictionary containing the network Name, SignalStrength,
> +			and Security.

Security -> Type to be consistent with KnownNetwork / Network interface nam=
ing =

of the properties.

> +
> +			This list will expire similarly to station, and since
> +			access points do not do periodic scans the list may
> +			become empty after some time and requires scanning
> +			again.

I'm not sure what this is about?  Scan results don't actually expire in Sta=
tion =

in the sense that you can keep calling GetOrderedNetworks() forever and get=
 the =

same results, as long as scanning hasn't been performed.  Essentially if =

Scanning hasn't changed, GetOrderedNetworks() results shouldn't change eith=
er.

I would expect the same behavior here?

Regards,
-Denis
--===============1277854939493766629==--

