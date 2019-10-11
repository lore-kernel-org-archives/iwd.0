Content-Type: multipart/mixed; boundary="===============4151557113775687750=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 06/11] manager: utilize IWD_MODULE
Date: Fri, 11 Oct 2019 13:57:48 -0500
Message-ID: <2e468dc6-bc20-4109-c205-0697a4bb2e23@gmail.com>
In-Reply-To: <20191011172417.23328-6-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4151557113775687750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/11/19 12:24 PM, James Prestwood wrote:
> Converts manager into an IWD module. Two getters needed to be added so
> manager can get the white/black list of interfaces.

Can we split this up into two commits please.  One for the getter =

refactoring and one for the module migration.

> ---
>   src/iwd.h     |  5 ++---
>   src/main.c    | 13 ++++++++++---
>   src/manager.c | 26 ++++++++++++++++++--------
>   3 files changed, 30 insertions(+), 14 deletions(-)
> =

> diff --git a/src/iwd.h b/src/iwd.h
> index 7ae7e4b4..8814c244 100644
> --- a/src/iwd.h
> +++ b/src/iwd.h
> @@ -30,9 +30,8 @@ struct l_genl *iwd_get_genl(void);
>   =

>   void netdev_shutdown(void);
>   =

> -bool manager_init(struct l_genl_family *in,
> -			const char *if_whitelist, const char *if_blacklist);
> -void manager_exit(void);
> +const char *iwd_get_iface_whitelist(void);
> +const char *iwd_get_iface_blacklist(void);

Don't we also have phy lists?  Ah I guess you take care of this in the =

next patch...

>   =

>   struct iwd_module_desc {
>   	const char *name;

<snip>

> @@ -637,10 +639,15 @@ bool manager_init(struct l_genl_family *in,
>   	if (randomize_str && !strcmp(randomize_str, "once"))
>   		randomize =3D true;
>   =

> -	return true;
> +	return 0;
> +
> +error:
> +	l_queue_destroy(pending_wiphys, NULL);
> +	l_genl_family_free(nl80211);

Maybe reset nl80211 to NULL just to be pedantic

> +	return -EIO;
>   }
>   =

> -void manager_exit(void)
> +static void manager_exit(void)
>   {
>   	l_strfreev(whitelist_filter);
>   	l_strfreev(blacklist_filter);

Regards,
-Denis
--===============4151557113775687750==--

