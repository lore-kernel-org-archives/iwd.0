Content-Type: multipart/mixed; boundary="===============3194439276463687460=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 3/8] netconfig: Set netconfig_get_static6_gateway out
 param on success
Date: Wed, 29 Sep 2021 15:17:41 -0500
Message-ID: <fbfbf8df-c71c-cc45-adb9-fa777939eabe@gmail.com>
In-Reply-To: 20210925011153.25195-3-andrew.zaborowski@intel.com

--===============3194439276463687460==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/24/21 8:11 PM, Andrew Zaborowski wrote:
> Make sure to only set the netconfig_get_static6_gateway's out_mac
> parameter on successful return and make sure to always set it, even if
> to NULL.
> ---
>   src/netconfig.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============3194439276463687460==--

