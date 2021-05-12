Content-Type: multipart/mixed; boundary="===============5347855944136726715=="
MIME-Version: 1.0
From: keruspe+ml01@gmail.com
Subject: Consider supporting building with clang
Date: Wed, 12 May 2021 11:47:20 +0000
Message-ID: <20210512114720.2812.33927@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5347855944136726715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Since the introduction of the _auto_ destructor macros, ell and iwd generat=
e nested functions, which are a gnu extension not supported by clang.

While adding support for that in clang would also benefit other projects, I=
 don't think this idea is going anywhere as it has been brought up numerous=
 times in the past and never went forward.

The way e.g. glib deals with it is by splitting this in two, first define t=
he destructor function alonside the struct it is going to destruct, then ho=
ok it up with a macro like _auto_ here, this way no nested functions are ne=
eded. Would this make sense for ell/iwd too? I can provide patches if requi=
red.
--===============5347855944136726715==--

