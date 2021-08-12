Content-Type: multipart/mixed; boundary="===============3557397611751891227=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] knownnetworks: stat fallback for unknown d_type
Date: Thu, 12 Aug 2021 10:02:12 -0500
Message-ID: <027d0e45-bac4-8f10-0fa7-e642c724aa3e@gmail.com>
In-Reply-To: <20210809052726.177038-2-matt.r.oberle@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3557397611751891227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On 8/9/21 12:27 AM, Matt Oberle wrote:
> Utilize 'storage_is_file' when readdir returns DT_UNKNOWN to ensure
> features like autoconnect work on filesystems that don't return a d_type
> (eg. XFS).
> ---
>   src/knownnetworks.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> =


All applied.  I did make a minor amend for style reasons:

> diff --git a/src/knownnetworks.c b/src/knownnetworks.c
> index 85648ead..5c3f432a 100644
> --- a/src/knownnetworks.c
> +++ b/src/knownnetworks.c
> @@ -1071,8 +1071,12 @@ static int known_networks_init(void)
>   		struct l_settings *settings;
>   		L_AUTO_FREE_VAR(char *, full_path) =3D NULL;
>   =

> -		if (dirent->d_type !=3D DT_REG && dirent->d_type !=3D DT_LNK)
> +		if (dirent->d_type =3D=3D DT_UNKNOWN) {
> +			if (!storage_is_file(dirent->d_name))
> +				continue;
> +		} else if (dirent->d_type !=3D DT_REG && dirent->d_type !=3D DT_LNK) {

Broke up this line into two so it fits on 80 char columns.  Similar amend i=
n =

patch 3.

>   			continue;
> +		}
>   =

>   		ssid =3D storage_network_ssid_from_path(dirent->d_name,
>   							&security);
> =


Thanks!

Regards,
-Denis
--===============3557397611751891227==--

