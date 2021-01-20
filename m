Content-Type: multipart/mixed; boundary="===============1563760445751333709=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 6/8] client: implement "ap <wlan> show"
Date: Wed, 20 Jan 2021 12:36:21 -0800
Message-ID: <896e748bf1bbad8359c353d8d63e29ba6e25bb9a.camel@gmail.com>
In-Reply-To: <25b40ae4-958d-5d4c-722d-a3d3bb578512@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1563760445751333709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-01-20 at 14:16 -0600, Denis Kenzior wrote:
> Hi James,
> =

> On 1/20/21 12:30 PM, James Prestwood wrote:
> > This command uses GetDiagnostics to show a list of connected
> > clients and some information about them. The information
> > contained for each connected station nearly maps 1:1 with the
> > station diagnostics information shown in "station <wlan> show"
> > apart from "ConnectedBss" which is now "Address".
> > ---
> >   client/ap.c | 97
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 97 insertions(+)
> > =

> =

> <snip>
> =

> > +static void display_client(struct l_dbus_message_iter *iter)
> > +{
> > +	struct l_dbus_message_iter variant;
> > +	const char *key;
> > +
> > +	while (l_dbus_message_iter_next_entry(iter, &key, &variant)) {
> > +		const char *s_value;
> > +		uint32_t u_value;
> > +		int16_t i_value;
> > +		uint8_t y_value;
> > +
> > +		if (!strcmp(key, "Address") || !strcmp(key, "RxMode")
> > ||
> > +				!strcmp(key, "TxMode")) {
> > +			/* String variants with no special handling */
> > +
> > +			l_dbus_message_iter_get_variant(&variant, "s",
> > +							&s_value);
> > +
> > +			display("%-*s%-*s\n", 20, key, 47, s_value);
> > +		} else if (!strcmp(key, "RxBitrate") ||
> > +				!strcmp(key, "TxBitrate")) {
> > +			/* Bitrates expressed in 100Kbit/s */
> > +
> > +			l_dbus_message_iter_get_variant(&variant, "u",
> > +							&u_value);
> > +			display("%-*s%u Kbit/s\n", 20, key, u_value *
> > 100);
> > +		} else if (!strcmp(key, "ExpectedThroughput")) {
> > +			/* ExpectedThroughput expressed in Kbit/s */
> > +
> > +			l_dbus_message_iter_get_variant(&variant, "u",
> > +							&u_value);
> > +			display("%*s  %-*s%u Kbit/s\n", 0, "", 20,
> > +				key, u_value);
> > +		} else if (!strcmp(key, "RSSI")) {
> > +			/* RSSI expressed in dBm */
> > +
> > +			l_dbus_message_iter_get_variant(&variant, "n",
> > +							&i_value);
> > +			display("%-*s%i dBm\n", 20, key, i_value);
> > +		} else if (!strcmp(key, "RxMCS") || !strcmp(key,
> > "TxMCS")) {
> > +			/* MCS index's are single byte integers */
> > +
> > +			l_dbus_message_iter_get_variant(&variant, "y",
> > +							&y_value);
> > +			display("%-*s%u\n", 20, key, y_value);
> > +		}
> =

> Along the lines of comment to patch 4, should the display of these
> attributes be =

> forked out to a utility  function given that they're the same between
> station / =

> ap for the most part?

Yeah I'll come up with something. I think we need some kind of
name/function mapping for these since there is at least one difference
betweens station/ap (ConnectedBss/Address). Anyways, I'll do this for
iwctl and commonize the processing in IWD core as well.

> =

> > +	}
> > +}
> > +
> =

> Regards,
> -Denis

--===============1563760445751333709==--

