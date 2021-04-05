Content-Type: multipart/mixed; boundary="===============6066672407007817566=="
MIME-Version: 1.0
From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: Build broken with --enable-external-ell since version 1.13
Date: Mon, 05 Apr 2021 15:00:39 +0200
Message-ID: <CAPi7W80quBbG-Vimp_tMOSJqVXtz=bwRZ6i8ksnFDuRrY37T9g@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6066672407007817566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Dear all,

Build is broken with --enable-external-ell since version 1.13 and commit
ed05585063f2e6d8f2fcd5f008b861062ac7a429:

make[1]: Entering directory '/home/fabrice/buildroot/output/build/iwd-1.13'
  GEN      ell/shared
/bin/bash: line 5: ell/shared: No such file or directory

Moreover, ell/useful.h is a private header of ELL so it shouldn't be
used by iwd.

Best Regards,

Fabrice
--===============6066672407007817566==--

