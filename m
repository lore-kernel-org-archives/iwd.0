Content-Type: multipart/mixed; boundary="===============5212944175824900756=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 5/9] ft: get OCI prior to reassociation
Date: Tue, 28 Sep 2021 11:03:47 -0500
Message-ID: <185247c1-67ea-e722-914d-dca6a675ff38@gmail.com>
In-Reply-To: 20210928154658.2382597-5-prestwoj@gmail.com

--===============5212944175824900756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/28/21 10:46 AM, James Prestwood wrote:
> This modifies the FT logic to fist call get_oci() before
> reassociation. This allows the OCI to be included in reassociation
> and in the 4-way handshake later on.
> =

> The code path for getting the OCI had to be slightly changed to
> handle an OCI that is already set. First the handshake chandef is
> NULL'ed out for any new connection. This prevents a stale OCI from
> being used. Then some checks were added for this case in
> netdev_connect_event and if chandef is already set, start the 4-way
> handshake.
> ---
>   src/ft.c     | 13 ++++++++++++-
>   src/ft.h     |  2 ++
>   src/netdev.c | 29 ++++++++++++++++++++++++++---
>   3 files changed, 40 insertions(+), 4 deletions(-)
> =


<snip>

> @@ -3633,6 +3651,8 @@ static void netdev_connect_common(struct netdev *ne=
tdev,
>   	netdev->privacy =3D bss->capability & IE_BSS_CAP_PRIVACY;
>   	handshake_state_set_authenticator_address(hs, bss->addr);
>   =

> +	handshake_state_set_chandef(hs, NULL);
> +
>   	if (!is_rsn)
>   		goto build_cmd_connect;
>   =


netdev_connect_common always operates on a brand new handshake, so this sho=
uld =

not be needed.  I took this out for now.

Patches 1-8 applied, thanks.

Regards,
-Denis

--===============5212944175824900756==--

