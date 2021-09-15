Content-Type: multipart/mixed; boundary="===============5541297723918484805=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 04/13] scan: change ssid scan parameter to a list
Date: Wed, 15 Sep 2021 14:57:34 -0500
Message-ID: <df4ee987-1233-8f2d-6b76-821cd9745489@gmail.com>
In-Reply-To: 20210915173624.11917-4-prestwoj@gmail.com

--===============5541297723918484805==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/15/21 12:36 PM, James Prestwood wrote:
> The ssid parameter was used for direct probe responses for finding
> hidden networks. OWE transition will be added which requires a
> hidden OWE network. IWD will need to automatically hidden scan for
> one or multiple of these networks and doing so in separate scans
> would be hard to manage.
> =

> To prep for this the ssid scan parameter is being changed to a string
> list which can contain many SSIDs to probe for.
> ---
>   src/p2p.c     |  7 +++++--
>   src/scan.c    | 12 ++++++++----
>   src/scan.h    |  2 +-
>   src/station.c | 11 ++++++++---
>   4 files changed, 22 insertions(+), 10 deletions(-)
> =


<snip>

> diff --git a/src/scan.c b/src/scan.c
> index 5e31c308..e74874be 100644
> --- a/src/scan.c
> +++ b/src/scan.c
> @@ -539,10 +539,14 @@ static void scan_cmds_add(struct l_queue *cmds, str=
uct scan_context *sc,
>   =

>   	l_genl_msg_enter_nested(cmd, NL80211_ATTR_SCAN_SSIDS);
>   =

> -	if (params->ssid) {
> -		/* direct probe request scan */
> -		l_genl_msg_append_attr(cmd, NL80211_ATTR_SSID,
> -					strlen(params->ssid), params->ssid);
> +	/* direct probe request scan */
> +	if (params->ssids) {
> +		unsigned int i;
> +
> +		for (i =3D 0; i < l_strv_length((char **)params->ssids); i++)
> +			l_genl_msg_append_attr(cmd, NL80211_ATTR_SSID,

Nested attributes work slightly differently.  The attribute in an array is =

supposed to be just an index starting at 0.  Kernel probably doesn't check =
this =

that strictly though.

> +						strlen(params->ssids[i]),
> +						params->ssids[i]);

The real problem here is if you add more SSIDs than =

wiphy_get_max_num_ssids_per_scan().  Unlikely, but... :)

>   		l_genl_msg_leave_nested(cmd);
>   =

>   		l_queue_push_tail(cmds, cmd);

Regards,
-Denis
--===============5541297723918484805==--

