Content-Type: multipart/mixed; boundary="===============0883856559610138074=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC 3/6] wiphy: integrate offchannel module
Date: Mon, 22 Jun 2020 14:44:20 -0500
Message-ID: <c21caa81-f921-baa6-aeef-2f3edfbf97c5@gmail.com>
In-Reply-To: <20200617175645.31197-3-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0883856559610138074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/17/20 12:56 PM, James Prestwood wrote:
> Tie wiphy creation/destruction to offchannel
> ---
>   src/wiphy.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> =

> diff --git a/src/wiphy.c b/src/wiphy.c
> index aef39549..7e58a402 100644
> --- a/src/wiphy.c
> +++ b/src/wiphy.c
> @@ -53,6 +53,7 @@
>   #include "src/watchlist.h"
>   #include "src/nl80211util.h"
>   #include "src/nl80211cmd.h"
> +#include "src/offchannel.h"
>   =

>   #define EXT_CAP_LEN 10
>   =

> @@ -1235,6 +1236,9 @@ void wiphy_create_complete(struct wiphy *wiphy)
>   	wiphy_get_reg_domain(wiphy);
>   =

>   	wiphy_print_basic_info(wiphy);
> +
> +	if (wiphy->offchannel_tx_ok)
> +		offchan_create_from_wiphy(wiphy);

Hmm, why? Isn't scanning always supported and hence you always want =

offchan_create to be called?

>   }
>   =

>   bool wiphy_destroy(struct wiphy *wiphy)

Regards,
-Denis
--===============0883856559610138074==--

