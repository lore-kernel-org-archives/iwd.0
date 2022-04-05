Content-Type: multipart/mixed; boundary="===============0822617278063645995=="
MIME-Version: 1.0
From: Paul Menzel <pmenzel at molgen.mpg.de>
To: iwd at lists.01.org
Subject: Re: [PATCH v3] network: Hide hidden networks on connection error
Date: Tue, 05 Apr 2022 16:49:01 +0200
Message-ID: <1769f085-c991-c761-01cb-adecb580b0c3@molgen.mpg.de>
In-Reply-To: 07242056-a1fb-64b3-4aa5-bcbc26deb49e@gmail.com

--===============0822617278063645995==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear Denis, dear Emmanuel,


Am 05.04.22 um 16:34 schrieb Denis Kenzior:
> Hi Emmanuel,
> =

> On 4/5/22 06:19, VAUTRIN Emmanuel (Canal Plus Prestataire) wrote:
>> If a user connection fails on a freshly scanned psk or open hidden netwo=
rk,
>> during passphrase request or after, it shall be removed from the network=
 list.
>> Otherwise, it would be possible to directly connect to that known
>> network, which will appear as not hidden.
>>
>> Commit 06ca8e20a9b0 ("station: Hide forgotten hidden networks")

What does this line mean?


Kind regards,

Paul


>> ---
>> =C2=A0 src/network.c | 11 +++++++++++
>> =C2=A0 src/station.c |=C2=A0 2 ++
>> =C2=A0 2 files changed, 13 insertions(+)
>>
> =

> Applied, thanks.
> =

> Regards,
> -Denis
--===============0822617278063645995==--

