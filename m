Content-Type: multipart/mixed; boundary="===============5217450131857679834=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 0/7] Radio Management Module
Date: Thu, 25 Jun 2020 11:56:38 -0700
Message-ID: <20200625185645.30122-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5217450131857679834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Version 2:
 - Renamed from 'offchannel'
 - Fixed potential problems in initial p2p patch. Added work ID tracking
   as well as setting ID to zero once completed since the ID is reused
   for multiple requests. If Andrew could verify everything looks ok that
   would be great.
 - Changed priority from enum to integer. This makes things much more
   flexible.
 - Removed the concept of suspended completely. This was to support scanning
   but with the addition of priorities we can actually insert ANQP entries
   before any pending scans, which avoids needing to suspend scanning.
 - Connection attempts are now treated as radio management work items. This
   in addition to the above changes allow us again to avoid suspending scans
   as well as waiting for ANQP to complete before connecting. Connections
   can be inserted after ANQP, but before scans which removes the need for
   the ANQP watch in station.


James Prestwood (7):
  radio_mgmt: introduce new radio management module
  wiphy: integrate radio management module
  frame-xchg: refactor to use radio management module
  anqp: refactor to use frame-xchg
  scan: refactor to use radio management module
  network: use radio management for connections
  station: remove ANQP watch

 Makefile.am      |   1 +
 src/anqp.c       | 443 ++++++++++-------------------------------------
 src/anqp.h       |   3 +-
 src/frame-xchg.c |  99 +++++------
 src/frame-xchg.h |   6 +-
 src/network.c    | 148 ++++++++--------
 src/p2p.c        |  22 ++-
 src/radio_mgmt.c | 240 +++++++++++++++++++++++++
 src/radio_mgmt.h |  48 +++++
 src/scan.c       | 104 ++++-------
 src/scan.h       |   3 -
 src/station.c    |  75 ++------
 src/station.h    |   5 -
 src/wiphy.c      |   5 +
 14 files changed, 575 insertions(+), 627 deletions(-)
 create mode 100644 src/radio_mgmt.c
 create mode 100644 src/radio_mgmt.h

-- =

2.21.1

--===============5217450131857679834==--

