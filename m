Content-Type: multipart/mixed; boundary="===============0450753175530248714=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 02/10] dpp: initial skeleton DPP module
Date: Tue, 14 Dec 2021 15:32:40 -0600
Message-ID: <e354a331-f8bd-9b15-3310-96425d78afcf@gmail.com>
In-Reply-To: 20211214181225.2308043-2-prestwoj@gmail.com

--===============0450753175530248714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/14/21 12:12 PM, James Prestwood wrote:
> ---
>   Makefile.am |   1 +
>   src/dpp.c   | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 129 insertions(+)
>   create mode 100644 src/dpp.c
> =

> v2:
>   * Only create dpp_sm if device is station
> =


<snip>

> +
> +static void dpp_netdev_watch(struct netdev *netdev,
> +				enum netdev_watch_event event, void *userdata)
> +{
> +	if (netdev_get_iftype(netdev) !=3D NETDEV_IFTYPE_STATION)
> +		return;
> +
> +	switch (event) {
> +	case NETDEV_WATCH_EVENT_NEW:

Can we also create it if the device is UP?

> +		dpp_create(netdev);
> +		break;
> +	case NETDEV_WATCH_EVENT_DEL:

And delete if the device is DOWN?

> +		l_dbus_object_remove_interface(dbus_get_bus(),
> +						netdev_get_path(netdev),
> +						IWD_DPP_INTERFACE);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbu=
s,
> +						struct l_dbus_message *message,
> +						void *user_data)
> +{
> +	struct dpp_sm *dpp =3D user_data;
> +
> +	if (!netdev_get_is_up(dpp->netdev))
> +		return dbus_error_not_available(message);

That way you can skip this check.  There isn't much point in having this =

interface around if the device is not UP anyway.

> +
> +	return dbus_error_not_supported(message);
> +}
> +

Regards,
-Denis
--===============0450753175530248714==--

