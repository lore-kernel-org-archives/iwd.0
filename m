Content-Type: multipart/mixed; boundary="===============0933171850863659221=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 4/5] client: implement "ap <wlan> show"
Date: Thu, 21 Jan 2021 14:12:23 -0600
Message-ID: <1d05591b-10f8-e76c-b7f0-926c31739373@gmail.com>
In-Reply-To: <81c30f2b251963fca4f2eda59c2a48f89d254457.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0933171850863659221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/21/21 2:05 PM, James Prestwood wrote:
> Hi,
> =

>>> +static void display_bitrate_100kbps(struct l_dbus_message_iter
>>> *variant,
>>> +				const char *key, const char *margin,
>>> +				int name_column_width, int
>>> value_column_width)
>>> +{
>>> +	uint32_t rate;
>>> +
>>> +	l_dbus_message_iter_get_variant(variant, "u", &rate);
>>> +
>>> +	display("%s%-*s%-*u Kbit/s\n", margin, name_column_width, key,
>>> +			value_column_width, rate * 100);
>>> +}
>>
>> You don't want this in display.[ch] somewhere?
> =

> I could do that. Its the same for station/ap. The reason I put it here
> is because its not really a generalized display API since its so unique
> to this specific value. But I'm fine either way, I'll put it in
> display.c/h so we don't have it duplicated.

Could also put this into diagnostic.[ch] or something as well.  In theory e=
ven =

the dict_mapping parts can be shared since they're mostly the same, and =

Address/CurrentBss won't occur in the same message.

> =

>>
>>> +
>>> +static const struct display_dict_mapping diagnostic_mapping[] =3D {
>>> +	{ "Address", 's', NULL },
>>> +	{ "RxMode", 's', NULL },
>>> +	{ "TxMode", 's', NULL },
>>> +	{ "RxBitrate", 0, display_bitrate_100kbps },
>>> +	{ "TxBitrate", 0, display_bitrate_100kbps },
>>> +	{ "ExpectedThroughput", 'u', "Kbit/s" },
>>> +	{ "RSSI", 'n', "dBm" },
>>> +	{ "RxMCS", 'y', NULL },
>>> +	{ "TxMCS", 'y', NULL},
>>> +	{ NULL }
>>> +};
>>> +
>>> +static void ap_get_diagnostics_callback(struct l_dbus_message
>>> *message,
>>> +					void *user_data)
>>> +{
>>> +	struct l_dbus_message_iter array;
>>> +	struct l_dbus_message_iter iter;
>>> +	uint16_t idx =3D 0;
>>> +	char client_num[15];
>>> +
>>> +	if (dbus_message_has_error(message))
>>> +		return;
>>
>> Does this need to print something as well?
> =

> That function does more than just check (though you wouldn't guess it
> from the name). It ends up converting the error into a string and
> printing it.

Ok, cool.

Regards,
-Denis
--===============0933171850863659221==--

