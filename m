Content-Type: multipart/mixed; boundary="===============6929099832098133919=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 00/15] Test Runner rewrite
Date: Fri, 28 Aug 2020 11:47:24 -0700
Message-ID: <20200828184739.8616-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6929099832098133919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

*-v3:
 * Fixed rebase issue

James Prestwood (15):
  auto-t: prepare autotests for test-runner re-write
  auto-t: introduce pure python test-runner re-write
  auto-t: hostapd.py: update to work with test-runner rewrite
  auto-t: testutil.py: update to work with test-runner rewrite
  auto-t: ofono.py: fix timeout cleanup and wait for service
  auto-t: iwd.py: update to work with test-runner rewrite
  auto-t: iwd.py: fix multiple timeout cleanup issues
  auto-t: remove wiphy.py
  auto-t: fix hidden network test
  auto-t: fix testSAE autoconnect_test.py
  auto-t: skip ofono tests if ofonod isn't running
  auto-t: replace hard-coded interfaces
  auto-t: remove device.wait_for_connected
  tools: post test-runner rewrite cleanup
  doc: update test runner docs

 .gitignore                                    |    1 -
 Makefile.am                                   |    7 -
 .../{test.py =3D> connection_test.py}           |    0
 .../testAP/{test.py =3D> connection_test.py}    |    9 +-
 autotests/testAP/failure_test.py              |    6 +-
 autotests/testAPRoam/connection_test.py       |    2 -
 .../testBSSBlacklist/all_blacklisted_test.py  |    4 -
 autotests/testBSSBlacklist/bad_pass_test.py   |    4 -
 autotests/testBSSBlacklist/connection_test.py |    1 -
 .../testBSSBlacklist/temp_blacklist_test.py   |    4 -
 .../connect_command_test.py                   |   42 +-
 .../disconnect_by_ap_test.py                  |    4 +-
 .../testEAP-AKA-ofono/connection_test.py      |    4 +
 .../connection_test.py                        |    4 +
 autotests/testEAP-AKA/connection_test.py      |    1 -
 .../testEAP-PEAPv0-CryptoBinding/ISK_test.py  |    1 -
 .../NoISK_test.py                             |    1 -
 .../testEAP-PEAPv0-CryptoBinding/main.conf    |    2 -
 autotests/testEAP-PWD/connection_test.py      |    1 -
 .../testEAP-SIM-ofono/connection_test.py      |    4 +
 autotests/testEAP-SIM/connection_test.py      |    1 -
 .../connection_test.py                        |   11 +-
 .../testEAP-TTLS-CHAP/connection_test.py      |    1 -
 .../testEAP-TTLS-MSCHAP/connection_test.py    |    1 -
 autotests/testEAP-TTLS-PAP/connection_test.py |    1 -
 autotests/testEAP-WPS-Frag/wps_frag_test.py   |    4 +-
 autotests/testEAP-WPS/four_digit_pin_test.py  |    4 +-
 autotests/testEAP-WPS/pin_test.py             |    4 +-
 autotests/testEAP-WPS/push_button_test.py     |    5 +-
 autotests/testFILS/fils_256_test.py           |    1 -
 autotests/testFILS/fils_384_test.py           |    1 -
 .../{test.py =3D> connection_test.py}           |    2 +-
 .../{test.py =3D> connection_test.py}           |    2 +-
 .../{test.py =3D> connection_test.py}           |    2 +-
 .../{test.py =3D> connection_test.py}           |    2 +-
 .../{test.py =3D> connection_test.py}           |   18 +-
 .../{test.py =3D> connection_test.py}           |    2 +-
 .../{test.py =3D> connection_test.py}           |    2 +-
 autotests/testHiddenNetworks/validation.py    |    8 +-
 autotests/testOWE/connection_test.py          |    1 -
 autotests/testOWE/renegotiate_test.py         |    1 -
 .../{test.py =3D> connection_test.py}           |    2 +-
 .../testPreauth-roam/eaptls-preauth-1.conf    |    3 +-
 .../testPreauth-roam/eaptls-preauth-2.conf    |    3 +-
 .../{test.py =3D> connection_test.py}           |    0
 autotests/testSAE/autoconnect_test.py         |   15 +-
 autotests/testSAE/clogging_test.py            |    3 +-
 autotests/testSAE/connection_test.py          |   10 +-
 autotests/testSAE/group_20_connection_test.py |   10 +-
 .../testSAQuery-spoofing/connection_test.py   |    2 +-
 autotests/testSAQuery/connection_test.py      |    2 +-
 autotests/util/config.py                      |    6 +
 autotests/util/hostapd.py                     |   57 +-
 autotests/util/iwd.py                         |  124 +-
 autotests/util/ofono.py                       |   25 +-
 autotests/util/testutil.py                    |    7 +-
 autotests/util/wiphy.py                       |   32 -
 doc/test-runner.txt                           |  117 +-
 tools/test-runner                             | 1246 +++++++++++++++++
 59 files changed, 1456 insertions(+), 384 deletions(-)
 rename autotests/testAP-no-support/{test.py =3D> connection_test.py} (100%)
 rename autotests/testAP/{test.py =3D> connection_test.py} (94%)
 delete mode 100644 autotests/testEAP-PEAPv0-CryptoBinding/main.conf
 rename autotests/testFT-8021x-roam/{test.py =3D> connection_test.py} (99%)
 rename autotests/testFT-FILS-SHA256/{test.py =3D> connection_test.py} (99%)
 rename autotests/testFT-FILS-SHA384/{test.py =3D> connection_test.py} (99%)
 rename autotests/testFT-PSK-over-DS/{test.py =3D> connection_test.py} (99%)
 rename autotests/testFT-PSK-roam/{test.py =3D> connection_test.py} (95%)
 rename autotests/testFT-SAE-roam/{test.py =3D> connection_test.py} (99%)
 rename autotests/testHT-VHT/{test.py =3D> connection_test.py} (98%)
 rename autotests/testPreauth-roam/{test.py =3D> connection_test.py} (98%)
 rename autotests/testRSSIAgent/{test.py =3D> connection_test.py} (100%)
 create mode 100644 autotests/util/config.py
 delete mode 100644 autotests/util/wiphy.py
 create mode 100755 tools/test-runner

-- =

2.21.1

--===============6929099832098133919==--

