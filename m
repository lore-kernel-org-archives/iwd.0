Content-Type: multipart/mixed; boundary="===============3342432334661157028=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: Doesn't create global config file or its directory (/etc/iwd/)
Date: Mon, 27 Dec 2021 19:23:44 +0100
Message-ID: <35676143.AJtQQQMBzY@bagend>

--===============3342432334661157028==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I recently filed a Debian Bug against iwd and this is a forward for it:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1002575

"I needed the "EnableNetworkConfiguration=3Dtrue" setting, which IIUC
should be done in /etc/iwd/main.conf, but I noticed that that file
and directory didn't exist. I resolved it by using mkdir and creating
the file with vim (as root) and I'm assuming/hoping things like
permissions are set correctly. But I did wonder whether I was doing it
incorrectly (and I may have, but it's working)."

The Debian maintainer informed me that there isn't such a config file in th=
e =

upstream source code and I think it would be helpful if the directory with =
the =

correct permissions and the config file, which could f.e. only contain a =

commented reference to the iwd.config man page, would be created OOTB.

Cheers,
  Diederik

--===============3342432334661157028==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlIVUVBQllJQUIwV0lRVDFzVVBCWXN5R21p
NHVzeS9YYmx2T2VIN2JiZ1VDWWNvRXNBQUtDUkRYYmx2T2VIN2IKYnE4L0FQOUsrN0VTRGdoMzQ5
MHlOcVc2eGVZMVpvZ204Y09GZnpxdmx4YTNHemY2ZVFFQWdIWDQwZXd2MzAvRQpzbTd2UVQrdEtS
U083ZWRqbEljcHN2UTFjSVppYkFvPQo9aGpucAotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============3342432334661157028==--

