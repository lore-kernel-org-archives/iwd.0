Content-Type: multipart/mixed; boundary="===============3129300306948116447=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 2/4] dpp-util: add URI generation API
Date: Mon, 06 Dec 2021 16:33:11 -0600
Message-ID: <7512a662-842a-f71c-38f7-db7f7b853300@gmail.com>
In-Reply-To: 20211206210356.1204046-2-prestwoj@gmail.com

--===============3129300306948116447==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 12/6/21 3:03 PM, James Prestwood wrote:
> ---
>   src/dpp-util.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/dpp-util.h |  4 ++++
>   2 files changed, 64 insertions(+)
> =

> diff --git a/src/dpp-util.c b/src/dpp-util.c
> index 8482b1ff..ca641311 100644
> --- a/src/dpp-util.c
> +++ b/src/dpp-util.c
> @@ -33,6 +33,66 @@
>   #include "src/dpp-util.h"
>   #include "src/util.h"
>   #include "src/crypto.h"
> +#include "src/scan.h"
> +

I switched this to include src/band.h instead of scan.h, which is what seem=
s to =

be intended.

Also a whitespace fix for a line > 80 chars.

Patches 1-3 applied, thanks.

Regards,
-Denis

--===============3129300306948116447==--

