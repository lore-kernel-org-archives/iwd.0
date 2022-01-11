Content-Type: multipart/mixed; boundary="===============8292410928933317357=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 2/3] scan: set scan priority via scan_common
Date: Tue, 11 Jan 2022 09:07:20 -0600
Message-ID: <451616f8-9402-c544-8ac8-cebc6bfee298@gmail.com>
In-Reply-To: 20220111001519.1013183-2-prestwoj@gmail.com

--===============8292410928933317357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 1/10/22 18:15, James Prestwood wrote:
> This adds a priority argument to scan_common rather than hard
> coding it when inserting the work item
> ---
>   src/scan.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> =

> diff --git a/src/scan.c b/src/scan.c
> index 54159dfd..96907e59 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -52,6 +52,8 @@
>   #include "src/band.h"
>   #include "src/scan.h"
>   =

> +#define SCAN_WORK_PRIORITY 2

Can we name this SCAN_REQUEST_PRIORITY, or even simply REQUEST_PRIORITY?

Also, I wonder if we should put the priority numbers into wiphy.h instead o=
f =

relying on hard-coded 1/2/3 everywhere.

Regards,
-Denis
--===============8292410928933317357==--

