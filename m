Content-Type: multipart/mixed; boundary="===============4247895869646522685=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/10] ap: Load profile before calling ap_start, extend
 Address syntax
Date: Fri, 05 Mar 2021 16:19:40 -0600
Message-ID: <36f74829-cb08-8bcc-c06d-4a5939b5ffb3@gmail.com>
In-Reply-To: <20210305150936.868546-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4247895869646522685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 3/5/21 9:09 AM, Andrew Zaborowski wrote:
> After the profile support was added some settings were passed to
> ap_start() through the ap_config struct and others were loaded inside
> ap_start() based on the profile path.  Instead make profiles transparent
> to ap_start():
> =

> * don't pass the profile path to ap_start(),
> * add storage for the profile settings directly to ap_config,

This is ok, but I would actually load them directly into the l_dhcp_server =
object

> * load and validate the settings from the profile file directly
>    in the caller (ap_dbus_start_profile).
> =

> Now any user of the ap_start() api can set those values and the
> difference between .Start and .StartProfile is only that one loads the
> extra settings from the profile whlie the other relies on the defaults.

typo 'whlie'

> =

> Temporarily drop most of the DHCP setup code as it needs to be rewritten
> to account for the new setting syntax and setup order, this happens in
> the subsequent commits in steps.
> =

> While I'm rewriting the profile loading I also expand the [IPv4].Address
> syntax to allow a new format: a list of <IP>/<prefix_len> -form strings
> that define the address space for subnet address selection.

Not ideal, but ok..

> ---
>   src/ap.c | 425 ++++++++++++++++++++++---------------------------------
>   src/ap.h |  10 +-
>   2 files changed, 180 insertions(+), 255 deletions(-)
> =

> diff --git a/src/ap.c b/src/ap.c
> index 2042cde6..677ba8fa 100644
> --- a/src/ap.c
> +++ b/src/ap.c
> @@ -225,6 +225,171 @@ static const char *broadcast_from_ip(const char *ip)
>   	return inet_ntoa(ia);
>   }
>   =

> +#define AP_DEFAULT_IPV4_PREFIX_LEN 28
> +
> +struct ap_config *ap_config_load_profile(const char *ssid)
> +{
> +	L_AUTO_FREE_VAR(char *, profile_path) =3D
> +		storage_get_path("ap/%s.ap", ssid);
> +	L_AUTO_FREE_OBJ(l_settings, profile) =3D l_settings_new();

So I can't apply this until the ell part is figured out.  Way to live on =

bleeding edge :)

