Content-Type: multipart/mixed; boundary="===============9164597901126023929=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/17] Add minimal p2p.c and p2p.h
Date: Fri, 17 Apr 2020 15:19:29 +0000
Message-ID: <4206a9c2-f8a3-dcba-a011-e00f3312367a@gmail.com>
In-Reply-To: <20200403161430.14168-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9164597901126023929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 4/3/20 11:14 AM, Andrew Zaborowski wrote:
> Add the functions to be called by manager.c and a minimal DBus API.
> ---
>   Makefile.am |   1 +
>   src/p2p.c   | 354 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   src/p2p.h   |  31 +++++
>   3 files changed, 386 insertions(+)
>   create mode 100644 src/p2p.c
>   create mode 100644 src/p2p.h
> =


<snip>

> +#include <stdlib.h>
> +#include <linux/rtnetlink.h>
> +#include <linux/if_ether.h>
> +#include <unistd.h>
> +#include <limits.h>
> +#include <stdio.h>
> +#include <time.h>
> +#include <errno.h>

So just for the future, it would be nice to introduce headers only as =

you need them so it is a bit easier to track whether something is truly =

required.

> +
> +#include <ell/ell.h>
> +
> +#include "linux/nl80211.h"
> +
> +#include "src/iwd.h"
> +#include "src/wiphy.h"
> +#include "src/scan.h"
> +#include "src/p2putil.h"
> +#include "src/ie.h"
> +#include "src/util.h"
> +#include "src/dbus.h"
> +#include "src/netdev.h"
> +#include "src/mpdu.h"
> +#include "src/common.h"
> +#include "src/wsc.h"
> +#include "src/handshake.h"
> +#include "src/crypto.h"
> +#include "src/module.h"
> +#include "src/frame-xchg.h"
> +#include "src/nl80211util.h"
> +#include "src/p2p.h"

Same for the internal ones...

<snip>

> +struct p2p_device *p2p_device_update_from_genl(struct l_genl_msg *msg,
> +						bool create)
> +{
> +	struct l_genl_attr attr;
> +	uint16_t type, len;
> +	const void *data;
> +	const uint8_t *ifaddr =3D NULL;
> +	const uint64_t *wdev_id =3D NULL;
> +	struct wiphy *wiphy =3D NULL;
> +	struct p2p_device *dev;
> +
> +	if (!l_genl_attr_init(&attr, msg))
> +		return NULL;
> +
> +	while (l_genl_attr_next(&attr, &type, &len, &data)) {
> +		switch (type) {
> +		case NL80211_ATTR_WDEV:
> +			if (len !=3D sizeof(uint64_t)) {
> +				l_warn("Invalid wdev index attribute");
> +				return NULL;
> +			}
> +
> +			wdev_id =3D data;
> +			break;
> +
> +		case NL80211_ATTR_WIPHY:
> +			if (len !=3D sizeof(uint32_t)) {
> +				l_warn("Invalid wiphy attribute");
> +				return NULL;
> +			}
> +
> +			wiphy =3D wiphy_find(*((uint32_t *) data));
> +			break;
> +
> +		case NL80211_ATTR_IFTYPE:
> +			if (len !=3D sizeof(uint32_t)) {
> +				l_warn("Invalid interface type attribute");
> +				return NULL;
> +			}
> +
> +			if (*((uint32_t *) data) !=3D NL80211_IFTYPE_P2P_DEVICE)
> +				return NULL;
> +
> +			break;
> +
> +		case NL80211_ATTR_MAC:
> +			if (len !=3D ETH_ALEN) {
> +				l_warn("Invalid interface address attribute");
> +				return NULL;
> +			}
> +
> +			ifaddr =3D data;
> +			break;
> +		}
> +	}

I suspect you can change this to use nl80211util now...

> +
> +	if (!wiphy || !wdev_id || !ifaddr) {
> +		l_warn("Unable to parse interface information");
> +		return NULL;
> +	}
> +
> +	if (create) {
> +		if (p2p_device_find(*wdev_id)) {
> +			l_debug("Duplicate p2p device %" PRIx64, *wdev_id);
> +			return NULL;
> +		}
> +	} else {
> +		dev =3D p2p_device_find(*wdev_id);
> +		if (!dev)
> +			return NULL;
> +
> +		memcpy(dev->addr, ifaddr, ETH_ALEN);
> +		return NULL;
> +	}
> +
> +	dev =3D l_new(struct p2p_device, 1);
> +	dev->wdev_id =3D *wdev_id;
> +	memcpy(dev->addr, ifaddr, ETH_ALEN);
> +	dev->wiphy =3D wiphy;
> +	dev->connections_left =3D 1;
> +
> +	l_queue_push_tail(p2p_device_list, dev);
> +
> +	l_debug("Created P2P device %" PRIx64, dev->wdev_id);
> +
> +	if (!l_dbus_object_add_interface(dbus_get_bus(),
> +						p2p_device_get_path(dev),
> +						IWD_P2P_INTERFACE, dev))
> +		l_info("Unable to add the %s interface to %s",
> +			IWD_P2P_INTERFACE, p2p_device_get_path(dev));
> +
> +	return dev;
> +}
> +

Applied, thanks.

Regards,
-Denis
--===============9164597901126023929==--

