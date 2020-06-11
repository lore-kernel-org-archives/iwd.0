Content-Type: multipart/mixed; boundary="===============6679242614356544405=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/4] Delay connect after ANQP (for release?)
Date: Thu, 11 Jun 2020 10:26:24 -0700
Message-ID: <20200611172628.31815-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6679242614356544405==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These were part of a larger set, but refactored to be stand alone.
Since these are fixing a recently discovered race condition we may
want them in the next release.

James Prestwood (4):
  station: add ANQP state watch API
  network: delay connect if ANQP has not completed
  auto-t: add 'Delay' property to hwsim python module
  auto-t: add test for delayed ANQP response

 autotests/testHotspot/anqp_delay_test.py | 85 ++++++++++++++++++++++++
 autotests/util/hwsim.py                  |  8 +++
 src/network.c                            | 58 ++++++++++++++++
 src/station.c                            | 21 ++++++
 src/station.h                            | 13 ++++
 5 files changed, 185 insertions(+)
 create mode 100644 autotests/testHotspot/anqp_delay_test.py

-- =

2.21.1

--===============6679242614356544405==--

