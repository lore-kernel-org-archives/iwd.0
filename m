Content-Type: multipart/mixed; boundary="===============0977594471333300840=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/3] station: network: rework ERP/FILS code path
Date: Tue, 03 Aug 2021 15:47:51 -0500
Message-ID: <8b872f80-5d14-b572-a812-34ad197c3083@gmail.com>
In-Reply-To: <20210803202328.140665-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0977594471333300840==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/3/21 3:23 PM, James Prestwood wrote:
> This refactors some code to eliminate getting the ERP entry twice
> by simply returning it from network_has_erp_identity (now renamed
> to network_get_erp_cache). In addition this code was moved into
> station_build_handshake_rsn and properly cleaned up in case there
> was an error or if a FILS AKM was not chosen.
> ---
>   src/network.c | 15 ++++++++-------
>   src/network.h |  3 ++-
>   src/station.c | 33 +++++++++++++++++++--------------
>   3 files changed, 29 insertions(+), 22 deletions(-)
> =


<snip>

> @@ -1083,17 +1083,18 @@ bool network_has_erp_identity(struct network *net=
work)
>   	ret =3D strcmp(check_id, identity) =3D=3D 0;
>   =

>   	l_free(check_id);
> -	erp_cache_put(cache);
>   =

>   	/*
>   	 * The settings file must have change out from under us. In this
>   	 * case we want to remove the ERP entry because it is no longer
>   	 * valid.
>   	 */
> -	if (!ret)
> +	if (!ret) {
>   		erp_cache_remove(identity);

This doesn't look right?  Shouldn't you erp_cache_put here as well?

> +		return NULL;
> +	}
>   =

> -	return ret;
> +	return cache;
>   }
>   =

>   const struct l_queue_entry *network_bss_list_get_entries(

<snip>

Regards,
-Denis
--===============0977594471333300840==--

