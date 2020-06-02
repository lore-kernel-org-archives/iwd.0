Content-Type: multipart/mixed; boundary="===============6605891792591507883=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 00/10] ANQP Refactor to use frame-xchg
Date: Tue, 02 Jun 2020 10:30:11 -0700
Message-ID: <20200602173021.20085-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6605891792591507883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have included two of Andrews patches fixing the group zero bug
as well.

Andrew Zaborowski (2):
  frame-xchg: Fix frame_watch_remove_by_handler for group 0
  frame-xchg: Use frame_watch_group_match in frame_watch_group_get

James Prestwood (8):
  frame-xchg: fix bug when starting new xchg from callback
  anqp: refactor to use frame-xchg
  station: add ANQP state watch API
  network: delay connect if ANQP has not completed
  hwsim: add new 'Delay' property to Rules
  doc: document new 'Delay' property for hwsim Rules
  auto-t: add 'Delay' property to hwsim python module
  auto-t: add test for delayed ANQP response

 autotests/testHotspot/anqp_delay_test.py |  83 +++++
 autotests/util/hwsim.py                  |   8 +
 doc/hwsim-rules-api.txt                  |   5 +
 src/anqp.c                               | 449 +++++++----------------
 src/anqp.h                               |   3 +-
 src/frame-xchg.c                         |  62 ++--
 src/network.c                            |  58 +++
 src/station.c                            |  45 ++-
 src/station.h                            |  13 +
 tools/hwsim.c                            |  53 ++-
 10 files changed, 414 insertions(+), 365 deletions(-)
 create mode 100644 autotests/testHotspot/anqp_delay_test.py

-- =

2.21.1

--===============6605891792591507883==--

