Content-Type: multipart/mixed; boundary="===============5974007391702761787=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] network: fix handling of
 AlwaysRandomizeAddress/AddressOverride
Date: Fri, 03 Jun 2022 15:53:41 -0500
Message-ID: <be131c00-62a6-b42f-acbb-b8a77d7d52cd@gmail.com>
In-Reply-To: 20220603205427.216954-1-prestwoj@gmail.com

--===============5974007391702761787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/3/22 15:54, James Prestwood wrote:
> For network configuration files the man pages (iwd.network) state
> that [General].{AlwaysRandomizeAddress,AddressOverride} are only
> used if main.conf has [General].AddressRandomization=3Dnetwork.
> =

> This actually was not being enforced and both iwd.network settings
> were still taken into account regardless of what AddressRandomization
> was set to (even disabled).
> =

> The handshake setup code now checks the AddressRandomization value
> and if anything other than 'network' skips the randomization.
> ---
>   src/network.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============5974007391702761787==--

