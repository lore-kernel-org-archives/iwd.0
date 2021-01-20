Content-Type: multipart/mixed; boundary="===============7696176232400786928=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/8] client: implement "ap <wlan> show"
Date: Wed, 20 Jan 2021 14:16:21 -0600
Message-ID: <25b40ae4-958d-5d4c-722d-a3d3bb578512@gmail.com>
In-Reply-To: <20210120183036.477287-6-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7696176232400786928==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/20/21 12:30 PM, James Prestwood wrote:
> This command uses GetDiagnostics to show a list of connected
> clients and some information about them. The information
> contained for each connected station nearly maps 1:1 with the
> station diagnostics information shown in "station <wlan> show"
> apart from "ConnectedBss" which is now "Address".
> ---
>   client/ap.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 97 insertions(+)
> =


<snip>

> +static void display_client(struct l_dbus_message_iter *iter)
> +{
> +	struct l_dbus_message_iter variant;
> +	const char *key;
> +
> +	while (l_dbus_message_iter_next_entry(iter, &key, &variant)) {
> +		const char *s_value;
> +		uint32_t u_value;
> +		int16_t i_value;
> +		uint8_t y_value;
> +
> +		if (!strcmp(key, "Address") || !strcmp(key, "RxMode") ||
> +				!strcmp(key, "TxMode")) {
> +			/* String variants with no special handling */
> +
> +			l_dbus_message_iter_get_variant(&variant, "s",
> +							&s_value);
> +
> +			display("%-*s%-*s\n", 20, key, 47, s_value);
> +		} else if (!strcmp(key, "RxBitrate") ||
> +				!strcmp(key, "TxBitrate")) {
> +			/* Bitrates expressed in 100Kbit/s */
> +
> +			l_dbus_message_iter_get_variant(&variant, "u",
> +							&u_value);
> +			display("%-*s%u Kbit/s\n", 20, key, u_value * 100);
> +		} else if (!strcmp(key, "ExpectedThroughput")) {
> +			/* ExpectedThroughput expressed in Kbit/s */
> +
> +			l_dbus_message_iter_get_variant(&variant, "u",
> +							&u_value);
> +			display("%*s  %-*s%u Kbit/s\n", 0, "", 20,
> +				key, u_value);
> +		} else if (!strcmp(key, "RSSI")) {
> +			/* RSSI expressed in dBm */
> +
> +			l_dbus_message_iter_get_variant(&variant, "n",
> +							&i_value);
> +			display("%-*s%i dBm\n", 20, key, i_value);
> +		} else if (!strcmp(key, "RxMCS") || !strcmp(key, "TxMCS")) {
> +			/* MCS index's are single byte integers */
> +
> +			l_dbus_message_iter_get_variant(&variant, "y",
> +							&y_value);
> +			display("%-*s%u\n", 20, key, y_value);
> +		}

Along the lines of comment to patch 4, should the display of these attribut=
es be =

forked out to a utility  function given that they're the same between stati=
on / =

ap for the most part?

> +	}
> +}
> +

Regards,
-Denis
--===============7696176232400786928==--

