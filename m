Content-Type: multipart/mixed; boundary="===============8176488796886544640=="
MIME-Version: 1.0
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: Re: [RFC connman v2 1/1] WIP: Add wpa_supplicant WPA3-SAE support
Date: Wed, 02 Jun 2021 14:05:20 -0300
Message-ID: <af8f0fb6-a33c-e7d7-8bce-48c3ec07b01c@collabora.com>
In-Reply-To: <20210527214134.33792-2-ariel.dalessandro@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8176488796886544640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Just a gentle a ping in case you have time to take a look at this
patchset v2 :-) let me know if this address the requirements we
discussed on patchset v1.

Thanks a lot!
Ariel

On 5/27/21 6:41 PM, Ariel D'Alessandro wrote:
> Implement WPA3-SAE authentication on connman side using wpa_supplicant
> backend.
> =

> Initially based on Tizen project:
> =

>   https://review.tizen.org/git/?p=3Dplatform/upstream/connman.git
> =

> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  gsupplicant/gsupplicant.h | 10 ++++++++++
>  gsupplicant/supplicant.c  | 33 ++++++++++++++++++++++++++++++---
>  plugins/wifi.c            | 21 +++++++++++++++++++++
>  3 files changed, 61 insertions(+), 3 deletions(-)
> =

