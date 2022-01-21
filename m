Content-Type: multipart/mixed; boundary="===============7069905570511003800=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [RFC 0/2] Encrypt secrets using systemd provided key
Date: Fri, 21 Jan 2022 14:30:44 -0800
Message-ID: <ee74931c2e0f54601f0b83e802e8969731405329.camel@gmail.com>
In-Reply-To: 1669386.7lEct51Sfr@prancing-pony

--===============7069905570511003800==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Diederik,

On Fri, 2022-01-21 at 23:22 +0100, Diederik de Haas wrote:
> On vrijdag 21 januari 2022 01:41:28 CET James Prestwood wrote:
> > There has been interest in enabling IWD users to store their
> > network
> > credentials in some encrypted form.
> =

> I did/do wonder why my passphrase is stored in plain-text and not in
> a form =

> which I can get through the wpa_passphrase* utility (I don't know the
> proper =

> term for it though). Maybe that's what others have been interested in
> too?

I was unfamiliar with wpa_passphrase until now, but all that appears to
be doing is deriving a PSK from the SSID/passphrase, not 'encrypted' by
any means. In IWD this is "PreSharedKey" in the profile. Ultimately
(for WPA2) you only need the PSK to connect to a network so storing the
PSK directly is just as insecure as the passphrase.

What I am proposing actually encrypts the passphrase/PSK using a secret
key, only known to the IWD systemd service.

> =

> That appears to be a far simpler solution and also wouldn't have the =

> 'transportation' issue Marcel indicated (IIUC).
> =

> Regards,
> =C2=A0 Diederik
> =

> *) having such a utility as part of iwd seems beneficial, otherwise
> I'd still =

> need to install wpasupplicant package (on Debian) to have such a
> utility.
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============7069905570511003800==--

