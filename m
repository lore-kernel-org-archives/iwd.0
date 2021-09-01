Content-Type: multipart/mixed; boundary="===============3665031449196782168=="
MIME-Version: 1.0
From: Jesus Gonzalez <jesusmgh@gmail.com>
Subject: Re: Cannot connect to SAE protected AP with iwd 1.16 and beyond
Date: Wed, 01 Sep 2021 13:05:09 +0000
Message-ID: <20210901130509.2717.77576@ml01.vlan13.01.org>
In-Reply-To: <36a705db-b6c8-c1b0-abba-a15b170fc694@molgen.mpg.de>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3665031449196782168==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Paul,

I took the time and found the culprit: it wasn't iwd, but ell, and this com=
mit to be precise:

https://git.kernel.org/pub/scm/libs/ell/ell.git/commit/?id=3D05f4de9663950b=
cd4519ebec8d8c0998dc889936

After bisecting around iwd, including a breaking change within ell, and fin=
ding ell to be the problem, I started bisecting ell itself. The result is, =
iwd tag 1.16 (and the non-broken commits before that) all work fine with el=
l right before that commit.

I hope this helps.

Kind regards,
Jesus
--===============3665031449196782168==--

