Content-Type: multipart/mixed; boundary="===============4414181755184595980=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 0/6] AdHoc fixes
Date: Mon, 14 Sep 2020 14:04:01 -0700
Message-ID: <20200914210407.428918-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4414181755184595980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These should make AdHoc pass very reliably now. There is still
the problem of the failure test. Its not really testing anything
at this point since there is no way of knowing if EAPoL was
successful or not via DBus.

James Prestwood (6):
  adhoc: start both eapol SM's
  adhoc: print handshake failure reason
  adhoc: delay setting setting Started
  auto-t: make AdHoc APIs behave like others
  auto-t: update AdHoc tests to use AdHocDevice
  auto-t: remove old AdHoc APIs

 autotests/testAdHoc/adhoc_test.py | 18 ++++++--
 autotests/testAdHoc/open_test.py  | 19 ++++++---
 autotests/util/iwd.py             | 71 +++++++------------------------
 src/adhoc.c                       | 51 ++++++++++++++++++++--
 4 files changed, 92 insertions(+), 67 deletions(-)

-- =

2.26.2

--===============4414181755184595980==--

