Content-Type: multipart/mixed; boundary="===============4063456891705713326=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 3/4] agent: enforce a maximum passphrase length
Date: Fri, 06 Mar 2020 10:59:48 -0800
Message-ID: <b3e845b8da92c5124a545fbe7f66f878f3587a19.camel@gmail.com>
In-Reply-To: <6849889b-89b2-90fb-09f0-0914083d546b@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4063456891705713326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-06 at 12:43 -0600, Denis Kenzior wrote:
> Hi James,
> =

> > > This callback is used for three things from what I remember:
> > > 	1. The passphrase for decrypting private keys
> > > 	2. The passphrase for PSK networks.
> > > 	3. The password for EAP methods.
> > > =

> > > This checking should only apply to 3, no?
> > =

> > Well, we should probably have a maximum on all three... The private
> > key
> > passphrase is sent to the kernel, so we probably don't want that to
> > be
> > huge seems like we could put the same limitation on both 1 and 3.
> > In
> > addition for PSK passphrases we should probably enforce 8-63 byte
> > lengths if we don't already somewhere else.
> > =

> =

> I'd be fine with that, but then using a #define with the name
> PASSWORD =

> starts looking a bit funny.
> =

> Do note that the 8..63 limit for 2) is already enforced by =

> crypto_psk_from_passphrase.

Indeed. So I'll leave the WPA passphrase path alone. Instead I can move
these checks into network.c, specific to pkeys and EAP passwords.
Either put checks in eap_secret_done, or in eap_password_callback and
eap_user_password_callback.

Thanks,
James


> Regards,
> -Denis
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org

--===============4063456891705713326==--

