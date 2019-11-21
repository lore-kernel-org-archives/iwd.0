Content-Type: multipart/mixed; boundary="===============0011235908186461406=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] netdev: Replace bool randomize_mac with specific
 address
Date: Wed, 20 Nov 2019 20:42:05 -0600
Message-ID: <67caa6ed-07b8-9a60-9426-b3b14d8fba22@gmail.com>
In-Reply-To: <20191120222346.7881-6-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0011235908186461406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 11/20/19 4:23 PM, Andrew Zaborowski wrote:
> Allow netdev_create_from_genl callers to draw a random or non-random MAC
> and pass it in the parameter instead of a bool to tell us to generating
> the MAC locally.  In P2P we are generating the MAC some time before
> creating the netdev to pass it to the peer during negotiation.
> ---
>   src/manager.c | 22 ++++++++++++++++++----
>   src/netdev.c  | 44 +++++++++++++++++++++-----------------------
>   src/netdev.h  |  3 ++-
>   3 files changed, 41 insertions(+), 28 deletions(-)
>

<snip>

> diff --git a/src/netdev.c b/src/netdev.c
> index eb8a7ce8..eea7267d 100644
> --- a/src/netdev.c
> +++ b/src/netdev.c
> @@ -125,6 +125,7 @@ struct netdev {
>   	int8_t cur_rssi;
>   	struct l_timeout *rssi_poll_timeout;
>   	uint32_t rssi_poll_cmd_id;
> +	uint8_t *set_mac_once;

So just nit-picking, but using uint8_t set_mac_once[6] would still use =

less space (at least on 64-bit) and also skip mallocing/freeing 6 byte =

array...

Set it to all zeros or something to act as a NULL value

>   =

>   	uint32_t set_powered_cmd_id;
>   	netdev_command_cb_t set_powered_cb;
> @@ -147,7 +148,6 @@ struct netdev {
>   	bool ignore_connect_event : 1;
>   	bool expect_connect_failure : 1;
>   	bool aborting : 1;
> -	bool mac_randomize_once : 1;
>   	bool events_ready : 1;
>   };
>   =

> @@ -634,6 +634,7 @@ static void netdev_free(void *data)
>   =

>   	l_io_destroy(netdev->pae_io);
>   =

> +	l_free(netdev->set_mac_once);
>   	l_free(netdev);
>   }
>   =

> @@ -4255,6 +4256,21 @@ static void netdev_set_mac_cb(int error, uint16_t =
type, const void *data,
>   					netdev_initial_up_cb, netdev, NULL);
>   }
>   =

> +static bool netdev_check_set_mac(struct netdev *netdev)
> +{
> +	if (!netdev->set_mac_once)
> +		return false;
> +
> +	l_debug("Setting initial address on ifindex: %d to: " MAC,
> +		netdev->index, MAC_STR(netdev->set_mac_once));
> +	netdev->set_powered_cmd_id =3D
> +		rtnl_set_mac(rtnl, netdev->index, netdev->set_mac_once,
> +				netdev_set_mac_cb, netdev, NULL);
> +	l_free(netdev->set_mac_once);
> +	netdev->set_mac_once =3D NULL;
> +	return true;
> +}
> +
>   static void netdev_initial_down_cb(int error, uint16_t type, const void=
 *data,
>   					uint32_t len, void *user_data)
>   {
> @@ -4270,17 +4286,8 @@ static void netdev_initial_down_cb(int error, uint=
16_t type, const void *data,
>   		return;
>   	}
>   =

> -	if (netdev->mac_randomize_once) {
> -		uint8_t addr[ETH_ALEN];
> -
> -		wiphy_generate_random_address(netdev->wiphy, addr);
> -		l_debug("Setting initial random address on "
> -			"ifindex: %d to: "MAC, netdev->index, MAC_STR(addr));
> -		netdev->set_powered_cmd_id =3D
> -			rtnl_set_mac(rtnl, netdev->index, addr,
> -					netdev_set_mac_cb, netdev, NULL);
> +	if (netdev_check_set_mac(netdev))
>   		return;
> -	}
>   =

>   	netdev->set_powered_cmd_id =3D
>   		rtnl_set_powered(rtnl, netdev->index, true,
> @@ -4322,17 +4329,8 @@ static void netdev_getlink_cb(int error, uint16_t =
type, const void *data,
>   	 */
>   	powered =3D netdev_get_is_up(netdev);
>   =

> -	if (!powered && netdev->mac_randomize_once) {
> -		uint8_t addr[ETH_ALEN];
> -
> -		wiphy_generate_random_address(netdev->wiphy, addr);
> -		l_debug("Setting initial random address on "
> -			"ifindex: %d to: "MAC, netdev->index, MAC_STR(addr));
> -		netdev->set_powered_cmd_id =3D
> -			rtnl_set_mac(rtnl, netdev->index, addr,
> -					netdev_set_mac_cb, netdev, NULL);
> +	if (!powered && netdev_check_set_mac(netdev))
>   		return;
> -	}
>   =

>   	cb =3D powered ? netdev_initial_down_cb : netdev_initial_up_cb;
>   =

> @@ -4507,7 +4505,7 @@ error:
>   	return NULL;
>   }
>   =

> -struct netdev *netdev_create_from_genl(struct l_genl_msg *msg, bool rand=
om_mac)
> +struct netdev *netdev_create_from_genl(struct l_genl_msg *msg, const uin=
t8_t set_mac[6])
>   {
>   	struct l_genl_attr attr;
>   	uint16_t type, len;
> @@ -4624,7 +4622,7 @@ struct netdev *netdev_create_from_genl(struct l_gen=
l_msg *msg, bool random_mac)
>   	memcpy(netdev->name, ifname, ifname_len);
>   	netdev->wiphy =3D wiphy;
>   	netdev->pae_over_nl80211 =3D pae_io =3D=3D NULL;
> -	netdev->mac_randomize_once =3D random_mac;
> +	netdev->set_mac_once =3D set_mac ? l_memdup(set_mac, 6) : NULL;
>   =

>   	if (pae_io) {
>   		netdev->pae_io =3D pae_io;
> diff --git a/src/netdev.h b/src/netdev.h
> index 032265f9..c5b6f139 100644
> --- a/src/netdev.h
> +++ b/src/netdev.h
> @@ -205,5 +205,6 @@ uint32_t netdev_station_watch_add(struct netdev *netd=
ev,
>   =

>   bool netdev_station_watch_remove(struct netdev *netdev, uint32_t id);
>   =

> -struct netdev *netdev_create_from_genl(struct l_genl_msg *msg, bool rand=
om_mac);
> +struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
> +					const uint8_t addr[6]);

Nitpicking again.  This syntax is pretty useless since addr is treated =

like a const uint8_t *.  It only serves to confuse the reader.  We =

should not be using this form at all.

Use const uint8_t addr[static 6] instead.

>   bool netdev_destroy(struct netdev *netdev);
> =


Regards,
-Denis
--===============0011235908186461406==--

