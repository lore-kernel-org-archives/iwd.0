Content-Type: multipart/mixed; boundary="===============0771784536775014047=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: Re: iwd 1.23 crashes in eapol_handle_pkt_1_of_4()
Date: Wed, 02 Feb 2022 14:04:58 +0100
Message-ID: <2150796.4kSMX4sLTf@bagend>
In-Reply-To: 87fsp1cw2j.fsf@toke.dk

--===============0771784536775014047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 2 February 2022 13:05:56 CET Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Since updating to iwd 1.23 (from Arch packages), I've started seeing
> periodic crashes. =

> =

> Does anyone have any ideas? :)

According to https://bugs.debian.org/1004607, iwd 1.23 needs a newer versio=
n =

of ELL (version 0.48), so maybe you need to upgrade ELL too?

--===============0771784536775014047==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlIVUVBQllJQUIwV0lRVDFzVVBCWXN5R21p
NHVzeS9YYmx2T2VIN2JiZ1VDWWZxQmVnQUtDUkRYYmx2T2VIN2IKYnQrdkFQNGdUV1o3T1FFZlho
eTdPaVpkenFneWpQWDVsY1BKaHRXeUxadCtxUEpDaXdEK0xabENqbEd3T0c5UApSbmhPVjY3Nklk
cSs1TDRLQ1dtc0dVd3gwMGtlQXdBPQo9TUYxcgotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============0771784536775014047==--

