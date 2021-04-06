Content-Type: multipart/mixed; boundary="===============1260486066174720393=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Build broken with --enable-external-ell since version 1.13
Date: Tue, 06 Apr 2021 10:38:06 +0200
Message-ID: <5DEE74C2-EAE0-4E84-B993-12B92DFE3598@holtmann.org>
In-Reply-To: <CAPi7W80quBbG-Vimp_tMOSJqVXtz=bwRZ6i8ksnFDuRrY37T9g@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1260486066174720393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fabrice,

> Build is broken with --enable-external-ell since version 1.13 and commit
> ed05585063f2e6d8f2fcd5f008b861062ac7a429:
> =

> make[1]: Entering directory '/home/fabrice/buildroot/output/build/iwd-1.1=
3'
>  GEN      ell/shared
> /bin/bash: line 5: ell/shared: No such file or directory
> =

> Moreover, ell/useful.h is a private header of ELL so it shouldn't be
> used by iwd.

yes, it should be used. That is the intention for this header.

Regards

Marcel

--===============1260486066174720393==--

