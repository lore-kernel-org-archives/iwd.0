Content-Type: multipart/mixed; boundary="===============6477552558634709142=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] wsc: Check capability before adding
 .SimpleConfiguration interface
Date: Wed, 06 Nov 2019 17:03:10 -0600
Message-ID: <15d8091a-82ef-d926-3325-760666b0a04e@gmail.com>
In-Reply-To: <20191106221624.12072-2-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6477552558634709142==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

> +bool wiphy_is_scan_ie_supported(struct wiphy *wiphy)
> +{
> +	return wiphy->max_scan_ie_len ? true : false;
> +}
> +

Lets not go overboard adding APIs to wiphy.c now..  You already have =

something that can accomplish the job, so just use that.

<snip>

> diff --git a/src/wsc.c b/src/wsc.c
> index bac6e0cc..ed211834 100644
> --- a/src/wsc.c
> +++ b/src/wsc.c
> @@ -1108,6 +1108,13 @@ static void wsc_add_interface(struct netdev *netde=
v)
>   	struct l_dbus *dbus =3D dbus_get_bus();
>   	struct wsc *wsc;
>   =

> +	if (!wiphy_is_scan_ie_supported(netdev_get_wiphy(netdev))) {
> +		l_info("Simple Configuration isn't supported by ifindex %u",
> +						netdev_get_ifindex(netdev));
> +
> +		return;
> +	}

I don't like the l_info here.  This will get printed way too many times =

due to ifup/ifdown.  Perhaps we need to add an L_WARN_ONCE or do this =

statically here.

> +
>   	wsc =3D l_new(struct wsc, 1);
>   	wsc->netdev =3D netdev;
>   =

> =


Regards,
-Denis
--===============6477552558634709142==--

