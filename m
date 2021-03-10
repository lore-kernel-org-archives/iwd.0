Content-Type: multipart/mixed; boundary="===============0725481860886128522=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] scan: allow 'faked' scan_bss results
Date: Wed, 10 Mar 2021 16:25:51 -0600
Message-ID: <2cf01d62-edaf-bdff-2b59-0d6153285c33@gmail.com>
In-Reply-To: <20210310202746.28475-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0725481860886128522==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/10/21 2:27 PM, James Prestwood wrote:
> When a full mac roam occurs IWD has no idea about how the
> roam occurred, including any scan results associated with
> it. IWD just gets a roam event (basically CMD_CONNECT) and
> will need to 'fake' a scan result to provide to station.
> =

> To allow this scan_bss_rank_compare was exposed, and
> scan_bss_addr_eq was also modified to work with queue's.
> This will allow station to insert a 'faked' scan_bss result
> into its list as if it did a prior scan. A new frame type
> was added, SCAN_BSS_NONE, which will indicate this scan
> result was obtained via other means (aka faked). This may
> not be strictly required but it makes things clearer
> for cleanup, and avoids frame type specific routines.
> ---
>   src/p2p.c  | 3 +++
>   src/scan.c | 7 ++++++-
>   src/scan.h | 8 ++++++--
>   3 files changed, 15 insertions(+), 3 deletions(-)
> =


<snip>

> diff --git a/src/scan.h b/src/scan.h
> index 355b4b5a..dc7f4688 100644
> --- a/src/scan.h
> +++ b/src/scan.h
> @@ -43,6 +43,7 @@ enum scan_bss_frame_type {
>   	SCAN_BSS_PROBE_RESP,
>   	SCAN_BSS_PROBE_REQ,
>   	SCAN_BSS_BEACON,
> +	SCAN_BSS_NONE,

Ah, I'm not a huge fan of adding enum entries that don't represent anything=
. =

Given that this is a huge special case that only station cares about, can w=
e =

just fake it by setting SCAN_BSS_PROBE_RESP?

>   };
>   =

>   struct scan_bss {
> @@ -115,9 +116,11 @@ static inline int scan_bss_addr_cmp(const struct sca=
n_bss *a1,
>   	return memcmp(a1->addr, a2->addr, sizeof(a1->addr));
>   }
>   =

> -static inline bool scan_bss_addr_eq(const struct scan_bss *a1,
> -					const struct scan_bss *a2)
> +static inline bool scan_bss_addr_eq(const void *a, const void *b)
>   {
> +	const struct scan_bss *a1 =3D a;
> +	const struct scan_bss *a2 =3D b;
> +

Not really against this, but wouldn't you use bss_match_bssid inside statio=
n.c?

>   	return !memcmp(a1->addr, a2->addr, sizeof(a1->addr));
>   }
>   =

> @@ -153,6 +156,7 @@ uint64_t scan_get_triggered_time(uint64_t wdev_id, ui=
nt32_t id);
>   =

>   void scan_bss_free(struct scan_bss *bss);
>   int scan_bss_rank_compare(const void *a, const void *b, void *user);
> +void scan_bss_compute_rank(struct scan_bss *bss);

Okay, but don't you also want to parse the IEs obtained from GET_STATION / =

NEW_STATION?  i.e. scan_parse_bss_information_elements() or similar?

So maybe a better approach would be another constructor that takes mac, rss=
i, =

ies and frequency?

>   =

>   int scan_bss_get_rsn_info(const struct scan_bss *bss, struct ie_rsn_inf=
o *info);
>   =

> =


Regards,
-Denis
--===============0725481860886128522==--

