Content-Type: multipart/mixed; boundary="===============3667781128853120929=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] network: Hide hidden networks on passphrase error
Date: Tue, 08 Mar 2022 12:09:01 -0600
Message-ID: <be305787-4657-4278-942b-5a6c3b9e808f@gmail.com>
In-Reply-To: MRZP264MB1544C0BDFAF731AC2E61806693099@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM

--===============3667781128853120929==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Emmanuel,

On 3/8/22 04:59, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
> If a user connection fails on a freshly scanned psk hidden network,
> during passphrase request, it shall be removed from the network list.
> Otherwise, it would be possible to directly connect to that known
> network, which will appear as not hidden.
> =

> Commit 06ca8e20a9b0 ("station: Hide forgotten hidden networks")
> ---
>   src/network.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> =

> diff --git a/src/network.c b/src/network.c
> index d7f472be97d2..ef3df96bab42 100644
> --- a/src/network.c
> +++ b/src/network.c
> @@ -1204,6 +1204,7 @@ static void passphrase_callback(enum agent_result r=
esult,
>   	struct network *network =3D user_data;
>   	struct station *station =3D network->station;
>   	struct scan_bss *bss;
> +	bool was_hidden;
>   =

>   	l_debug("result %d", result);
>   =

> @@ -1242,6 +1243,13 @@ static void passphrase_callback(enum agent_result =
result,
>   	return;
>   =

>   err:
> +	if (!network->settings || !l_settings_get_bool(network->settings,
> +						NET_HIDDEN, &was_hidden))
> +		was_hidden =3D false;
> +
> +	if (was_hidden)
> +		station_hide_network(station, network);
> +

No real objections here, but there are at least two other places that might=
 be =

affected by this change:

In station_dbus_connect_hidden_network() there is a code path that tries to=
 skip =

the hidden network scan if the network is already in the scan results.  Sin=
ce =

you're removing this possibility, that path should probably be removed.

In station_hidden_network_scan_results(), if the hidden SSID we scanned for =

contains BSSes in both open and PSK networks, those networks aren't hidden =
and =

could still be connectable.  This is highly unlikely, but...

Alternatively, we could somehow mark these networks non-connectable unless =

they're done via the ConnectHiddenNetwork() path.

>   	network_settings_close(network);
>   }
>   =

> =


Regards,
-Denis
--===============3667781128853120929==--

