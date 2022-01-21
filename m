Content-Type: multipart/mixed; boundary="===============2934682730457178801=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: Re: [RFC 0/2] Encrypt secrets using systemd provided key
Date: Sat, 22 Jan 2022 00:46:23 +0100
Message-ID: <5088724.FFhpVOcMN3@prancing-pony>
In-Reply-To: ee74931c2e0f54601f0b83e802e8969731405329.camel@gmail.com

--===============2934682730457178801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On vrijdag 21 januari 2022 23:30:44 CET James Prestwood wrote:
> > I did/do wonder why my passphrase is stored in plain-text and not in
> > a form which I can get through the wpa_passphrase* utility (I don't know
> > the proper term for it though). Maybe that's what others have been
> > interested in too?
> =

> I was unfamiliar with wpa_passphrase until now, but all that appears to
> be doing is deriving a PSK from the SSID/passphrase, not 'encrypted' by
> any means. In IWD this is "PreSharedKey" in the profile. Ultimately
> (for WPA2) you only need the PSK to connect to a network so storing the
> PSK directly is just as insecure as the passphrase.

I followed https://wiki.debian.org/WiFi/HowToUse#WPA-PSK_and_WPA2-PSK and t=
hen =

removed the commented out line (thus the plain-text passphrase)
I _think_ it was way more prominent and recommended on that page when I fir=
st =

read it, quite some years ago.

I knew it wasn't (actually) encrypted, but assumed it to be a (one-way) has=
h.
I know you can connect to the (WPA2) network with just the PSK, so it won't =

prevent connecting to it, if that value is known.
If I wanted to allow a friend access to the same wireless network, I could =

give the PSK, without revealing my actual passphrase, which _feels_ more =

secure. (Which may be a false sense of security, which is actually worse)

> What I am proposing actually encrypts the passphrase/PSK using a secret
> key, only known to the IWD systemd service.

My reasoning was that if the request/interest came from people equally =

'clueless' as I am, then not seeing the plain-text passphrase, but only the =

'hash'/PSK, is what they were actually asking.

If it was from knowledgeable people, then yes, actual encryption is very =

likely what they were after.

HTH,
  Diederik

--===============2934682730457178801==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlIVUVBQllJQUIwV0lRVDFzVVBCWXN5R21p
NHVzeS9YYmx2T2VIN2JiZ1VDWWV0Rnp3QUtDUkRYYmx2T2VIN2IKYnBITUFQNGlwbElZOE1WQ0w2
Tk1QRXk0M1E1aFM1bnVsYmxHZWEwT3NES1hXMVMxelFEK1B1YThXWWlqZHZadwpBVW5ZLytld2hV
NTJYdTUvZmUyRWduTE1iRlkybUFJPQo9dXNGQQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============2934682730457178801==--

