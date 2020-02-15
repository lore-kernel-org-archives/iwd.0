Content-Type: multipart/mixed; boundary="===============3277078167265601859=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 0/3] Update to ell's rntl API
Date: Sat, 15 Feb 2020 10:48:38 +0100
Message-ID: <20200215094841.28265-1-wagi@monom.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3277078167265601859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The rtnlutil code has been moved to ell, let's use it.

Daniel Wagner (3):
  netdev: Use ell's rtnl APIs
  netconfig: Use ell's rtnl API
  rtnlutil: Remove used rtnlutil

 Makefile.am     |   3 +-
 src/netconfig.c |  31 ++-
 src/netdev.c    |  22 +-
 src/rtnlutil.c  | 640 ------------------------------------------------
 src/rtnlutil.h  | 103 --------
 5 files changed, 28 insertions(+), 771 deletions(-)
 delete mode 100644 src/rtnlutil.c
 delete mode 100644 src/rtnlutil.h

-- =

2.25.0
--===============3277078167265601859==--

