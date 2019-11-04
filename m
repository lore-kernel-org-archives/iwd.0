Content-Type: multipart/mixed; boundary="===============1423195886963314140=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] wiphy: add beacon bits to RM Enabled Capabilities
Date: Mon, 04 Nov 2019 14:43:21 -0600
Message-ID: <7ba05bbe-3ff3-dbf4-eb7a-66909f981be3@gmail.com>
In-Reply-To: <20191029175043.27745-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1423195886963314140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/29/19 12:50 PM, James Prestwood wrote:
> This tells AP's that we support Passive, Active, and Table beacon
> measurements.
> ---
>   src/wiphy.c | 2 ++
>   1 file changed, 2 insertions(+)
> =

> diff --git a/src/wiphy.c b/src/wiphy.c
> index 36e6c73d..37d06bc7 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -961,6 +961,8 @@ static void wiphy_setup_rm_enabled_capabilities(struc=
t wiphy *wiphy)
>   =

>   	wiphy->rm_enabled_capabilities[0] =3D IE_TYPE_RM_ENABLED_CAPABILITIES;
>   	wiphy->rm_enabled_capabilities[1] =3D 5;
> +	/* Bits: Passive (4), Active (5), and Beacon Table (6) capabilities */
> +	wiphy->rm_enabled_capabilities[2] =3D 0x70;

Do you really mean to add all of these or just the Beacon table one?

>   =

>   	/*
>   	 * TODO: Support at least Link Measurement if TX_POWER_INSERTION is
> =


Regards,
-Denis
--===============1423195886963314140==--