> +	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
> +	struct ap_config *config;
> +	uint32_t static_addr4 =3D 0;
> +	unsigned int lease_time;
> +
> +	if (!l_settings_load_from_file(profile, profile_path))
> +		return NULL;
> +
> +	passphrase =3D l_settings_get_string(profile, "Security",
> +							"Passphrase");
> +	if (!passphrase) {
> +		l_error("[Security].Passphrase not found in "
> +			"AP profile");

Hmm, don't we have open network profiles?

> +		return NULL;
> +	}
> +
> +	/* Full checks done later in crypto_passphrase_is_valid() */
> +	if (strlen(passphrase) > 63) {

I wonder why we would want to delay this?  Also, where does this check actu=
ally =

happen?  I can't seem to find this in this patch set?  Or do you mean somew=
here =

inside ap_start when we try to generate the PSK?

I would actually run the full sanity check here...

> +		l_error("[Security].Passphrase must not exceed "
> +			"63 characters");
> +		return NULL;
> +	}
> +
> +	config =3D l_new(struct ap_config, 1);
> +	config->ssid =3D l_strdup(ssid);
> +	strcpy(config->passphrase, passphrase);
> +
> +	if (!l_settings_has_group(profile, "IPv4")) {
> +		config->disable_netconfig4 =3D true;
> +		return config;
> +	}
> +
> +	if (l_settings_get_value(profile, "IPv4", "Address")) {
> +		struct in_addr ia;
> +
> +		config->addr4_str_list =3D l_settings_get_string_list(profile,
> +								"IPv4",
> +								"Address", ',');
> +		if (!config->addr4_str_list || !*config->addr4_str_list) {
> +			l_error("Can't parse the profile [IPv4].Address "
> +				"setting as a string list");
> +			goto invalid_format;
> +		}
> +
> +		/* Check for the static IP syntax: Address=3D<IP> */
> +		if (l_strv_length((char **) config->addr4_str_list) =3D=3D 1 &&
> +				inet_pton(AF_INET, *config->addr4_str_list,
> +						&ia) =3D=3D 1)
> +			static_addr4 =3D ntohl(ia.s_addr);
> +	}
> +
> +	if (l_settings_get_value(profile, "IPv4", "Netmask")) {
> +		L_AUTO_FREE_VAR(char *, netmask_str) =3D
> +			l_settings_get_string(profile, "IPv4", "Netmask");
> +		struct in_addr ia;
> +
> +		if (inet_pton(AF_INET, netmask_str, &ia) !=3D 1) {
> +			l_error("Can't parse the profile [IPv4].Netmask "
> +				"setting");
> +			goto invalid_format;
> +		}
> +
> +		config->prefix_len4 =3D __builtin_popcount(ia.s_addr);
> +
> +		if (ntohl(ia.s_addr) !=3D
> +				util_netmask_from_prefix(config->prefix_len4)) {
> +			l_error("Invalid profile [IPv4].Netmask value");
> +			goto invalid_format;
> +		}
> +	}
> +
> +	if (l_settings_get_value(profile, "IPv4", "DNSList")) {
> +		config->dns_addr4_str_list =3D l_settings_get_string_list(
> +								profile, "IPv4",
> +								"DNSList", ',');
> +		if (!config->dns_addr4_str_list ||
> +				!*config->dns_addr4_str_list) {
> +			l_error("Can't parse the profile [IPv4].DNSList "
> +				"setting as a string list");
> +			goto invalid_format;
> +		}
> +	}
> +
> +	if (l_settings_get_value(profile, "IPv4", "IPRange")) {
> +		char **ip_range =3D l_settings_get_string_list(profile, "IPv4",
> +								"IPRange", ',');
> +		int i;
> +		uint32_t netmask;
> +
> +		if (!static_addr4 || !config->prefix_len4) {
> +			l_error("[IPv4].IPRange only makes sense in an AP "
> +				"profile if a static local address and "
> +				"netmask have also been specified");
> +			l_strv_free(ip_range);
> +			goto invalid_format;
> +		}
> +
> +		if (!ip_range || l_strv_length(ip_range) !=3D 2) {
> +			l_error("Can't parse the profile [IPv4].IPRange "
> +				"setting as two address strings");
> +			l_strv_free(ip_range);
> +			goto invalid_format;
> +		}
> +
> +		netmask =3D util_netmask_from_prefix(config->prefix_len4);
> +
> +		for (i =3D 0; i < 2; i++) {
> +			struct in_addr range_addr;
> +
> +			if (inet_aton(ip_range[i], &range_addr) !=3D 1) {
> +				l_error("Can't parse address in "
> +					"[IPv4].IPRange[%i]", i + 1);
> +				goto invalid_format;
> +			}
> +
> +			if ((static_addr4 ^ ntohl(range_addr.s_addr)) &
> +					netmask) {
> +				struct in_addr addr =3D { htonl(static_addr4) };
> +
> +				l_error("[IPv4].IPRange[%i] is not in the "
> +					"%s/%i subnet", i + 1,
> +					inet_ntoa(addr), config->prefix_len4);
> +				goto invalid_format;
> +			}
> +
> +			if (i =3D=3D 0)
> +				config->dhcp_start_addr4 =3D
> +					ntohl(range_addr.s_addr);
> +			else
> +				config->dhcp_end_addr4 =3D
> +					ntohl(range_addr.s_addr);
> +		}
> +	}
> +
> +	if (l_settings_get_value(profile, "IPv4", "Gateway")) {
> +		L_AUTO_FREE_VAR(char *, gateway_str) =3D
> +			l_settings_get_string(profile, "IPv4", "Gateway");
> +		struct in_addr ia;
> +
> +		if (inet_pton(AF_INET, gateway_str, &ia) !=3D 1) {
> +			l_error("Can't parse the profile [IPv4].Gateway "
> +				"setting");
> +			goto invalid_format;
> +		}
> +
> +		config->dhcp_gateway_addr4 =3D ntohl(ia.s_addr);
> +	}
> +
> +	if (l_settings_get_uint(profile, "IPv4", "LeaseTime", &lease_time))
> +		config->dhcp_lease_time =3D lease_time;

So as mentioned above, there's really no harm in just building the l_dhcp_s=
erver =

object as you go here.  Nothing actually happens until l_dhcp_server_start =
is =

called, so most of the settings can be filled in without needing this =

intermediate storage.  You might need to also tell the caller whether an ad=
dress =

needs to be allocated.

> +
> +	return config;
> +
> +invalid_format:
> +	ap_config_free(config);
> +	return NULL;
> +}
> +
>   void ap_config_free(struct ap_config *config)
>   {
>   	if (unlikely(!config))

Regards,
-Denis
--===============4247895869646522685==--

