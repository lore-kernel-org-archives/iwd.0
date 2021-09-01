Content-Type: multipart/mixed; boundary="===============1435053494794168884=="
MIME-Version: 1.0
From: Jesus Gonzalez <jesusmgh@gmail.com>
Subject: Re: Cannot connect to SAE protected AP with iwd 1.16 and beyond
Date: Wed, 01 Sep 2021 13:09:52 +0000
Message-ID: <20210901130952.2717.97994@ml01.vlan13.01.org>
In-Reply-To: <3d7b55d0-c0ad-f347-4764-bea6b9afae84@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1435053494794168884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

the breaking commit is not in iwd, but ell. This one:

https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3D05f4de9663950b=
cd4519ebec8d8c0998dc889936

I tested with no NetworkManager and no relevant .psk file in /var/lib/iwd. =
If you still need logs, please let me know.

I saw that you were the contributor of that patch, but stlll, if I need to =
file a bug somewhere else, please let me know.

Kind regards,
Jesus
--===============1435053494794168884==--

