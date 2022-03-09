Content-Type: multipart/mixed; boundary="===============2661984795546262135=="
MIME-Version: 1.0
From: VAUTRIN Emmanuel (Canal Plus Prestataire) <Emmanuel.VAUTRIN at
 cpexterne.org>
To: iwd at lists.01.org
Subject: RE: [PATCH] network: Hide hidden networks on passphrase error
Date: Wed, 09 Mar 2022 08:28:11 +0000
Message-ID: <
 <MRZP264MB15442847B0DE53B9886299DE930A9@MRZP264MB1544.FRAP264.PROD.OUTLOOK.COM>>
In-Reply-To: be305787-4657-4278-942b-5a6c3b9e808f@gmail.com

--===============2661984795546262135==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> No real objections here, but there are at least two other places that mig=
ht be
> affected by this change:
>
> In station_dbus_connect_hidden_network() there is a code path that tries =
to skip
> the hidden network scan if the network is already in the scan results.  S=
ince
> you're removing this possibility, that path should probably be removed.

> In station_hidden_network_scan_results(), if the hidden SSID we scanned f=
or
> contains BSSes in both open and PSK networks, those networks aren't hidde=
n and
> could still be connectable.  This is highly unlikely, but...
Thank you Denis, I will check that. As I am not familiar with iwd source co=
de,
it may take some time.

> Alternatively, we could somehow mark these networks non-connectable unless
> they're done via the ConnectHiddenNetwork() path.
I was also thinking about this possibility. Do you think that the hidden ne=
twork shall also
be removed if an error occurs during connection, for example in station_con=
nect_cb?

Best Regards,

Emmanuel
--===============2661984795546262135==--

