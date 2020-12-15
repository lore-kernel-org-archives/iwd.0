Content-Type: multipart/mixed; boundary="===============3238571731106845384=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] eap-tls: Make use of l_pem_load_container_file()
Date: Tue, 15 Dec 2020 01:56:11 +0000
Message-ID: <6da633ee-4599-1649-33d9-9f05d01c7465@gmail.com>
In-Reply-To: <20201212010954.583418-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3238571731106845384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 12/11/20 7:09 PM, Andrew Zaborowski wrote:
> This allows .p12 files and other formats to be used.  When a single file
> contains both the client certificates and the private key, it can be
> given as either EAP-{TLS,PEAP,TTLS}-ClientCert or -ClientKey.  Also both
> settings can point to the same or different files and only the
> certificates will be loaded from one and only the key from the other (if
> different).
> ---
>   src/eap-tls-common.c | 302 +++++++++++++++++++++++++------------------
>   1 file changed, 178 insertions(+), 124 deletions(-)
> =


<snip>

> @@ -1121,7 +1169,9 @@ bool eap_tls_common_settings_load(struct eap_state =
*eap,
>   	struct eap_tls_state *eap_tls;
>   	char setting_key[72];
>   	char *domain_mask_str;
> -	L_AUTO_FREE_VAR(char *, value) =3D NULL;
> +	L_AUTO_FREE_VAR(char *, ca_cert) =3D NULL;
> +	L_AUTO_FREE_VAR(char *, client_cert) =3D NULL;
> +	L_AUTO_FREE_VAR(char *, client_key) =3D NULL;
>   	L_AUTO_FREE_VAR(char *, passphrase) =3D NULL;
>   =

>   	eap_tls =3D l_new(struct eap_tls_state, 1);
> @@ -1130,47 +1180,51 @@ bool eap_tls_common_settings_load(struct eap_stat=
e *eap,
>   	eap_tls->variant_ops =3D variant_ops;
>   	eap_tls->variant_data =3D variant_data;
>   =

> +	snprintf(setting_key, sizeof(setting_key), "%sClientKeyPassphrase",
> +									prefix);
> +	passphrase =3D l_settings_get_string(settings, "Security", setting_key);
> +

So this reminds me that ClientKeyPassphrase, ClientKey and ClientCert are =

already only relevant to EAP-TLS.  They probably don't even belong being ch=
ecked =

here in eap_tls_common_settins_load, etc.

>   	snprintf(setting_key, sizeof(setting_key), "%sCACert", prefix);
> -	value =3D l_settings_get_string(settings, "Security", setting_key);
> -	if (value) {
> -		eap_tls->ca_cert =3D eap_tls_load_ca_cert(settings, value);
> -		if (!eap_tls->ca_cert) {
> -			l_error("Could not load CACert %s", value);
> +	ca_cert =3D l_settings_get_string(settings, "Security", setting_key);
> +	if (ca_cert) {
> +		eap_tls->ca_cert =3D eap_tls_load_ca_cert(settings, ca_cert);
> +		if (!eap_tls->ca_cert)
>   			goto load_error;

Hmm, the P12 files don't contain the CA certchain?  I thought the whole poi=
nt of =

these was to have the private key + public key + CA certchain?  Otherwise I=
 see =

little point in these since you effectively need to specify the P12 file _a=
nd_ =

the CACert file?

> -		}
>   	}
>   =

> -	l_free(value);
> -
>   	snprintf(setting_key, sizeof(setting_key), "%sClientCert", prefix);
> -	value =3D l_settings_get_string(settings, "Security", setting_key);
> -	if (value) {
> -		eap_tls->client_cert =3D eap_tls_load_client_cert(settings,
> -								value);
> -		if (!eap_tls->client_cert) {
> -			l_error("Could not load ClientCert %s", value);
> -			goto load_error;
> -		}
> -	}
> -
> -	l_free(value);
> -
> -	snprintf(setting_key, sizeof(setting_key), "%sClientKeyPassphrase",
> -									prefix);
> -	passphrase =3D l_settings_get_string(settings, "Security", setting_key);
> +	client_cert =3D l_settings_get_string(settings, "Security", setting_key=
);
>   =

>   	snprintf(setting_key, sizeof(setting_key), "%sClientKey", prefix);
> -	value =3D l_settings_get_string(settings, "Security", setting_key);
> -	if (value) {
> -		eap_tls->client_key =3D eap_tls_load_priv_key(settings, value,
> +	client_key =3D l_settings_get_string(settings, "Security", setting_key);
> +
> +	if (client_cert && is_embedded(client_cert))
> +		eap_tls->client_cert =3D eap_tls_load_embedded_cert(settings,
> +								client_cert);
> +	else if (client_cert) {
> +		l_pem_load_container_file(client_cert, passphrase,
> +						&eap_tls->client_cert,
> +						client_key ? NULL :
> +						&eap_tls->client_key, NULL);
> +	}
> +
> +	if (client_key && is_embedded(client_key))
> +		eap_tls->client_key =3D eap_tls_load_embedded_priv_key(settings,
> +								client_key,
>   								passphrase,
>   								NULL);
> -		if (!eap_tls->client_key) {
> -			l_error("Could not load ClientKey %s", value);
> -			goto load_error;
> -		}
> +	else if (client_key) {
> +		l_pem_load_container_file(client_key, passphrase,
> +						client_cert ? NULL :
> +						&eap_tls->client_cert,
> +						&eap_tls->client_key, NULL);
>   	}
>   =

> +	if ((client_cert && !eap_tls->client_cert) ||
> +			(client_key && !eap_tls->client_key) ||
> +			!eap_tls->client_cert !=3D !eap_tls->client_key)
> +		goto load_error;
> +

So assuming that the CACert is also part of the P12, I'd think =

eap_tls_load_settings should work something like:

password =3D l_settings_get(.., "ClientPassphrase");
container =3D l_settings_get(.., "ClientKey");

if (client_key_is_container) {
   // load client_key, client_cert, ca_cert
   // load ServerDomainMask
   return;
}

return eap_tls_common_settings_load()

>   	snprintf(setting_key, sizeof(setting_key), "%sServerDomainMask",
>   								prefix);
>   	domain_mask_str =3D l_settings_get_string(settings, "Security",
> =


Regards,
-Denis
--===============3238571731106845384==--

