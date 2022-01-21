Content-Type: multipart/mixed; boundary="===============8283880180609672913=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: Re: [RFC 0/2] Encrypt secrets using systemd provided key
Date: Fri, 21 Jan 2022 23:22:25 +0100
Message-ID: <1669386.7lEct51Sfr@prancing-pony>
In-Reply-To: 20220121004130.2473281-1-prestwoj@gmail.com

--===============8283880180609672913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On vrijdag 21 januari 2022 01:41:28 CET James Prestwood wrote:
> There has been interest in enabling IWD users to store their network
> credentials in some encrypted form.

I did/do wonder why my passphrase is stored in plain-text and not in a form =

which I can get through the wpa_passphrase* utility (I don't know the prope=
r =

term for it though). Maybe that's what others have been interested in too?

That appears to be a far simpler solution and also wouldn't have the =

'transportation' issue Marcel indicated (IIUC).

Regards,
  Diederik

*) having such a utility as part of iwd seems beneficial, otherwise I'd sti=
ll =

need to install wpasupplicant package (on Debian) to have such a utility.

--===============8283880180609672913==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlIVUVBQllJQUIwV0lRVDFzVVBCWXN5R21p
NHVzeS9YYmx2T2VIN2JiZ1VDWWVzeUlRQUtDUkRYYmx2T2VIN2IKYnVjWUFRRHBXTjNONW1Cbkp0
K3EzWGZZVGR1V0RVUk1FN3dBVzYwY2ZnR1M0aG1jT3dEL1d5WS9kaWtyVDJIVgpTUVNFQ1Y2NjFD
SHZYVkoxb3dudGtkZmJ6YkRHdncwPQo9ZmFzdAotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============8283880180609672913==--

