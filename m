Content-Type: multipart/mixed; boundary="===============0312241510991349700=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: Prevent a NULL pointer access
Date: Sat, 06 Nov 2021 12:56:28 -0500
Message-ID: <3c0e6c34-3054-276c-9f0f-44c57b173f84@gmail.com>
In-Reply-To: 20211106023651.15224-1-noreply.torsten@gmail.com

--===============0312241510991349700==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Torsten,

On 11/5/21 9:36 PM, Torsten Schmitz wrote:
> There is an unchecked NULL pointer access in network_has_open_pair.
> open_info can definitely be NULL, I have the coredumps to prove it.
> Let's check owe_info too though.

Thanks for the report.  Could you provide a bit more info about the network =

setup you managed to trigger this on?  I think the underlying cause would b=
e =

useful to put into the commit description.

> ---
>   src/station.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> =

> diff --git a/src/station.c b/src/station.c
> index 19f2aaeb..75ec36df 100644
> --- a/src/station.c
> +++ b/src/station.c
> @@ -693,11 +693,17 @@ static bool network_has_open_pair(struct network *n=
etwork, struct scan_bss *owe)
>   	const struct l_queue_entry *entry;
>   	struct ie_owe_transition_info *owe_info =3D owe->owe_trans;
>   =

> +	if (!owe_info)
> +		return false;
> +

This should not be necessary since owe_info is checked right before invokin=
g =

this function.  See station_owe_transition_results():

	if (!bss->rsne || !bss->owe_trans ||
		...
		goto free;

>   	for (entry =3D network_bss_list_get_entries(network); entry;
>   				entry =3D entry->next) {
>   		struct scan_bss *open =3D entry->data;
>   		struct ie_owe_transition_info *open_info =3D open->owe_trans;
>   =

> +		if (!open_info)
> +			continue;
> +

This would imply that this network has a set of APs that advertise the same =

SSID, but do not advertise an OWE transition element, and some APs that do =

advertise it?  I.e. some legacy APs that do not have a hidden partner?  If =
so, =

then this detail is worth mentioning.

>   		/*
>   		 * Check if this is an Open/Hidden pair:
>   		 *
> =


Regards,
-Denis
--===============0312241510991349700==--

