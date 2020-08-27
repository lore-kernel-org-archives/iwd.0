Content-Type: multipart/mixed; boundary="===============0346235368801611035=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 07/11] ap: Stop ongoing handshake on reassociation
Date: Thu, 27 Aug 2020 14:11:24 -0500
Message-ID: <6b5eaab9-a7fd-ca7d-1f3a-c8dab2a8263c@gmail.com>
In-Reply-To: <20200827181453.61823-7-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0346235368801611035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/27/20 1:14 PM, Andrew Zaborowski wrote:
> On a new association or re-association, in addition to forgetting a
> complete RSN Association, also stop the EAPoL SM to stop any ongoing
> handshake.
> =

> Do this in a new function ap_stop_handshake that is now used in a few
> places that had copies of the same few lines.  I'll be adding some more
> lines to this function for WSC support.
> ---
>   src/ap.c | 51 +++++++++++++++++++++++++--------------------------
>   1 file changed, 25 insertions(+), 26 deletions(-)
> =

> diff --git a/src/ap.c b/src/ap.c
> index aef2e1dd..5cd2b717 100644
> --- a/src/ap.c
> +++ b/src/ap.c

No real concerns on the first three uses, but...

<snip>

> @@ -938,6 +933,12 @@ static void ap_assoc_reassoc(struct sta_state *sta, =
bool reassoc,
>   		goto unsupported;
>   	}
>   =

> +	/* 802.11-2016 11.3.5.3 j) */
> +	if (sta->rsna)
> +		ap_drop_rsna(sta);
> +
> +	ap_stop_handshake(sta);
> +

ap_drop_rsna also destroys eapol_sm and the handshake object.  So perhaps y=
ou =

need to track the authorized state to choose the right cleanup action?

>   	if (!sta->associated) {
>   		/*
>   		 * Everything fine so far, assign an AID, send response.
> @@ -961,10 +962,6 @@ static void ap_assoc_reassoc(struct sta_state *sta, =
bool reassoc,
>   =

>   	sta->assoc_rsne =3D l_memdup(rsn, rsn[1] + 2);
>   =

> -	/* 802.11-2016 11.3.5.3 j) */
> -	if (sta->rsna)
> -		ap_drop_rsna(sta);
> -
>   	sta->assoc_resp_cmd_id =3D ap_assoc_resp(ap, sta, sta->addr, sta->aid,=
 0,
>   						reassoc,
>   						ap_success_assoc_resp_cb);
> @@ -987,8 +984,10 @@ bad_frame:
>   	 *
>   	 * For now, we need to drop the RSNA.
>   	 */
> -	if (sta->associated && sta->rsna)
> +	if (sta->associated && sta->rsna) {
>   		ap_drop_rsna(sta);
> +		ap_stop_handshake(sta);
> +	}

Same question here?

>   =

>   	if (rates)
>   		l_uintset_free(rates);
> =


Regards,
-Denis
--===============0346235368801611035==--

