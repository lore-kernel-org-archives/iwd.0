Content-Type: multipart/mixed; boundary="===============8249647331404700907=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: DHCP renewal stops after disconnect
Date: Wed, 11 May 2022 12:32:35 -0500
Message-ID: <facd169d-1b0d-e1f2-7cb8-4e998593c69c@gmail.com>
In-Reply-To: CACsRnHUk-iYZHfHOkNyESzyoyOWCnw4ymD5nbyp6w-gXVEU9tQ@mail.gmail.com

--===============8249647331404700907==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,


> The lease should always be 2 hours if dhcpd is working correctly. The
> ones I've seen are always this value.
> =


Ok.

> For this one I did have DHCP debug on. You seem to be right, it looks
> like we didn't renew until we timed out completely.
> =


That would seem to confirm my hunch.  I just sent out a patch to the ell ma=
iling =

list and to you.  See if that one fixes this particular issue.

Regards,
-Denis
--===============8249647331404700907==--

