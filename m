Content-Type: multipart/mixed; boundary="===============4911967340798864773=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v4 07/10] dpp-util: add dpp_parse_configuration_object
Date: Thu, 16 Dec 2021 14:36:19 -0600
Message-ID: <2c079caf-7519-7589-6947-55fc223ae0f7@gmail.com>
In-Reply-To: 20211216180854.39470-7-prestwoj@gmail.com

--===============4911967340798864773==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/16/21 12:08, James Prestwood wrote:
> This parses the configuration JSON object from the configuration
> response. Only a minimal configuration object is supported for
> now.
> ---
>   Makefile.am    |   3 +-
>   src/dpp-util.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++
>   src/dpp-util.h |  12 ++++++
>   3 files changed, 124 insertions(+), 1 deletion(-)
> =


<snip>

> +/*
> + * TODO: This handles the most basic configuration. i.e. a configuration=
 object
> + * with ssid/passphrase/akm.
> + */
> +struct dpp_configuration *dpp_parse_configuration_object(const char *jso=
n,
> +							size_t json_len)
> +{
> +	struct dpp_configuration *config;
> +	struct json_contents *c;
> +	struct json_iter iter;
> +	struct json_iter discovery;
> +	struct json_iter cred;
> +	_auto_(l_free)char *tech =3D NULL;
> +	_auto_(l_free)char *ssid =3D NULL;
> +	_auto_(l_free)char *akm =3D NULL;
> +	_auto_(l_free)char *pass =3D NULL;
> +	_auto_(l_free)char *psk =3D NULL;

nit: I changed these to have a space after l_free) and char *

> +
> +	c =3D json_contents_new(json, json_len);
> +	if (!c)
> +		return NULL;
> +
> +	json_iter_init(&iter, c);
> +
> +	if (!json_iter_parse(&iter,
> +			JSON_MANDATORY("wi-fi_tech", JSON_STRING, &tech),
> +			JSON_MANDATORY("discovery", JSON_OBJECT, &discovery),
> +			JSON_MANDATORY("cred", JSON_OBJECT, &cred),
> +			JSON_UNDEFINED))
> +		goto free_contents;
> +
> +	if (!tech || strncmp(tech, "infra", 5))
> +		goto free_contents;
> +
> +

Got rid of this double empty line.

> +	if (!json_iter_parse(&discovery,
> +			JSON_MANDATORY("ssid", JSON_STRING, &ssid),
> +			JSON_UNDEFINED))
> +		goto free_contents;
> +
> +	if (!ssid || !util_ssid_is_utf8(strlen(ssid),(const uint8_t *)ssid))

And added a few spaces here for coding style reasons.

Applied, thanks.

Regards,
-Denis
--===============4911967340798864773==--

