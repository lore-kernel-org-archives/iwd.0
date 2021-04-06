Content-Type: multipart/mixed; boundary="===============8474961474728157891=="
MIME-Version: 1.0
From: Peter Seiderer <ps.report@gmx.net>
Subject: Question about iwd commit 'build: Always link in the ell/useful.h
 header file'
Date: Tue, 06 Apr 2021 20:49:23 +0200
Message-ID: <20210406204923.436697f6@gmx.net>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8474961474728157891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

one question about the iwd commit 'build: Always link in the ell/useful.h h=
eader
file' ([1]) which links in one header from ell (useful.h) into the iwd sour=
ces:

- this one breaks the build of iwd from git and the usage of external ell (=
and
  from a packager point of view even a header only part of an library/packa=
ge
  belongs to this library/package and download/versioning/copyright and the
  commit break this assumption)

- for full/better support of external ell adding ell/useful.h to the ell
  pkginclude_HEADERS file list would be better...

Regards,
Peter

[1] https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=3Ded=
05585063f2e6d8f2fcd5f008b861062ac7a429
--===============8474961474728157891==--