> diff --git a/gsupplicant/gsupplicant.h b/gsupplicant/gsupplicant.h
> index 7935c3a6..eab6293f 100644
> --- a/gsupplicant/gsupplicant.h
> +++ b/gsupplicant/gsupplicant.h
> @@ -61,6 +61,7 @@ extern "C" {
>  #define G_SUPPLICANT_KEYMGMT_WPA_EAP	(1 << 7)
>  #define G_SUPPLICANT_KEYMGMT_WPA_EAP_256	(1 << 8)
>  #define G_SUPPLICANT_KEYMGMT_WPS		(1 << 9)
> +#define G_SUPPLICANT_KEYMGMT_SAE		(1 << 10)
>  =

>  #define G_SUPPLICANT_PROTO_WPA		(1 << 0)
>  #define G_SUPPLICANT_PROTO_RSN		(1 << 1)
> @@ -129,6 +130,12 @@ typedef enum {
>  	G_SUPPLICANT_PEER_GROUP_FAILED,
>  } GSupplicantPeerState;
>  =

> +typedef enum {
> +	G_SUPPLICANT_MFP_NONE,
> +	G_SUPPLICANT_MFP_OPTIONAL,
> +	G_SUPPLICANT_MFP_REQUIRED,
> +} GSupplicantMfpOptions;
> +
>  struct _GSupplicantSSID {
>  	const void *ssid;
>  	unsigned int ssid_len;
> @@ -155,6 +162,8 @@ struct _GSupplicantSSID {
>  	dbus_bool_t use_wps;
>  	const char *pin_wps;
>  	const char *bgscan;
> +	unsigned int keymgmt;
> +	GSupplicantMfpOptions ieee80211w;
>  };
>  =

>  typedef struct _GSupplicantSSID GSupplicantSSID;
> @@ -339,6 +348,7 @@ bool g_supplicant_peer_is_in_a_group(GSupplicantPeer =
*peer);
>  GSupplicantInterface *g_supplicant_peer_get_group_interface(GSupplicantP=
eer *peer);
>  bool g_supplicant_peer_is_client(GSupplicantPeer *peer);
>  bool g_supplicant_peer_has_requested_connection(GSupplicantPeer *peer);
> +unsigned int g_supplicant_network_get_keymgmt(GSupplicantNetwork *networ=
k);
>  =

>  struct _GSupplicantCallbacks {
>  	void (*system_ready) (void);
> diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
> index f56b595f..be05575c 100644
> --- a/gsupplicant/supplicant.c
> +++ b/gsupplicant/supplicant.c
> @@ -92,6 +92,7 @@ static struct strvalmap keymgmt_map[] =3D {
>  	{ "wpa-eap",		G_SUPPLICANT_KEYMGMT_WPA_EAP	},
>  	{ "wpa-eap-sha256",	G_SUPPLICANT_KEYMGMT_WPA_EAP_256	},
>  	{ "wps",		G_SUPPLICANT_KEYMGMT_WPS		},
> +	{ "sae",		G_SUPPLICANT_KEYMGMT_SAE		},
>  	{ }
>  };
>  =

> @@ -234,6 +235,7 @@ struct _GSupplicantNetwork {
>  	unsigned int wps_capabilities;
>  	GHashTable *bss_table;
>  	GHashTable *config_table;
> +	unsigned int keymgmt;
>  };
>  =

>  struct _GSupplicantPeer {
> @@ -1427,6 +1429,14 @@ bool g_supplicant_peer_has_requested_connection(GS=
upplicantPeer *peer)
>  	return peer->connection_requested;
>  }
>  =

> +unsigned int g_supplicant_network_get_keymgmt(GSupplicantNetwork *networ=
k)
> +{
> +	if (network =3D=3D NULL)
> +		return 0;
> +
> +	return network->keymgmt;
> +}
> +
>  static void merge_network(GSupplicantNetwork *network)
>  {
>  	GString *str;
> @@ -1457,7 +1467,8 @@ static void merge_network(GSupplicantNetwork *netwo=
rk)
>  	else if (g_strcmp0(mode, "1") =3D=3D 0)
>  		g_string_append_printf(str, "_adhoc");
>  =

> -	if (g_strcmp0(key_mgmt, "WPA-PSK") =3D=3D 0)
> +	if ((g_strcmp0(key_mgmt, "WPA-PSK") =3D=3D 0) ||
> +	    (g_strcmp0(key_mgmt, "SAE") =3D=3D 0))
>  		g_string_append_printf(str, "_psk");
>  =

>  	group =3D g_string_free(str, FALSE);
> @@ -1650,6 +1661,7 @@ static int add_or_replace_bss_to_network(struct g_s=
upplicant_bss *bss)
>  	network->name =3D create_name(bss->ssid, bss->ssid_len);
>  	network->mode =3D bss->mode;
>  	network->security =3D bss->security;
> +	network->keymgmt =3D bss->keymgmt;
>  	network->ssid_len =3D bss->ssid_len;
>  	memcpy(network->ssid, bss->ssid, bss->ssid_len);
>  	network->signal =3D bss->signal;
> @@ -1931,7 +1943,8 @@ static void bss_compute_security(struct g_supplican=
t_bss *bss)
>  	if (bss->keymgmt &
>  			(G_SUPPLICANT_KEYMGMT_WPA_PSK |
>  				G_SUPPLICANT_KEYMGMT_WPA_FT_PSK |
> -				G_SUPPLICANT_KEYMGMT_WPA_PSK_256))
> +				G_SUPPLICANT_KEYMGMT_WPA_PSK_256 |
> +				G_SUPPLICANT_KEYMGMT_SAE))
>  		bss->psk =3D TRUE;
>  =

>  	if (bss->ieee8021x)
> @@ -4890,6 +4903,15 @@ static void add_network_security_proto(DBusMessage=
Iter *dict,
>  	g_free(proto);
>  }
>  =

> +static void add_network_ieee80211w(DBusMessageIter *dict, GSupplicantSSI=
D *ssid)
> +{
> +	if (!(ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE))
> +		return;
> +
> +	supplicant_dbus_dict_append_basic(dict, "ieee80211w", DBUS_TYPE_UINT32,
> +					  &ssid->ieee80211w);
> +}
> +
>  static void add_network_security(DBusMessageIter *dict, GSupplicantSSID =
*ssid)
>  {
>  	char *key_mgmt;
> @@ -4907,7 +4929,10 @@ static void add_network_security(DBusMessageIter *=
dict, GSupplicantSSID *ssid)
>  		add_network_security_ciphers(dict, ssid);
>  		break;
>  	case G_SUPPLICANT_SECURITY_PSK:
> -		key_mgmt =3D "WPA-PSK";
> +		if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE)
> +			key_mgmt =3D "SAE";
> +		else
> +			key_mgmt =3D "WPA-PSK";
>  		add_network_security_psk(dict, ssid);
>  		add_network_security_ciphers(dict, ssid);
>  		add_network_security_proto(dict, ssid);
> @@ -4969,6 +4994,8 @@ static void interface_add_network_params(DBusMessag=
eIter *iter, void *user_data)
>  =

>  	add_network_security(&dict, ssid);
>  =

> +	add_network_ieee80211w(&dict, ssid);
> +
>  	supplicant_dbus_dict_append_fixed_array(&dict, "ssid",
>  					DBUS_TYPE_BYTE, &ssid->ssid,
>  						ssid->ssid_len);
> diff --git a/plugins/wifi.c b/plugins/wifi.c
> index 6233fe11..f990d40c 100644
> --- a/plugins/wifi.c
> +++ b/plugins/wifi.c
> @@ -167,6 +167,10 @@ struct wifi_data {
>  	int assoc_code;
>  };
>  =

> +struct wifi_network {
> +	unsigned int keymgmt;
> +};
> +
>  struct disconnect_data {
>  	struct wifi_data *wifi;
>  	struct connman_network *network;
> @@ -809,6 +813,7 @@ static void remove_networks(struct connman_device *de=
vice,
>  	for (list =3D wifi->networks; list; list =3D list->next) {
>  		struct connman_network *network =3D list->data;
>  =

> +		g_free(connman_network_get_data(network));
>  		connman_device_remove_network(device, network);
>  		connman_network_unref(network);
>  	}
> @@ -2148,6 +2153,7 @@ static GSupplicantSecurity network_security(const c=
har *security)
>  =

>  static void ssid_init(GSupplicantSSID *ssid, struct connman_network *net=
work)
>  {
> +	struct wifi_network *network_data =3D connman_network_get_data(network);
>  	const char *security;
>  =

>  	memset(ssid, 0, sizeof(*ssid));
> @@ -2157,6 +2163,8 @@ static void ssid_init(GSupplicantSSID *ssid, struct=
 connman_network *network)
>  	ssid->scan_ssid =3D 1;
>  	security =3D connman_network_get_string(network, "WiFi.Security");
>  	ssid->security =3D network_security(security);
> +	ssid->keymgmt =3D network_data->keymgmt;
> +	ssid->ieee80211w =3D G_SUPPLICANT_MFP_OPTIONAL;
>  	ssid->passphrase =3D connman_network_get_string(network,
>  						"WiFi.Passphrase");
>  =

> @@ -2801,6 +2809,7 @@ static void network_added(GSupplicantNetwork *suppl=
icant_network)
>  	struct connman_network *network;
>  	GSupplicantInterface *interface;
>  	struct wifi_data *wifi;
> +	struct wifi_network *network_data;
>  	const char *name, *identifier, *security, *group, *mode;
>  	const unsigned char *ssid;
>  	unsigned int ssid_len;
> @@ -2849,8 +2858,19 @@ static void network_added(GSupplicantNetwork *supp=
licant_network)
>  		}
>  =

>  		wifi->networks =3D g_slist_prepend(wifi->networks, network);
> +
> +		network_data =3D g_try_new0(struct wifi_network, 1);
> +		if (!network_data) {
> +			connman_error("Out of memory creating wifi network");
> +			return;
> +		}
> +		connman_network_set_data(network, network_data);
>  	}
>  =

> +	network_data =3D connman_network_get_data(network);
> +	network_data->keymgmt =3D
> +		g_supplicant_network_get_keymgmt(supplicant_network);
> +
>  	if (name && name[0] !=3D '\0')
>  		connman_network_set_name(network, name);
>  =

> @@ -2918,6 +2938,7 @@ static void network_removed(GSupplicantNetwork *net=
work)
>  =

>  	wifi->networks =3D g_slist_remove(wifi->networks, connman_network);
>  =

> +	g_free(connman_network_get_data(connman_network));
>  	connman_device_remove_network(wifi->device, connman_network);
>  	connman_network_unref(connman_network);
>  }
>=20
--===============8176488796886544640==--

