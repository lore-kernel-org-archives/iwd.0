Content-Type: multipart/mixed; boundary="===============5067098774891233458=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 00/13] Combined test-runner fixes
Date: Mon, 28 Mar 2022 10:28:29 -0700
Message-ID: <20220328172842.1660272-1-prestwoj@gmail.com>

--===============5067098774891233458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This combines the individual test fixes with the memory fixes

James Prestwood (13):
  test-runner: add memory usage for debugging
  test-runner: fix OOM issues (hopefully)
  auto-t: remove waitstatus_to_exitcode for better compatibility
  auto-t: iwd.py: fix full_scan argument
  auto-t: fixup testRoamRetry for better timing reliability
  auto-t: use wait_for_event in testBSSBlacklist
  auto-t: use wait_for_event in testSAE-roam
  auto-t: do full scan for testSAE
  auto-t: use wait_for_event in testPSK-roam
  auto-t: do a full scan when getting network
  dpp: fail if disconnected during DPP protocol
  dpp: set new_freq when configuring as initiator
  auto-t: don't wait for wpa_supplicant to connect

 autotests/testBSSBlacklist/connection_test.py | 18 ++--
 autotests/testDPP/connection_test.py          |  5 +-
 autotests/testNetconfig/connection_test.py    |  5 +-
 .../testOWE-transition/connection_test.py     | 13 +--
 autotests/testPSK-roam/connection_test.py     | 29 +-----
 autotests/testRoamRetry/fast_retry_test.py    | 13 ++-
 autotests/testRoamRetry/stop_retry_test.py    |  7 +-
 autotests/testSAE-roam/connection_test.py     | 11 ++-
 autotests/testSAE/connection_test.py          | 14 +--
 autotests/util/iwd.py                         | 23 ++---
 src/dpp.c                                     | 15 +++-
 tools/test-runner                             | 89 +++++++++++++++++--
 12 files changed, 142 insertions(+), 100 deletions(-)

-- =

2.34.1

--===============5067098774891233458==--

