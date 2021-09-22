Content-Type: multipart/mixed; boundary="===============4887862255238912750=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/4] ie: parse operating class/channel for
 ie_owe_transition_info
Date: Wed, 22 Sep 2021 14:33:26 -0500
Message-ID: <dd4925c7-b9e9-4071-41f7-73e03faf5d6c@gmail.com>
In-Reply-To: 20210922193418.13072-1-prestwoj@gmail.com

--===============4887862255238912750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James

On 9/22/21 2:34 PM, James Prestwood wrote:
> This operating class/channel is also verified while parsing and
> parsing will fail if band_oci_frequency fails.
> =

> This does put a requirement on anything that uses ie.c to also
> include band.c. Makefile has been updated.

I updated the commit description and...

> ---
>   src/ie.c | 28 +++++++++++++++++-----------
>   src/ie.h |  2 ++
>   2 files changed, 19 insertions(+), 11 deletions(-)
> =

> diff --git a/src/ie.c b/src/ie.c
> index 0abc01cb..f0163ea2 100644
> --- a/src/ie.c
> +++ b/src/ie.c
> @@ -33,6 +33,7 @@
>   #include "src/util.h"
>   #include "src/crypto.h"
>   #include "src/ie.h"
> +#include "src/band.h"
>   =


I took out this include.  Applied, thanks.

Regards,
-Denis

--===============4887862255238912750==--

