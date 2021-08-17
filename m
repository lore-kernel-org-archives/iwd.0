Content-Type: multipart/mixed; boundary="===============6570717665434101103=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/5] auto-t: remove duplicate EAP tests
Date: Tue, 17 Aug 2021 09:45:00 -0700
Message-ID: <20210817164501.195027-4-prestwoj@gmail.com>
In-Reply-To: <20210817164501.195027-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6570717665434101103==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This removes any EAP test which was combined into testEAP as well
as modifies any special EAP test to use the now global eap-users
file.
---
 autotests/misc/certs/eap-user-tls.text        |  4 -
 .../misc/certs/eap-user-ttls-mschapv2.text    |  4 -
 autotests/misc/certs/eap-user-ttls.text       |  4 -
 autotests/misc/secrets/eap-user-mschapv2.text |  1 -
 .../misc/secrets/eap-user-peap-mschapv2.text  |  4 -
 autotests/misc/secrets/eap-user-peap-sim.text |  4 -
 .../secrets/eap-user-peap-v0-mschapv2.text    |  4 -
 autotests/misc/secrets/eap-user-peap-v0.text  |  4 -
 autotests/misc/secrets/eap-user-peap-v1.text  |  4 -
 .../testConnectAutoconnect/ssidEAP-Other.conf |  2 +-
 .../testConnectAutoconnect/ssidEAP-TLS.8021x  |  2 +-
 .../testConnectAutoconnect/ssidEAP-TLS.conf   |  2 +-
 autotests/testEAD/default.8021x               |  2 +-
 autotests/testEAD/wired.conf                  |  2 +-
 .../testEAP-AKA-ofono/connection_test.py      | 59 ------------
 autotests/testEAP-AKA-ofono/hw.conf           |  6 --
 autotests/testEAP-AKA-ofono/sim.db            |  3 -
 autotests/testEAP-AKA-ofono/sim.eap_user      |  1 -
 autotests/testEAP-AKA-ofono/ssidEAP-AKA.8021x |  5 -
 autotests/testEAP-AKA-ofono/ssidEAP-AKA.conf  | 16 ----
 .../connection_test.py                        | 58 ------------
 autotests/testEAP-AKA-prime-ofono/hw.conf     |  6 --
 autotests/testEAP-AKA-prime-ofono/sim.db      |  3 -
 .../testEAP-AKA-prime-ofono/sim.eap_user      |  1 -
 .../testEAP-AKA-prime-ofono/ssidEAP-AKA.8021x |  5 -
 .../testEAP-AKA-prime-ofono/ssidEAP-AKA.conf  | 16 ----
 autotests/testEAP-MSCHAPV2/connection_test.py | 76 ---------------
 autotests/testEAP-MSCHAPV2/hw.conf            |  5 -
 .../testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-1.8021x |  7 --
 .../testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-2.8021x |  7 --
 .../testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-3.8021x |  6 --
 .../testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-4.8021x |  5 -
 .../testEAP-MSCHAPV2/ssidEAP-MSCHAPV2.conf    |  9 --
 .../testEAP-PEAP-GTC/eap-user-peap-gtc.text   |  4 -
 autotests/testEAP-PEAP-GTC/hw.conf            |  7 --
 .../peap_gtc_nosecret_test.py                 | 59 ------------
 autotests/testEAP-PEAP-GTC/peap_gtc_test.py   | 51 ----------
 .../ssidEAP-PEAPv1-GTC-nosecret.8021x         | 11 ---
 .../ssidEAP-PEAPv1-GTC-nosecret.conf          | 12 ---
 .../testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC.8021x | 12 ---
 .../testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC.conf  | 12 ---
 .../testEAP-PEAP-MSCHAPv2/connection_test.py  | 52 ----------
 autotests/testEAP-PEAP-MSCHAPv2/hw.conf       |  6 --
 .../ssidEAP-PEAP-MSCHAPv2.8021x               | 12 ---
 .../ssidEAP-PEAP-MSCHAPv2.conf                | 12 ---
 autotests/testEAP-PEAP-SIM/connection_test.py | 65 -------------
 autotests/testEAP-PEAP-SIM/hw.conf            |  7 --
 autotests/testEAP-PEAP-SIM/sim.db             |  1 -
 autotests/testEAP-PEAP-SIM/sim.eap_user       |  1 -
 .../testEAP-PEAP-SIM/ssidEAP-PEAP-SIM.8021x   | 10 --
 .../testEAP-PEAP-SIM/ssidEAP-PEAP-SIM.conf    | 15 ---
 autotests/testEAP-PEAP/IWD-Frag/main.conf     |  2 -
 autotests/testEAP-PEAP/hw.conf                |  8 --
 autotests/testEAP-PEAP/peap_frag_test.py      | 50 ----------
 autotests/testEAP-PEAP/peap_v0_test.py        | 50 ----------
 autotests/testEAP-PEAP/peap_v1_test.py        | 50 ----------
 .../testEAP-PEAP/ssidEAP-PEAP-frag.8021x      | 12 ---
 autotests/testEAP-PEAP/ssidEAP-PEAP-frag.conf | 14 ---
 autotests/testEAP-PEAP/ssidEAP-PEAPv0.8021x   | 12 ---
 autotests/testEAP-PEAP/ssidEAP-PEAPv0.conf    | 12 ---
 autotests/testEAP-PEAP/ssidEAP-PEAPv1.8021x   | 12 ---
 autotests/testEAP-PEAP/ssidEAP-PEAPv1.conf    | 12 ---
 .../ssidEAP-PEAPv0-ISK.8021x                  |  6 +-
 .../ssidEAP-PEAPv0-ISK.conf                   |  2 +-
 .../ssidEAP-PEAPv0-NoISK.8021x                |  6 +-
 .../ssidEAP-PEAPv0-NoISK.conf                 |  2 +-
 autotests/testEAP-PWD/IWD-Frag/main.conf      |  2 -
 autotests/testEAP-PWD/connection_test.py      | 70 --------------
 autotests/testEAP-PWD/frag_test.py            | 49 ----------
 autotests/testEAP-PWD/hw.conf                 |  7 --
 autotests/testEAP-PWD/pwd.eap_user            |  1 -
 autotests/testEAP-PWD/ssidEAP-PWD-frag.8021x  |  7 --
 autotests/testEAP-PWD/ssidEAP-PWD-frag.conf   | 16 ----
 autotests/testEAP-PWD/ssidEAP-PWD.8021x       |  6 --
 autotests/testEAP-PWD/ssidEAP-PWD.conf        | 15 ---
 .../testEAP-SIM-ofono/connection_test.py      | 60 ------------
 autotests/testEAP-SIM-ofono/hw.conf           |  6 --
 autotests/testEAP-SIM-ofono/sim.db            |  1 -
 autotests/testEAP-SIM-ofono/sim.eap_user      |  1 -
 autotests/testEAP-SIM-ofono/ssidEAP-SIM.8021x |  5 -
 autotests/testEAP-SIM-ofono/ssidEAP-SIM.conf  | 16 ----
 autotests/testEAP-TLS-Frag/ssidEAP-TLS.8021x  |  2 +-
 autotests/testEAP-TLS-Frag/ssidEAP-TLS.conf   |  2 +-
 .../connection_test.py                        | 62 ------------
 autotests/testEAP-TLS-embedded-pems/hw.conf   |  5 -
 .../ssidEAP-TLS.8021x                         | 94 -------------------
 .../ssidEAP-TLS.conf                          | 12 ---
 autotests/testEAP-TLS/connection_test.py      | 74 ---------------
 autotests/testEAP-TLS/hw.conf                 |  8 --
 autotests/testEAP-TLS/ssidEAP-TLS.8021x       |  9 --
 autotests/testEAP-TLS/ssidEAP-TLS.conf        | 13 ---
 autotests/testEAP-TLS/ssidEAP-TLS2.8021x      | 10 --
 autotests/testEAP-TLS/ssidEAP-TLS2.conf       | 13 ---
 autotests/testEAP-TLS/ssidEAP-TLS3.8021x      |  9 --
 autotests/testEAP-TLS/ssidEAP-TLS3.conf       | 13 ---
 autotests/testEAP-TLS/ssidEAP-TLS4.8021x      |  9 --
 autotests/testEAP-TLS/ssidEAP-TLS4.conf       | 13 ---
 .../testEAP-TLSwithMFPC/ssidEAP-TLS.8021x     |  2 +-
 .../testEAP-TLSwithMFPC/ssidEAP-TLS.conf      |  2 +-
 .../testEAP-TLSwithMFPR/ssidEAP-TLS.8021x     |  2 +-
 .../testEAP-TLSwithMFPR/ssidEAP-TLS.conf      |  2 +-
 .../testEAP-TTLS-CHAP/connection_test.py      | 68 --------------
 .../testEAP-TTLS-CHAP/eap-user-ttls-chap.text |  4 -
 autotests/testEAP-TTLS-CHAP/hw.conf           |  5 -
 .../testEAP-TTLS-CHAP/ssidEAP-TTLS-CHAP.8021x | 12 ---
 .../testEAP-TTLS-CHAP/ssidEAP-TTLS-CHAP.conf  | 12 ---
 .../connection_test.py                        | 55 -----------
 autotests/testEAP-TTLS-EAP-MSCHAPV2/hw.conf   |  5 -
 .../ssidEAP-TTLS.8021x                        |  8 --
 .../ssidEAP-TTLS.conf                         | 12 ---
 .../testEAP-TTLS-Frag/ssidEAP-TTLS.8021x      |  6 +-
 autotests/testEAP-TTLS-Frag/ssidEAP-TTLS.conf |  2 +-
 .../testEAP-TTLS-MSCHAP/connection_test.py    | 68 --------------
 .../eap-user-ttls-mschap.text                 |  4 -
 autotests/testEAP-TTLS-MSCHAP/hw.conf         |  5 -
 .../ssidEAP-TTLS-MSCHAP.8021x                 | 12 ---
 .../ssidEAP-TTLS-MSCHAP.conf                  | 12 ---
 .../testEAP-TTLS-MSCHAPv2/connection_test.py  | 72 --------------
 .../eap-user-ttls-mschapv2.text               |  4 -
 .../testEAP-TTLS-MSCHAPv2/failure_test.py     | 57 -----------
 autotests/testEAP-TTLS-MSCHAPv2/hw.conf       |  6 --
 .../ssidEAP-TTLS-MSCHAPv2.8021x               | 12 ---
 .../ssidEAP-TTLS-MSCHAPv2.conf                | 12 ---
 autotests/testEAP-TTLS-PAP/connection_test.py | 68 --------------
 .../testEAP-TTLS-PAP/eap-user-ttls-pap.text   |  4 -
 autotests/testEAP-TTLS-PAP/hw.conf            |  5 -
 .../testEAP-TTLS-PAP/ssidEAP-TTLS-PAP.8021x   | 12 ---
 .../testEAP-TTLS-PAP/ssidEAP-TTLS-PAP.conf    | 12 ---
 autotests/testEAP-TTLS/connection_test.py     | 49 ----------
 autotests/testEAP-TTLS/hw.conf                |  5 -
 autotests/testEAP-TTLS/ssidEAP-TTLS.8021x     | 12 ---
 autotests/testEAP-TTLS/ssidEAP-TTLS.conf      | 12 ---
 autotests/testFILS/fils_256_test.py           |  7 --
 autotests/testFILS/fils_384_test.py           |  7 --
 autotests/testFILS/pwd.eap_user               |  1 -
 autotests/testFILS/radius.conf                |  2 +-
 autotests/testFILS/ssidFILS-256.8021x         |  2 +
 autotests/testFILS/ssidFILS-384.8021x         |  2 +
 autotests/testFT-8021x-roam/TestFT.8021x      |  2 +-
 .../testFT-8021x-roam/ft-eap-ccmp-1.conf      |  2 +-
 .../testFT-8021x-roam/ft-eap-ccmp-2.conf      |  2 +-
 autotests/testFT-FILS/TestFT.8021x            |  4 +-
 autotests/testFT-FILS/pwd.eap_user            |  1 -
 autotests/testFT-FILS/radius.conf             |  2 +-
 autotests/testPreauth-roam/TestPreauth.8021x  |  2 +-
 .../testPreauth-roam/eaptls-preauth-1.conf    |  2 +-
 autotests/testScan/ssid_8021x.conf            |  2 +-
 147 files changed, 37 insertions(+), 2189 deletions(-)
 delete mode 100644 autotests/misc/certs/eap-user-tls.text
 delete mode 100644 autotests/misc/certs/eap-user-ttls-mschapv2.text
 delete mode 100644 autotests/misc/certs/eap-user-ttls.text
 delete mode 100644 autotests/misc/secrets/eap-user-mschapv2.text
 delete mode 100644 autotests/misc/secrets/eap-user-peap-mschapv2.text
 delete mode 100644 autotests/misc/secrets/eap-user-peap-sim.text
 delete mode 100644 autotests/misc/secrets/eap-user-peap-v0-mschapv2.text
 delete mode 100644 autotests/misc/secrets/eap-user-peap-v0.text
 delete mode 100644 autotests/misc/secrets/eap-user-peap-v1.text
 delete mode 100644 autotests/testEAP-AKA-ofono/connection_test.py
 delete mode 100644 autotests/testEAP-AKA-ofono/hw.conf
 delete mode 100644 autotests/testEAP-AKA-ofono/sim.db
 delete mode 100644 autotests/testEAP-AKA-ofono/sim.eap_user
 delete mode 100644 autotests/testEAP-AKA-ofono/ssidEAP-AKA.8021x
 delete mode 100644 autotests/testEAP-AKA-ofono/ssidEAP-AKA.conf
 delete mode 100644 autotests/testEAP-AKA-prime-ofono/connection_test.py
 delete mode 100644 autotests/testEAP-AKA-prime-ofono/hw.conf
 delete mode 100644 autotests/testEAP-AKA-prime-ofono/sim.db
 delete mode 100644 autotests/testEAP-AKA-prime-ofono/sim.eap_user
 delete mode 100644 autotests/testEAP-AKA-prime-ofono/ssidEAP-AKA.8021x
 delete mode 100644 autotests/testEAP-AKA-prime-ofono/ssidEAP-AKA.conf
 delete mode 100644 autotests/testEAP-MSCHAPV2/connection_test.py
 delete mode 100644 autotests/testEAP-MSCHAPV2/hw.conf
 delete mode 100644 autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-1.8021x
 delete mode 100644 autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-2.8021x
 delete mode 100644 autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-3.8021x
 delete mode 100644 autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-4.8021x
 delete mode 100644 autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2.conf
 delete mode 100644 autotests/testEAP-PEAP-GTC/eap-user-peap-gtc.text
 delete mode 100644 autotests/testEAP-PEAP-GTC/hw.conf
 delete mode 100644 autotests/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py
 delete mode 100644 autotests/testEAP-PEAP-GTC/peap_gtc_test.py
 delete mode 100644 autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC-nosecret.=
8021x
 delete mode 100644 autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC-nosecret.=
conf
 delete mode 100644 autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC.8021x
 delete mode 100644 autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC.conf
 delete mode 100644 autotests/testEAP-PEAP-MSCHAPv2/connection_test.py
 delete mode 100644 autotests/testEAP-PEAP-MSCHAPv2/hw.conf
 delete mode 100644 autotests/testEAP-PEAP-MSCHAPv2/ssidEAP-PEAP-MSCHAPv2.8=
021x
 delete mode 100644 autotests/testEAP-PEAP-MSCHAPv2/ssidEAP-PEAP-MSCHAPv2.c=
onf
 delete mode 100644 autotests/testEAP-PEAP-SIM/connection_test.py
 delete mode 100644 autotests/testEAP-PEAP-SIM/hw.conf
 delete mode 100644 autotests/testEAP-PEAP-SIM/sim.db
 delete mode 100644 autotests/testEAP-PEAP-SIM/sim.eap_user
 delete mode 100644 autotests/testEAP-PEAP-SIM/ssidEAP-PEAP-SIM.8021x
 delete mode 100644 autotests/testEAP-PEAP-SIM/ssidEAP-PEAP-SIM.conf
 delete mode 100644 autotests/testEAP-PEAP/IWD-Frag/main.conf
 delete mode 100644 autotests/testEAP-PEAP/hw.conf
 delete mode 100644 autotests/testEAP-PEAP/peap_frag_test.py
 delete mode 100644 autotests/testEAP-PEAP/peap_v0_test.py
 delete mode 100644 autotests/testEAP-PEAP/peap_v1_test.py
 delete mode 100644 autotests/testEAP-PEAP/ssidEAP-PEAP-frag.8021x
 delete mode 100644 autotests/testEAP-PEAP/ssidEAP-PEAP-frag.conf
 delete mode 100644 autotests/testEAP-PEAP/ssidEAP-PEAPv0.8021x
 delete mode 100644 autotests/testEAP-PEAP/ssidEAP-PEAPv0.conf
 delete mode 100644 autotests/testEAP-PEAP/ssidEAP-PEAPv1.8021x
 delete mode 100644 autotests/testEAP-PEAP/ssidEAP-PEAPv1.conf
 delete mode 100644 autotests/testEAP-PWD/IWD-Frag/main.conf
 delete mode 100644 autotests/testEAP-PWD/connection_test.py
 delete mode 100644 autotests/testEAP-PWD/frag_test.py
 delete mode 100644 autotests/testEAP-PWD/hw.conf
 delete mode 100644 autotests/testEAP-PWD/pwd.eap_user
 delete mode 100644 autotests/testEAP-PWD/ssidEAP-PWD-frag.8021x
 delete mode 100644 autotests/testEAP-PWD/ssidEAP-PWD-frag.conf
 delete mode 100644 autotests/testEAP-PWD/ssidEAP-PWD.8021x
 delete mode 100644 autotests/testEAP-PWD/ssidEAP-PWD.conf
 delete mode 100644 autotests/testEAP-SIM-ofono/connection_test.py
 delete mode 100644 autotests/testEAP-SIM-ofono/hw.conf
 delete mode 100644 autotests/testEAP-SIM-ofono/sim.db
 delete mode 100644 autotests/testEAP-SIM-ofono/sim.eap_user
 delete mode 100644 autotests/testEAP-SIM-ofono/ssidEAP-SIM.8021x
 delete mode 100644 autotests/testEAP-SIM-ofono/ssidEAP-SIM.conf
 delete mode 100644 autotests/testEAP-TLS-embedded-pems/connection_test.py
 delete mode 100644 autotests/testEAP-TLS-embedded-pems/hw.conf
 delete mode 100644 autotests/testEAP-TLS-embedded-pems/ssidEAP-TLS.8021x
 delete mode 100644 autotests/testEAP-TLS-embedded-pems/ssidEAP-TLS.conf
 delete mode 100644 autotests/testEAP-TLS/connection_test.py
 delete mode 100644 autotests/testEAP-TLS/hw.conf
 delete mode 100644 autotests/testEAP-TLS/ssidEAP-TLS.8021x
 delete mode 100644 autotests/testEAP-TLS/ssidEAP-TLS.conf
 delete mode 100644 autotests/testEAP-TLS/ssidEAP-TLS2.8021x
 delete mode 100644 autotests/testEAP-TLS/ssidEAP-TLS2.conf
 delete mode 100644 autotests/testEAP-TLS/ssidEAP-TLS3.8021x
 delete mode 100644 autotests/testEAP-TLS/ssidEAP-TLS3.conf
 delete mode 100644 autotests/testEAP-TLS/ssidEAP-TLS4.8021x
 delete mode 100644 autotests/testEAP-TLS/ssidEAP-TLS4.conf
 delete mode 100644 autotests/testEAP-TTLS-CHAP/connection_test.py
 delete mode 100644 autotests/testEAP-TTLS-CHAP/eap-user-ttls-chap.text
 delete mode 100644 autotests/testEAP-TTLS-CHAP/hw.conf
 delete mode 100644 autotests/testEAP-TTLS-CHAP/ssidEAP-TTLS-CHAP.8021x
 delete mode 100644 autotests/testEAP-TTLS-CHAP/ssidEAP-TTLS-CHAP.conf
 delete mode 100644 autotests/testEAP-TTLS-EAP-MSCHAPV2/connection_test.py
 delete mode 100644 autotests/testEAP-TTLS-EAP-MSCHAPV2/hw.conf
 delete mode 100644 autotests/testEAP-TTLS-EAP-MSCHAPV2/ssidEAP-TTLS.8021x
 delete mode 100644 autotests/testEAP-TTLS-EAP-MSCHAPV2/ssidEAP-TTLS.conf
 delete mode 100644 autotests/testEAP-TTLS-MSCHAP/connection_test.py
 delete mode 100644 autotests/testEAP-TTLS-MSCHAP/eap-user-ttls-mschap.text
 delete mode 100644 autotests/testEAP-TTLS-MSCHAP/hw.conf
 delete mode 100644 autotests/testEAP-TTLS-MSCHAP/ssidEAP-TTLS-MSCHAP.8021x
 delete mode 100644 autotests/testEAP-TTLS-MSCHAP/ssidEAP-TTLS-MSCHAP.conf
 delete mode 100644 autotests/testEAP-TTLS-MSCHAPv2/connection_test.py
 delete mode 100644 autotests/testEAP-TTLS-MSCHAPv2/eap-user-ttls-mschapv2.=
text
 delete mode 100644 autotests/testEAP-TTLS-MSCHAPv2/failure_test.py
 delete mode 100644 autotests/testEAP-TTLS-MSCHAPv2/hw.conf
 delete mode 100644 autotests/testEAP-TTLS-MSCHAPv2/ssidEAP-TTLS-MSCHAPv2.8=
021x
 delete mode 100644 autotests/testEAP-TTLS-MSCHAPv2/ssidEAP-TTLS-MSCHAPv2.c=
onf
 delete mode 100644 autotests/testEAP-TTLS-PAP/connection_test.py
 delete mode 100644 autotests/testEAP-TTLS-PAP/eap-user-ttls-pap.text
 delete mode 100644 autotests/testEAP-TTLS-PAP/hw.conf
 delete mode 100644 autotests/testEAP-TTLS-PAP/ssidEAP-TTLS-PAP.8021x
 delete mode 100644 autotests/testEAP-TTLS-PAP/ssidEAP-TTLS-PAP.conf
 delete mode 100644 autotests/testEAP-TTLS/connection_test.py
 delete mode 100644 autotests/testEAP-TTLS/hw.conf
 delete mode 100644 autotests/testEAP-TTLS/ssidEAP-TTLS.8021x
 delete mode 100644 autotests/testEAP-TTLS/ssidEAP-TTLS.conf
 delete mode 100644 autotests/testFILS/pwd.eap_user
 delete mode 100644 autotests/testFT-FILS/pwd.eap_user

diff --git a/autotests/misc/certs/eap-user-tls.text b/autotests/misc/certs/=
eap-user-tls.text
deleted file mode 100644
index b8b1e8d4..00000000
--- a/autotests/misc/certs/eap-user-tls.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-* TLS
-# Phase 2
-"abc(a)example.com" MD5 "testpasswd" [2]
diff --git a/autotests/misc/certs/eap-user-ttls-mschapv2.text b/autotests/m=
isc/certs/eap-user-ttls-mschapv2.text
deleted file mode 100644
index df210e49..00000000
--- a/autotests/misc/certs/eap-user-ttls-mschapv2.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-* TTLS
-# Phase 2
-"user" MSCHAPV2 "testpasswd" [2]
diff --git a/autotests/misc/certs/eap-user-ttls.text b/autotests/misc/certs=
/eap-user-ttls.text
deleted file mode 100644
index b26becf2..00000000
--- a/autotests/misc/certs/eap-user-ttls.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-* TTLS
-# Phase 2
-"abc(a)example.com" MD5 "testpasswd" [2]
diff --git a/autotests/misc/secrets/eap-user-mschapv2.text b/autotests/misc=
/secrets/eap-user-mschapv2.text
deleted file mode 100644
index b18410d3..00000000
--- a/autotests/misc/secrets/eap-user-mschapv2.text
+++ /dev/null
@@ -1 +0,0 @@
-"domain\User" MSCHAPV2 "Password"
diff --git a/autotests/misc/secrets/eap-user-peap-mschapv2.text b/autotests=
/misc/secrets/eap-user-peap-mschapv2.text
deleted file mode 100644
index 892670d8..00000000
--- a/autotests/misc/secrets/eap-user-peap-mschapv2.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-* PEAP
-# Phase 2
-"domain\User" MSCHAPV2 "Password" [2]
diff --git a/autotests/misc/secrets/eap-user-peap-sim.text b/autotests/misc=
/secrets/eap-user-peap-sim.text
deleted file mode 100644
index 76820116..00000000
--- a/autotests/misc/secrets/eap-user-peap-sim.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-*	PEAP
-# Phase 2
-"112345678(a)phonesim.org"	SIM	[2]
diff --git a/autotests/misc/secrets/eap-user-peap-v0-mschapv2.text b/autote=
sts/misc/secrets/eap-user-peap-v0-mschapv2.text
deleted file mode 100644
index c91693c4..00000000
--- a/autotests/misc/secrets/eap-user-peap-v0-mschapv2.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-* PEAP [ver=3D0]
-# Phase 2
-"secure(a)identity.com" MSCHAPV2 "testpasswd" [2]
diff --git a/autotests/misc/secrets/eap-user-peap-v0.text b/autotests/misc/=
secrets/eap-user-peap-v0.text
deleted file mode 100644
index 339373c3..00000000
--- a/autotests/misc/secrets/eap-user-peap-v0.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-* PEAP [ver=3D0]
-# Phase 2
-"secure(a)identity.com" MD5 "testpasswd" [2]
diff --git a/autotests/misc/secrets/eap-user-peap-v1.text b/autotests/misc/=
secrets/eap-user-peap-v1.text
deleted file mode 100644
index 9b349530..00000000
--- a/autotests/misc/secrets/eap-user-peap-v1.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-* PEAP [ver=3D1]
-# Phase 2
-"secure(a)identity.com" MD5 "testpasswd" [2]
diff --git a/autotests/testConnectAutoconnect/ssidEAP-Other.conf b/autotest=
s/testConnectAutoconnect/ssidEAP-Other.conf
index 5e327911..5ccb61d1 100644
--- a/autotests/testConnectAutoconnect/ssidEAP-Other.conf
+++ b/autotests/testConnectAutoconnect/ssidEAP-Other.conf
@@ -6,7 +6,7 @@ wpa=3D3
 wpa_key_mgmt=3DWPA-EAP
 ieee8021x=3D1
 eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-ttls.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testConnectAutoconnect/ssidEAP-TLS.8021x b/autotests=
/testConnectAutoconnect/ssidEAP-TLS.8021x
index fe8a2e46..a64b883c 100644
--- a/autotests/testConnectAutoconnect/ssidEAP-TLS.8021x
+++ b/autotests/testConnectAutoconnect/ssidEAP-TLS.8021x
@@ -3,4 +3,4 @@ EAP-Method=3DTLS
 EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
 EAP-TLS-ClientCert=3D/tmp/certs/cert-client.pem
 EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-Identity=3Dabc(a)example.com
+EAP-Identity=3Dtls(a)example.com
diff --git a/autotests/testConnectAutoconnect/ssidEAP-TLS.conf b/autotests/=
testConnectAutoconnect/ssidEAP-TLS.conf
index e1d7c6b4..f6363dfa 100644
--- a/autotests/testConnectAutoconnect/ssidEAP-TLS.conf
+++ b/autotests/testConnectAutoconnect/ssidEAP-TLS.conf
@@ -6,7 +6,7 @@ wpa=3D3
 wpa_key_mgmt=3DWPA-EAP
 ieee8021x=3D1
 eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAD/default.8021x b/autotests/testEAD/default.80=
21x
index 55eb431d..3aba560c 100644
--- a/autotests/testEAD/default.8021x
+++ b/autotests/testEAD/default.8021x
@@ -1,6 +1,6 @@
 [Security]
 EAP-Method=3DMSCHAPV2
-EAP-Identity=3Ddomain\\User
+EAP-Identity=3Dmschapv2(a)example.com
 EAP-Password=3DPassword
 =

 [Settings]
diff --git a/autotests/testEAD/wired.conf b/autotests/testEAD/wired.conf
index 9e6ef638..6b44d190 100644
--- a/autotests/testEAD/wired.conf
+++ b/autotests/testEAD/wired.conf
@@ -13,5 +13,5 @@ nas_identifier=3Dap.example.com
 radius_server_clients=3D/tmp/certs/radius-clients.text
 radius_server_auth_port=3D1812
 =

-eap_user_file=3D/tmp/secrets/eap-user-mschapv2.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 eap_server=3D1
diff --git a/autotests/testEAP-AKA-ofono/connection_test.py b/autotests/tes=
tEAP-AKA-ofono/connection_test.py
deleted file mode 100644
index 1b250da2..00000000
--- a/autotests/testEAP-AKA-ofono/connection_test.py
+++ /dev/null
@@ -1,59 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-from hlrauc import AuthCenter
-from ofono import Ofono
-from config import ctx
-
-class Test(unittest.TestCase):
-    def test_connection_success(self):
-        ofono =3D Ofono()
-        ofono.enable_modem('/phonesim')
-        ofono.wait_for_sim_auth()
-
-        wd =3D IWD()
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-AKA')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    @classmethod
-    def setUpClass(cls):
-        if not ctx.is_process_running('ofonod'):
-            cls.skipTest(cls, "ofono not running")
-
-        IWD.copy_to_storage('ssidEAP-AKA.8021x')
-
-        cls.auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-        cls.auth.stop()
-        cls.auth =3D None
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-AKA-ofono/hw.conf b/autotests/testEAP-AKA-of=
ono/hw.conf
deleted file mode 100644
index a4555c6f..00000000
--- a/autotests/testEAP-AKA-ofono/hw.conf
+++ /dev/null
@@ -1,6 +0,0 @@
-[SETUP]
-num_radios=3D2
-sim_keys=3Dofono
-
-[HOSTAPD]
-rad0=3DssidEAP-AKA.conf
diff --git a/autotests/testEAP-AKA-ofono/sim.db b/autotests/testEAP-AKA-ofo=
no/sim.db
deleted file mode 100644
index c4461ae1..00000000
--- a/autotests/testEAP-AKA-ofono/sim.db
+++ /dev/null
@@ -1,3 +0,0 @@
-# IMSI K OPC AMF SQN
-
-12345678:90dca4eda45b53cf0f12d7c9c3bc6a89:cb9cccc4b9258e6dca4760379fb82581=
:61df:000000000021
\ No newline at end of file
diff --git a/autotests/testEAP-AKA-ofono/sim.eap_user b/autotests/testEAP-A=
KA-ofono/sim.eap_user
deleted file mode 100644
index 123d8c9c..00000000
--- a/autotests/testEAP-AKA-ofono/sim.eap_user
+++ /dev/null
@@ -1 +0,0 @@
-"012345678(a)phonesim.org"	AKA
diff --git a/autotests/testEAP-AKA-ofono/ssidEAP-AKA.8021x b/autotests/test=
EAP-AKA-ofono/ssidEAP-AKA.8021x
deleted file mode 100644
index 304eb276..00000000
--- a/autotests/testEAP-AKA-ofono/ssidEAP-AKA.8021x
+++ /dev/null
@@ -1,5 +0,0 @@
-[Security]
-EAP-Method=3DAKA
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-AKA-ofono/ssidEAP-AKA.conf b/autotests/testE=
AP-AKA-ofono/ssidEAP-AKA.conf
deleted file mode 100644
index 01f01f45..00000000
--- a/autotests/testEAP-AKA-ofono/ssidEAP-AKA.conf
+++ /dev/null
@@ -1,16 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-
-driver=3Dnl80211
-ieee8021x=3D1
-eap_server=3D1
-ssid=3DssidEAP-AKA
-eap_user_file=3D/tmp/sim.eap_user
-eap_sim_db=3Dunix:/tmp/hlrauc.sock
-wpa=3D2
-wpa_key_mgmt=3DWPA-EAP
-wpa_pairwise=3DTKIP CCMP
-rsn_pairwise=3DCCMP TKIP
-wpa_passphrase=3Dsecret123
-channel=3D1
-eap_sim_aka_result_ind=3D1
diff --git a/autotests/testEAP-AKA-prime-ofono/connection_test.py b/autotes=
ts/testEAP-AKA-prime-ofono/connection_test.py
deleted file mode 100644
index 5edf4965..00000000
--- a/autotests/testEAP-AKA-prime-ofono/connection_test.py
+++ /dev/null
@@ -1,58 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-from hlrauc import AuthCenter
-from ofono import Ofono
-from config import ctx
-
-class Test(unittest.TestCase):
-    def test_connection_success(self):
-        ofono =3D Ofono()
-        ofono.enable_modem('/phonesim')
-        ofono.wait_for_sim_auth()
-
-        wd =3D IWD()
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-AKA')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    @classmethod
-    def setUpClass(cls):
-        if not ctx.is_process_running('ofonod'):
-            cls.skipTest(cls, "ofono not running")
-
-        IWD.copy_to_storage('ssidEAP-AKA.8021x')
-
-        cls.auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-        cls.auth.stop()
-        cls.auth =3D None
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-AKA-prime-ofono/hw.conf b/autotests/testEAP-=
AKA-prime-ofono/hw.conf
deleted file mode 100644
index a4555c6f..00000000
--- a/autotests/testEAP-AKA-prime-ofono/hw.conf
+++ /dev/null
@@ -1,6 +0,0 @@
-[SETUP]
-num_radios=3D2
-sim_keys=3Dofono
-
-[HOSTAPD]
-rad0=3DssidEAP-AKA.conf
diff --git a/autotests/testEAP-AKA-prime-ofono/sim.db b/autotests/testEAP-A=
KA-prime-ofono/sim.db
deleted file mode 100644
index c4461ae1..00000000
--- a/autotests/testEAP-AKA-prime-ofono/sim.db
+++ /dev/null
@@ -1,3 +0,0 @@
-# IMSI K OPC AMF SQN
-
-12345678:90dca4eda45b53cf0f12d7c9c3bc6a89:cb9cccc4b9258e6dca4760379fb82581=
:61df:000000000021
\ No newline at end of file
diff --git a/autotests/testEAP-AKA-prime-ofono/sim.eap_user b/autotests/tes=
tEAP-AKA-prime-ofono/sim.eap_user
deleted file mode 100644
index 746c8b25..00000000
--- a/autotests/testEAP-AKA-prime-ofono/sim.eap_user
+++ /dev/null
@@ -1 +0,0 @@
-"612345678(a)phonesim.org"	AKA'
\ No newline at end of file
diff --git a/autotests/testEAP-AKA-prime-ofono/ssidEAP-AKA.8021x b/autotest=
s/testEAP-AKA-prime-ofono/ssidEAP-AKA.8021x
deleted file mode 100644
index 6e88da6b..00000000
--- a/autotests/testEAP-AKA-prime-ofono/ssidEAP-AKA.8021x
+++ /dev/null
@@ -1,5 +0,0 @@
-[Security]
-EAP-Method=3DAKA'
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-AKA-prime-ofono/ssidEAP-AKA.conf b/autotests=
/testEAP-AKA-prime-ofono/ssidEAP-AKA.conf
deleted file mode 100644
index 01f01f45..00000000
--- a/autotests/testEAP-AKA-prime-ofono/ssidEAP-AKA.conf
+++ /dev/null
@@ -1,16 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-
-driver=3Dnl80211
-ieee8021x=3D1
-eap_server=3D1
-ssid=3DssidEAP-AKA
-eap_user_file=3D/tmp/sim.eap_user
-eap_sim_db=3Dunix:/tmp/hlrauc.sock
-wpa=3D2
-wpa_key_mgmt=3DWPA-EAP
-wpa_pairwise=3DTKIP CCMP
-rsn_pairwise=3DCCMP TKIP
-wpa_passphrase=3Dsecret123
-channel=3D1
-eap_sim_aka_result_ind=3D1
diff --git a/autotests/testEAP-MSCHAPV2/connection_test.py b/autotests/test=
EAP-MSCHAPV2/connection_test.py
deleted file mode 100644
index faa77918..00000000
--- a/autotests/testEAP-MSCHAPV2/connection_test.py
+++ /dev/null
@@ -1,76 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-
-class Test(unittest.TestCase):
-
-    def run_connection_test(self, *secrets):
-        wd =3D IWD()
-
-        psk_agent =3D iwd.PSKAgent(*secrets)
-        wd.register_psk_agent(psk_agent)
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        condition =3D 'not obj.scanning'
-        wd.wait_for_object_condition(device, condition)
-
-        if not device.get_ordered_networks():
-            device.scan()
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-            condition =3D 'not obj.scanning'
-            wd.wait_for_object_condition(device, condition)
-
-        ordered_network =3D device.get_ordered_network("ssidEAP-MSCHAPV2")
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        wd.unregister_psk_agent(psk_agent)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    def test_agent_none(self):
-        IWD.copy_to_storage('ssidEAP-MSCHAPV2-1.8021x', name=3D'ssidEAP-MS=
CHAPV2.8021x')
-        self.run_connection_test()
-
-    def test_agent_none_hash(self):
-        IWD.copy_to_storage('ssidEAP-MSCHAPV2-2.8021x', name=3D'ssidEAP-MS=
CHAPV2.8021x')
-        self.run_connection_test()
-
-    def test_agent_passwd(self):
-        IWD.copy_to_storage('ssidEAP-MSCHAPV2-3.8021x', name=3D'ssidEAP-MS=
CHAPV2.8021x')
-        self.run_connection_test([], ('domain\\User', 'Password'))
-
-    def test_agent_username_and_passwd(self):
-        IWD.copy_to_storage('ssidEAP-MSCHAPV2-4.8021x', name=3D'ssidEAP-MS=
CHAPV2.8021x')
-        self.run_connection_test([], ('domain\\User', 'Password'))
-
-    @classmethod
-    def setUpClass(cls):
-        pass
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-MSCHAPV2/hw.conf b/autotests/testEAP-MSCHAPV=
2/hw.conf
deleted file mode 100644
index b22a2c9f..00000000
--- a/autotests/testEAP-MSCHAPV2/hw.conf
+++ /dev/null
@@ -1,5 +0,0 @@
-[SETUP]
-num_radios=3D2
-
-[HOSTAPD]
-rad0=3DssidEAP-MSCHAPV2.conf
diff --git a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-1.8021x b/autotest=
s/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-1.8021x
deleted file mode 100644
index 55eb431d..00000000
--- a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-1.8021x
+++ /dev/null
@@ -1,7 +0,0 @@
-[Security]
-EAP-Method=3DMSCHAPV2
-EAP-Identity=3Ddomain\\User
-EAP-Password=3DPassword
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-2.8021x b/autotest=
s/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-2.8021x
deleted file mode 100644
index a2c58b33..00000000
--- a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-2.8021x
+++ /dev/null
@@ -1,7 +0,0 @@
-[Security]
-EAP-Method=3DMSCHAPV2
-EAP-Identity=3Ddomain\\User
-EAP-Password-Hash=3Da4f49c406510bdcab6824ee7c30fd852
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-3.8021x b/autotest=
s/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-3.8021x
deleted file mode 100644
index 2c18c8fd..00000000
--- a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-3.8021x
+++ /dev/null
@@ -1,6 +0,0 @@
-[Security]
-EAP-Method=3DMSCHAPV2
-EAP-Identity=3Ddomain\\User
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-4.8021x b/autotest=
s/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-4.8021x
deleted file mode 100644
index d7528b38..00000000
--- a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2-4.8021x
+++ /dev/null
@@ -1,5 +0,0 @@
-[Security]
-EAP-Method=3DMSCHAPV2
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2.conf b/autotests/t=
estEAP-MSCHAPV2/ssidEAP-MSCHAPV2.conf
deleted file mode 100644
index 3f33e99d..00000000
--- a/autotests/testEAP-MSCHAPV2/ssidEAP-MSCHAPV2.conf
+++ /dev/null
@@ -1,9 +0,0 @@
-ssid=3DssidEAP-MSCHAPV2
-interface=3Dwln0
-hw_mode=3Dg
-channel=3D1
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/secrets/eap-user-mschapv2.text
diff --git a/autotests/testEAP-PEAP-GTC/eap-user-peap-gtc.text b/autotests/=
testEAP-PEAP-GTC/eap-user-peap-gtc.text
deleted file mode 100644
index 5ec5328e..00000000
--- a/autotests/testEAP-PEAP-GTC/eap-user-peap-gtc.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-* PEAP [ver=3D1]
-# Phase 2
-"secure(a)identity.com" GTC "testpasswd" [2]
diff --git a/autotests/testEAP-PEAP-GTC/hw.conf b/autotests/testEAP-PEAP-GT=
C/hw.conf
deleted file mode 100644
index acca16b0..00000000
--- a/autotests/testEAP-PEAP-GTC/hw.conf
+++ /dev/null
@@ -1,7 +0,0 @@
-[SETUP]
-num_radios=3D3
-start_iwd=3D0
-
-[HOSTAPD]
-rad0=3DssidEAP-PEAPv1-GTC.conf
-rad1=3DssidEAP-PEAPv1-GTC-nosecret.conf
diff --git a/autotests/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py b/autotes=
ts/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py
deleted file mode 100644
index a4903dbd..00000000
--- a/autotests/testEAP-PEAP-GTC/peap_gtc_nosecret_test.py
+++ /dev/null
@@ -1,59 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-import time
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-from iwd import PSKAgent
-
-class Test(unittest.TestCase):
-
-    def validate_connection(self, wd):
-        devices =3D wd.list_devices(1)
-
-        self.assertIsNotNone(devices)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-PEAPv1-GTC=
-nosecret')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    def test_connection_success(self):
-        wd =3D IWD(True)
-
-        psk_agent =3D PSKAgent('secure(a)identity.com',
-                                ('secure(a)identity.com', 'testpasswd'))
-        wd.register_psk_agent(psk_agent)
-
-        try:
-            self.validate_connection(wd)
-        finally:
-            wd.unregister_psk_agent(psk_agent)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-PEAPv1-GTC-nosecret.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-PEAP-GTC/peap_gtc_test.py b/autotests/testEA=
P-PEAP-GTC/peap_gtc_test.py
deleted file mode 100644
index c5ccb50f..00000000
--- a/autotests/testEAP-PEAP-GTC/peap_gtc_test.py
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-import time
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-
-class Test(unittest.TestCase):
-
-    def validate_connection(self, wd):
-        devices =3D wd.list_devices(1)
-
-        self.assertIsNotNone(devices)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-PEAPv1-GTC=
')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    def test_connection_success(self):
-        wd =3D IWD(True)
-
-        self.validate_connection(wd)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-PEAPv1-GTC.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC-nosecret.8021x b=
/autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC-nosecret.8021x
deleted file mode 100644
index 93fff8d6..00000000
--- a/autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC-nosecret.8021x
+++ /dev/null
@@ -1,11 +0,0 @@
-[Security]
-EAP-Method=3DPEAP
-EAP-Identity=3Dopen(a)identity.com
-EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
-EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
-EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-PEAP-Phase2-Method=3DGTC
-EAP-PEAP-Phase2-Identity=3Dsecure(a)identity.com
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC-nosecret.conf b/=
autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC-nosecret.conf
deleted file mode 100644
index a6c36f42..00000000
--- a/autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC-nosecret.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-PEAPv1-GTC-nosecret
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/eap-user-peap-gtc.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC.8021x b/autotest=
s/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC.8021x
deleted file mode 100644
index 42deabac..00000000
--- a/autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC.8021x
+++ /dev/null
@@ -1,12 +0,0 @@
-[Security]
-EAP-Method=3DPEAP
-EAP-Identity=3Dopen(a)identity.com
-EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
-EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
-EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-PEAP-Phase2-Method=3DGTC
-EAP-PEAP-Phase2-Identity=3Dsecure(a)identity.com
-EAP-PEAP-Phase2-Password=3Dtestpasswd
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC.conf b/autotests=
/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC.conf
deleted file mode 100644
index ecd498bd..00000000
--- a/autotests/testEAP-PEAP-GTC/ssidEAP-PEAPv1-GTC.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-PEAPv1-GTC
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/eap-user-peap-gtc.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-PEAP-MSCHAPv2/connection_test.py b/autotests=
/testEAP-PEAP-MSCHAPv2/connection_test.py
deleted file mode 100644
index 017729cf..00000000
--- a/autotests/testEAP-PEAP-MSCHAPv2/connection_test.py
+++ /dev/null
@@ -1,52 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-import time
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-from hlrauc import AuthCenter
-
-class Test(unittest.TestCase):
-
-    def validate_connection(self, wd):
-        devices =3D wd.list_devices(1)
-        self.assertIsNotNone(devices)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-PEAP-MSCHA=
Pv2')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-
-    def test_connection_success(self):
-        wd =3D IWD(True)
-
-        self.validate_connection(wd)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-PEAP-MSCHAPv2.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-PEAP-MSCHAPv2/hw.conf b/autotests/testEAP-PE=
AP-MSCHAPv2/hw.conf
deleted file mode 100644
index 12e11211..00000000
--- a/autotests/testEAP-PEAP-MSCHAPv2/hw.conf
+++ /dev/null
@@ -1,6 +0,0 @@
-[SETUP]
-num_radios=3D2
-start_iwd=3D0
-
-[HOSTAPD]
-rad0=3DssidEAP-PEAP-MSCHAPv2.conf
diff --git a/autotests/testEAP-PEAP-MSCHAPv2/ssidEAP-PEAP-MSCHAPv2.8021x b/=
autotests/testEAP-PEAP-MSCHAPv2/ssidEAP-PEAP-MSCHAPv2.8021x
deleted file mode 100644
index f000ff9a..00000000
--- a/autotests/testEAP-PEAP-MSCHAPv2/ssidEAP-PEAP-MSCHAPv2.8021x
+++ /dev/null
@@ -1,12 +0,0 @@
-[Security]
-EAP-Method=3DPEAP
-EAP-Identity=3Dopen(a)identity.com
-EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
-EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
-EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-PEAP-Phase2-Method=3DMSCHAPV2
-EAP-PEAP-Phase2-Identity=3Ddomain\\User
-EAP-PEAP-Phase2-Password=3DPassword
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PEAP-MSCHAPv2/ssidEAP-PEAP-MSCHAPv2.conf b/a=
utotests/testEAP-PEAP-MSCHAPv2/ssidEAP-PEAP-MSCHAPv2.conf
deleted file mode 100644
index e5c5516b..00000000
--- a/autotests/testEAP-PEAP-MSCHAPv2/ssidEAP-PEAP-MSCHAPv2.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-PEAP-MSCHAPv2
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/secrets/eap-user-peap-mschapv2.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-PEAP-SIM/connection_test.py b/autotests/test=
EAP-PEAP-SIM/connection_test.py
deleted file mode 100644
index 84b95c7a..00000000
--- a/autotests/testEAP-PEAP-SIM/connection_test.py
+++ /dev/null
@@ -1,65 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-import time
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-from hlrauc import AuthCenter
-from ofono import Ofono
-from config import ctx
-
-class Test(unittest.TestCase):
-    def validate_connection(self, wd):
-        devices =3D wd.list_devices(1)
-        self.assertIsNotNone(devices)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-PEAP-SIM')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-
-    def test_connection_success(self):
-        ofono =3D Ofono()
-        ofono.enable_modem('/phonesim')
-        ofono.wait_for_sim_auth()
-
-        wd =3D IWD(True)
-
-        self.validate_connection(wd)
-
-    @classmethod
-    def setUpClass(cls):
-        if not ctx.is_process_running('ofonod'):
-            cls.skipTest(cls, "ofono not running")
-
-        cls.auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
-
-        IWD.copy_to_storage('ssidEAP-PEAP-SIM.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-        cls.auth.stop()
-        cls.auth =3D None
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-PEAP-SIM/hw.conf b/autotests/testEAP-PEAP-SI=
M/hw.conf
deleted file mode 100644
index 659ba0e0..00000000
--- a/autotests/testEAP-PEAP-SIM/hw.conf
+++ /dev/null
@@ -1,7 +0,0 @@
-[SETUP]
-num_radios=3D2
-start_iwd=3D0
-sim_keys=3Dofono
-
-[HOSTAPD]
-rad0=3DssidEAP-PEAP-SIM.conf
diff --git a/autotests/testEAP-PEAP-SIM/sim.db b/autotests/testEAP-PEAP-SIM=
/sim.db
deleted file mode 100644
index fbf79786..00000000
--- a/autotests/testEAP-PEAP-SIM/sim.db
+++ /dev/null
@@ -1 +0,0 @@
-12345678:673fb8cd35f98800:1fb1e3b5:DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
diff --git a/autotests/testEAP-PEAP-SIM/sim.eap_user b/autotests/testEAP-PE=
AP-SIM/sim.eap_user
deleted file mode 100644
index dabb81a8..00000000
--- a/autotests/testEAP-PEAP-SIM/sim.eap_user
+++ /dev/null
@@ -1 +0,0 @@
-"112345678(a)phonesim.org"	SIM
diff --git a/autotests/testEAP-PEAP-SIM/ssidEAP-PEAP-SIM.8021x b/autotests/=
testEAP-PEAP-SIM/ssidEAP-PEAP-SIM.8021x
deleted file mode 100644
index 6decd1bf..00000000
--- a/autotests/testEAP-PEAP-SIM/ssidEAP-PEAP-SIM.8021x
+++ /dev/null
@@ -1,10 +0,0 @@
-[Security]
-EAP-Method=3DPEAP
-EAP-Identity=3Dopen(a)example.com
-EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
-EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
-EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-PEAP-Phase2-Method=3DSIM
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PEAP-SIM/ssidEAP-PEAP-SIM.conf b/autotests/t=
estEAP-PEAP-SIM/ssidEAP-PEAP-SIM.conf
deleted file mode 100644
index d0e66bca..00000000
--- a/autotests/testEAP-PEAP-SIM/ssidEAP-PEAP-SIM.conf
+++ /dev/null
@@ -1,15 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-PEAP-SIM
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/secrets/eap-user-peap-sim.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
-
-eap_sim_db=3Dunix:/tmp/hlrauc.sock
-eap_sim_aka_result_ind=3D1
diff --git a/autotests/testEAP-PEAP/IWD-Frag/main.conf b/autotests/testEAP-=
PEAP/IWD-Frag/main.conf
deleted file mode 100644
index e583733c..00000000
--- a/autotests/testEAP-PEAP/IWD-Frag/main.conf
+++ /dev/null
@@ -1,2 +0,0 @@
-[EAP]
-MTU=3D100
diff --git a/autotests/testEAP-PEAP/hw.conf b/autotests/testEAP-PEAP/hw.conf
deleted file mode 100644
index 0dcda0a2..00000000
--- a/autotests/testEAP-PEAP/hw.conf
+++ /dev/null
@@ -1,8 +0,0 @@
-[SETUP]
-num_radios=3D4
-start_iwd=3D0
-
-[HOSTAPD]
-rad0=3DssidEAP-PEAPv1.conf
-rad1=3DssidEAP-PEAPv0.conf
-rad2=3DssidEAP-PEAP-frag.conf
diff --git a/autotests/testEAP-PEAP/peap_frag_test.py b/autotests/testEAP-P=
EAP/peap_frag_test.py
deleted file mode 100644
index c5a7ccff..00000000
--- a/autotests/testEAP-PEAP/peap_frag_test.py
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-import time
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-
-class Test(unittest.TestCase):
-
-    def validate_connection(self, wd):
-        devices =3D wd.list_devices(1)
-        self.assertIsNotNone(devices)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-PEAP-frag')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    def test_connection_success(self):
-        wd =3D IWD(True, '/tmp/IWD-Frag')
-
-        self.validate_connection(wd)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-PEAP-frag.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-PEAP/peap_v0_test.py b/autotests/testEAP-PEA=
P/peap_v0_test.py
deleted file mode 100644
index ea93ff6f..00000000
--- a/autotests/testEAP-PEAP/peap_v0_test.py
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-import time
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-
-class Test(unittest.TestCase):
-
-    def validate_connection(self, wd):
-        devices =3D wd.list_devices(1)
-        self.assertIsNotNone(devices)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-PEAPv0')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    def test_connection_success(self):
-        wd =3D IWD(True)
-
-        self.validate_connection(wd)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-PEAPv0.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-PEAP/peap_v1_test.py b/autotests/testEAP-PEA=
P/peap_v1_test.py
deleted file mode 100644
index 16f38d92..00000000
--- a/autotests/testEAP-PEAP/peap_v1_test.py
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-import time
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-
-class Test(unittest.TestCase):
-
-    def validate_connection(self, wd):
-        devices =3D wd.list_devices(1)
-        self.assertIsNotNone(devices)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-PEAPv1')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    def test_connection_success(self):
-        wd =3D IWD(True)
-
-        self.validate_connection(wd)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-PEAPv1.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-PEAP/ssidEAP-PEAP-frag.8021x b/autotests/tes=
tEAP-PEAP/ssidEAP-PEAP-frag.8021x
deleted file mode 100644
index 382f86d0..00000000
--- a/autotests/testEAP-PEAP/ssidEAP-PEAP-frag.8021x
+++ /dev/null
@@ -1,12 +0,0 @@
-[Security]
-EAP-Method=3DPEAP
-EAP-Identity=3Dopen(a)identity.com
-EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
-EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
-EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-PEAP-Phase2-Method=3DMD5
-EAP-PEAP-Phase2-Identity=3Dsecure(a)identity.com
-EAP-PEAP-Phase2-Password=3Dtestpasswd
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PEAP/ssidEAP-PEAP-frag.conf b/autotests/test=
EAP-PEAP/ssidEAP-PEAP-frag.conf
deleted file mode 100644
index 28eb36f0..00000000
--- a/autotests/testEAP-PEAP/ssidEAP-PEAP-frag.conf
+++ /dev/null
@@ -1,14 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-PEAP-frag
-
-fragment_size=3D256
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/secrets/eap-user-peap-v1.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-PEAP/ssidEAP-PEAPv0.8021x b/autotests/testEA=
P-PEAP/ssidEAP-PEAPv0.8021x
deleted file mode 100644
index 382f86d0..00000000
--- a/autotests/testEAP-PEAP/ssidEAP-PEAPv0.8021x
+++ /dev/null
@@ -1,12 +0,0 @@
-[Security]
-EAP-Method=3DPEAP
-EAP-Identity=3Dopen(a)identity.com
-EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
-EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
-EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-PEAP-Phase2-Method=3DMD5
-EAP-PEAP-Phase2-Identity=3Dsecure(a)identity.com
-EAP-PEAP-Phase2-Password=3Dtestpasswd
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PEAP/ssidEAP-PEAPv0.conf b/autotests/testEAP=
-PEAP/ssidEAP-PEAPv0.conf
deleted file mode 100644
index 5b63e047..00000000
--- a/autotests/testEAP-PEAP/ssidEAP-PEAPv0.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-PEAPv0
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/secrets/eap-user-peap-v0.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-PEAP/ssidEAP-PEAPv1.8021x b/autotests/testEA=
P-PEAP/ssidEAP-PEAPv1.8021x
deleted file mode 100644
index 382f86d0..00000000
--- a/autotests/testEAP-PEAP/ssidEAP-PEAPv1.8021x
+++ /dev/null
@@ -1,12 +0,0 @@
-[Security]
-EAP-Method=3DPEAP
-EAP-Identity=3Dopen(a)identity.com
-EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
-EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
-EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-PEAP-Phase2-Method=3DMD5
-EAP-PEAP-Phase2-Identity=3Dsecure(a)identity.com
-EAP-PEAP-Phase2-Password=3Dtestpasswd
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PEAP/ssidEAP-PEAPv1.conf b/autotests/testEAP=
-PEAP/ssidEAP-PEAPv1.conf
deleted file mode 100644
index 1c8b2d9b..00000000
--- a/autotests/testEAP-PEAP/ssidEAP-PEAPv1.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-PEAPv1
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/secrets/eap-user-peap-v1.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.8021=
x b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.8021x
index 56eed087..988661c7 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.8021x
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.8021x
@@ -1,12 +1,12 @@
 [Security]
 EAP-Method=3DPEAP
-EAP-Identity=3Dopen(a)identity.com
+EAP-Identity=3Dpeapv0(a)example.com
 EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
 EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
 EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
 EAP-PEAP-Phase2-Method=3DMSCHAPV2
-EAP-PEAP-Phase2-Identity=3Dsecure(a)identity.com
-EAP-PEAP-Phase2-Password=3Dtestpasswd
+EAP-PEAP-Phase2-Identity=3Dmschapv2-phase2(a)example.com
+EAP-PEAP-Phase2-Password=3DPassword
 =

 [Settings]
 AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.conf=
 b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.conf
index c9980bd9..38ccf1cf 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.conf
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-ISK.conf
@@ -6,7 +6,7 @@ wpa=3D3
 wpa_key_mgmt=3DWPA-EAP
 ieee8021x=3D1
 eap_server=3D1
-eap_user_file=3D/tmp/secrets/eap-user-peap-v0-mschapv2.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.80=
21x b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.8021x
index 382f86d0..a34faca6 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.8021x
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.8021x
@@ -1,12 +1,12 @@
 [Security]
 EAP-Method=3DPEAP
-EAP-Identity=3Dopen(a)identity.com
+EAP-Identity=3Dpeapv0(a)example.com
 EAP-PEAP-CACert=3D/tmp/certs/cert-ca.pem
 EAP-PEAP-ClientCert=3D/tmp/certs/cert-client.pem
 EAP-PEAP-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
 EAP-PEAP-Phase2-Method=3DMD5
-EAP-PEAP-Phase2-Identity=3Dsecure(a)identity.com
-EAP-PEAP-Phase2-Password=3Dtestpasswd
+EAP-PEAP-Phase2-Identity=3Dmd5-phase2(a)example.com
+EAP-PEAP-Phase2-Password=3DPassword
 =

 [Settings]
 AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.co=
nf b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.conf
index b92bb1ae..878602a9 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.conf
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/ssidEAP-PEAPv0-NoISK.conf
@@ -6,7 +6,7 @@ wpa=3D3
 wpa_key_mgmt=3DWPA-EAP
 ieee8021x=3D1
 eap_server=3D1
-eap_user_file=3D/tmp/secrets/eap-user-peap-v0.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-PWD/IWD-Frag/main.conf b/autotests/testEAP-P=
WD/IWD-Frag/main.conf
deleted file mode 100644
index 161764bf..00000000
--- a/autotests/testEAP-PWD/IWD-Frag/main.conf
+++ /dev/null
@@ -1,2 +0,0 @@
-[EAP]
-MTU=3D40
diff --git a/autotests/testEAP-PWD/connection_test.py b/autotests/testEAP-P=
WD/connection_test.py
deleted file mode 100644
index c7ca89af..00000000
--- a/autotests/testEAP-PWD/connection_test.py
+++ /dev/null
@@ -1,70 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-
-from hostapd import HostapdCLI
-
-class Test(unittest.TestCase):
-
-    def validate_connection(self, wd):
-        hostapd =3D HostapdCLI(config=3D'ssidEAP-PWD.conf')
-
-        self.assertIsNotNone(hostapd)
-
-        psk_agent =3D PSKAgent('eap-pwd-identity', ('eap-pwd-identity',
-                                                                  'secret1=
23'))
-        wd.register_psk_agent(psk_agent)
-
-        devices =3D wd.list_devices(1)
-        self.assertIsNotNone(devices)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-PWD')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        hostapd.eapol_reauth(device.address)
-
-        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
-        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        wd.unregister_psk_agent(psk_agent)
-
-    def test_connection_success(self):
-        wd =3D IWD(True)
-
-        self.validate_connection(wd)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-PWD.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-PWD/frag_test.py b/autotests/testEAP-PWD/fra=
g_test.py
deleted file mode 100644
index 668beb4b..00000000
--- a/autotests/testEAP-PWD/frag_test.py
+++ /dev/null
@@ -1,49 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-
-class Test(unittest.TestCase):
-
-    def validate_connection(self, wd):
-        devices =3D wd.list_devices(1)
-        self.assertIsNotNone(devices)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-PWD-frag')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    def test_connection_success(self):
-        wd =3D IWD(True)
-
-        self.validate_connection(wd)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-PWD-frag.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-PWD/hw.conf b/autotests/testEAP-PWD/hw.conf
deleted file mode 100644
index 40427c13..00000000
--- a/autotests/testEAP-PWD/hw.conf
+++ /dev/null
@@ -1,7 +0,0 @@
-[SETUP]
-num_radios=3D3
-start_iwd=3D0
-
-[HOSTAPD]
-rad0=3DssidEAP-PWD.conf
-rad1=3DssidEAP-PWD-frag.conf
diff --git a/autotests/testEAP-PWD/pwd.eap_user b/autotests/testEAP-PWD/pwd=
.eap_user
deleted file mode 100644
index 4ce84c87..00000000
--- a/autotests/testEAP-PWD/pwd.eap_user
+++ /dev/null
@@ -1 +0,0 @@
-"eap-pwd-identity"	PWD     "secret123"
diff --git a/autotests/testEAP-PWD/ssidEAP-PWD-frag.8021x b/autotests/testE=
AP-PWD/ssidEAP-PWD-frag.8021x
deleted file mode 100644
index e5c3fedb..00000000
--- a/autotests/testEAP-PWD/ssidEAP-PWD-frag.8021x
+++ /dev/null
@@ -1,7 +0,0 @@
-[Security]
-EAP-Method=3DPWD
-EAP-Identity=3Deap-pwd-identity
-EAP-Password=3Dsecret123
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PWD/ssidEAP-PWD-frag.conf b/autotests/testEA=
P-PWD/ssidEAP-PWD-frag.conf
deleted file mode 100644
index f07375dc..00000000
--- a/autotests/testEAP-PWD/ssidEAP-PWD-frag.conf
+++ /dev/null
@@ -1,16 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-
-driver=3Dnl80211
-ieee8021x=3D1
-eap_server=3D1
-ssid=3DssidEAP-PWD-frag
-eap_user_file=3D/tmp/pwd.eap_user
-wpa=3D2
-wpa_key_mgmt=3DWPA-EAP
-wpa_pairwise=3DTKIP CCMP
-rsn_pairwise=3DCCMP TKIP
-wpa_passphrase=3Dsecret123
-channel=3D1
-pwd_group=3D19
-fragment_size=3D80
diff --git a/autotests/testEAP-PWD/ssidEAP-PWD.8021x b/autotests/testEAP-PW=
D/ssidEAP-PWD.8021x
deleted file mode 100644
index d325acea..00000000
--- a/autotests/testEAP-PWD/ssidEAP-PWD.8021x
+++ /dev/null
@@ -1,6 +0,0 @@
-[Security]
-EAP-Method=3DPWD
-EAP-Identity=3Deap-pwd-identity
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-PWD/ssidEAP-PWD.conf b/autotests/testEAP-PWD=
/ssidEAP-PWD.conf
deleted file mode 100644
index 54b1d834..00000000
--- a/autotests/testEAP-PWD/ssidEAP-PWD.conf
+++ /dev/null
@@ -1,15 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-
-driver=3Dnl80211
-ieee8021x=3D1
-eap_server=3D1
-ssid=3DssidEAP-PWD
-eap_user_file=3D/tmp/pwd.eap_user
-wpa=3D2
-wpa_key_mgmt=3DWPA-EAP
-wpa_pairwise=3DTKIP CCMP
-rsn_pairwise=3DCCMP TKIP
-wpa_passphrase=3Dsecret123
-
-pwd_group=3D20
diff --git a/autotests/testEAP-SIM-ofono/connection_test.py b/autotests/tes=
tEAP-SIM-ofono/connection_test.py
deleted file mode 100644
index b66bc9c7..00000000
--- a/autotests/testEAP-SIM-ofono/connection_test.py
+++ /dev/null
@@ -1,60 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-from hlrauc import AuthCenter
-from ofono import Ofono
-from config import ctx
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        ofono =3D Ofono()
-        ofono.enable_modem('/phonesim')
-        ofono.wait_for_sim_auth()
-
-        wd =3D IWD()
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-SIM')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    @classmethod
-    def setUpClass(cls):
-        if not ctx.is_process_running('ofonod'):
-            cls.skipTest(cls, "ofono not running")
-
-        IWD.copy_to_storage('ssidEAP-SIM.8021x')
-
-        cls.auth =3D AuthCenter('/tmp/hlrauc.sock', '/tmp/sim.db')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-        cls.auth.stop()
-        cls.auth =3D None
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-SIM-ofono/hw.conf b/autotests/testEAP-SIM-of=
ono/hw.conf
deleted file mode 100644
index 0255b153..00000000
--- a/autotests/testEAP-SIM-ofono/hw.conf
+++ /dev/null
@@ -1,6 +0,0 @@
-[SETUP]
-num_radios=3D2
-sim_keys=3Dofono
-
-[HOSTAPD]
-rad0=3DssidEAP-SIM.conf
diff --git a/autotests/testEAP-SIM-ofono/sim.db b/autotests/testEAP-SIM-ofo=
no/sim.db
deleted file mode 100644
index d1aaff15..00000000
--- a/autotests/testEAP-SIM-ofono/sim.db
+++ /dev/null
@@ -1 +0,0 @@
-12345678:673fb8cd35f98800:1fb1e3b5:DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
\ No newline at end of file
diff --git a/autotests/testEAP-SIM-ofono/sim.eap_user b/autotests/testEAP-S=
IM-ofono/sim.eap_user
deleted file mode 100644
index 46d8bd8e..00000000
--- a/autotests/testEAP-SIM-ofono/sim.eap_user
+++ /dev/null
@@ -1 +0,0 @@
-"112345678(a)phonesim.org"	SIM
\ No newline at end of file
diff --git a/autotests/testEAP-SIM-ofono/ssidEAP-SIM.8021x b/autotests/test=
EAP-SIM-ofono/ssidEAP-SIM.8021x
deleted file mode 100644
index 1dcdbcb6..00000000
--- a/autotests/testEAP-SIM-ofono/ssidEAP-SIM.8021x
+++ /dev/null
@@ -1,5 +0,0 @@
-[Security]
-EAP-Method=3DSIM
-
-[Settings]
-AutoConnect=3Dfalse
diff --git a/autotests/testEAP-SIM-ofono/ssidEAP-SIM.conf b/autotests/testE=
AP-SIM-ofono/ssidEAP-SIM.conf
deleted file mode 100644
index 6071e301..00000000
--- a/autotests/testEAP-SIM-ofono/ssidEAP-SIM.conf
+++ /dev/null
@@ -1,16 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-
-driver=3Dnl80211
-ieee8021x=3D1
-eap_server=3D1
-ssid=3DssidEAP-SIM
-eap_user_file=3D/tmp/sim.eap_user
-eap_sim_db=3Dunix:/tmp/hlrauc.sock
-wpa=3D2
-wpa_key_mgmt=3DWPA-EAP
-wpa_pairwise=3DTKIP CCMP
-rsn_pairwise=3DCCMP TKIP
-wpa_passphrase=3Dsecret123
-channel=3D1
-eap_sim_aka_result_ind=3D1
diff --git a/autotests/testEAP-TLS-Frag/ssidEAP-TLS.8021x b/autotests/testE=
AP-TLS-Frag/ssidEAP-TLS.8021x
index 7908545f..88c622ad 100644
--- a/autotests/testEAP-TLS-Frag/ssidEAP-TLS.8021x
+++ b/autotests/testEAP-TLS-Frag/ssidEAP-TLS.8021x
@@ -3,7 +3,7 @@ EAP-Method=3DTLS
 EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
 EAP-TLS-ClientCert=3D/tmp/certs/cert-client.pem
 EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-Identity=3Dabc(a)example.com
+EAP-Identity=3Dtls(a)example.com
 =

 [Settings]
 AutoConnect=3DFalse
diff --git a/autotests/testEAP-TLS-Frag/ssidEAP-TLS.conf b/autotests/testEA=
P-TLS-Frag/ssidEAP-TLS.conf
index 445e4d80..64ab9677 100644
--- a/autotests/testEAP-TLS-Frag/ssidEAP-TLS.conf
+++ b/autotests/testEAP-TLS-Frag/ssidEAP-TLS.conf
@@ -8,7 +8,7 @@ wpa=3D3
 wpa_key_mgmt=3DWPA-EAP
 ieee8021x=3D1
 eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TLS-embedded-pems/connection_test.py b/autot=
ests/testEAP-TLS-embedded-pems/connection_test.py
deleted file mode 100644
index 1ca2bed4..00000000
--- a/autotests/testEAP-TLS-embedded-pems/connection_test.py
+++ /dev/null
@@ -1,62 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-import testutil
-from hostapd import HostapdCLI
-
-class Test(unittest.TestCase):
-
-    def do_test_connection_success(self, ssid, passphrase=3DNone):
-        hostapd =3D HostapdCLI(config=3Dssid + '.conf')
-        wd =3D IWD()
-
-        if passphrase:
-            psk_agent =3D PSKAgent(passphrase)
-            wd.register_psk_agent(psk_agent)
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network(ssid)
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        testutil.test_iface_operstate()
-        testutil.test_ifaces_connected(hostapd.ifname, device.name)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        if passphrase:
-            wd.unregister_psk_agent(psk_agent)
-
-    def test_eap_tls(self):
-        self.do_test_connection_success('ssidEAP-TLS')
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-TLS.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-TLS-embedded-pems/hw.conf b/autotests/testEA=
P-TLS-embedded-pems/hw.conf
deleted file mode 100644
index fba8466c..00000000
--- a/autotests/testEAP-TLS-embedded-pems/hw.conf
+++ /dev/null
@@ -1,5 +0,0 @@
-[SETUP]
-num_radios=3D2
-
-[HOSTAPD]
-rad0=3DssidEAP-TLS.conf
diff --git a/autotests/testEAP-TLS-embedded-pems/ssidEAP-TLS.8021x b/autote=
sts/testEAP-TLS-embedded-pems/ssidEAP-TLS.8021x
deleted file mode 100644
index 9de9e081..00000000
--- a/autotests/testEAP-TLS-embedded-pems/ssidEAP-TLS.8021x
+++ /dev/null
@@ -1,94 +0,0 @@
-[Security]
-EAP-Method=3DTLS
-EAP-TLS-CACert=3Dembed:cert_ca
-EAP-TLS-ClientCert=3Dembed:cert_client
-EAP-TLS-ClientKey=3Dembed:cert_client_key
-EAP-Identity=3Dabc(a)example.com
-
-[@pem(a)cert_ca]
------BEGIN CERTIFICATE-----
-MIIEVDCCAzygAwIBAgIJAJmt2W7CutHvMA0GCSqGSIb3DQEBCwUAMHgxNTAzBgNV
-BAoMLEludGVybmF0aW9uYWwgVW5pb24gb2YgRXhhbXBsZSBPcmdhbml6YXRpb25z
-MR8wHQYDVQQDDBZDZXJ0aWZpY2F0ZSBpc3N1ZXIgZ3V5MR4wHAYJKoZIhvcNAQkB
-Fg9jYUBtYWlsLmV4YW1wbGUwHhcNMTYwNTE3MjEyMDQ2WhcNNDMxMDAzMjEyMDQ2
-WjB4MTUwMwYDVQQKDCxJbnRlcm5hdGlvbmFsIFVuaW9uIG9mIEV4YW1wbGUgT3Jn
-YW5pemF0aW9uczEfMB0GA1UEAwwWQ2VydGlmaWNhdGUgaXNzdWVyIGd1eTEeMBwG
-CSqGSIb3DQEJARYPY2FAbWFpbC5leGFtcGxlMIIBIjANBgkqhkiG9w0BAQEFAAOC
-AQ8AMIIBCgKCAQEAo3GrGqW49h8kY2Wx/1kd5dIkYGazuWrX93ma9904hHBJNsvu
-V34QfHVln6wDpMZMwuvkfct09kl0rQpztJzA9YL4GMdmV6+6J6LiX1kMqLkNaJa+
-Ov+ECG5ypBRbSTYKpqFsc5wPOQf/N8brBiZS1v67va3fCwO6dgLeAf7dZ3Q70oUr
-mghbK8UnlC+wLShxCBAW8TUKg7B7M5Gea794CO9wH7NsFyAr963WVcLxrdL3xMHZ
-9hcscrljh35nCAc6sum1cTtWI651OGehr0Bhp2o2Exgr2mbo5TobqEW+fe4gc4ik
-0nzHGWiOVaszUcvpeeduGV3y6om93atffeKuxQIDAQABo4HgMIHdMA8GA1UdEwQI
-MAYBAf8CAQAwHQYDVR0OBBYEFO+M3tJAELTnseUqZyP4vl5X7SmUMIGqBgNVHSME
-gaIwgZ+AFO+M3tJAELTnseUqZyP4vl5X7SmUoXykejB4MTUwMwYDVQQKDCxJbnRl
-cm5hdGlvbmFsIFVuaW9uIG9mIEV4YW1wbGUgT3JnYW5pemF0aW9uczEfMB0GA1UE
-AwwWQ2VydGlmaWNhdGUgaXNzdWVyIGd1eTEeMBwGCSqGSIb3DQEJARYPY2FAbWFp
-bC5leGFtcGxlggkAma3ZbsK60e8wDQYJKoZIhvcNAQELBQADggEBAA/Yb9jB94OF
-swbyCrA6Qe53YGC4dfqrKGRThtGKTrH0XcM2x2qLIIbiNDogwhRqlUW8iNY6Dm2k
-43mJzNsYhy7Nt3IJFCguTJFilfGzQnBtK8wCr/C9qsj//BESOIlo/TDZ2Ho4ixcJ
-n+FTnN34F6JJ0DIvA6tNBe1kUFSrbubL8ygNWJ9BKMebEzokGNGCGFNr70DlQj2o
-1EOMMOkj0gWO0WegAYFLojzag3l+uvU59YE+/fbZ2iclyvbF7IutQ5M9g5TnQE6F
-f+qFKR5+bhlJwry6vLl/6ulihkvF3y1bm7zae62zbFaZRU6PJUl1DtXiA23ZTm9T
-VDivqs07R84=3D
------END CERTIFICATE-----
-
-[@pem(a)cert_client]
------BEGIN CERTIFICATE-----
-MIIEPTCCAyWgAwIBAgIJAPk7rut4SWQCMA0GCSqGSIb3DQEBCwUAMHgxNTAzBgNV
-BAoMLEludGVybmF0aW9uYWwgVW5pb24gb2YgRXhhbXBsZSBPcmdhbml6YXRpb25z
-MR8wHQYDVQQDDBZDZXJ0aWZpY2F0ZSBpc3N1ZXIgZ3V5MR4wHAYJKoZIhvcNAQkB
-Fg9jYUBtYWlsLmV4YW1wbGUwHhcNMTYwNTE3MjEyMDQ3WhcNNDMxMDAzMjEyMDQ3
-WjBnMSEwHwYDVQQKDBhCYXIgRXhhbXBsZSBPcmdhbml6YXRpb24xITAfBgNVBAMM
-GEJhciBFeGFtcGxlIE9yZ2FuaXphdGlvbjEfMB0GCSqGSIb3DQEJARYQYmFyQG1h
-aWwuZXhhbXBsZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAOE5D/lU
-haTC3xL281ttZPRURXlKJqLwcHGXQSuQm6wwYWtAhLyMLEHrryE0oChKdw3eV7Nn
-/IODxvk1S8uIuKfHWuNd5qX/yu7CjCWvyim2CSJHF24rQFmb9ePoddOZnDMMAIz7
-PC325JVhbr/LSBLbqhZ0smHy1HKyrzzHHzKU4YcTH/3+3H4MHZwnNZfbfG5qhRZG
-Nuu/8t+AWVcEocPRGYZpzWJNq6AAzojAHSSOxxiscBMiuQ+BdofPw9XhwpS+Fstk
-rvF8J9FfZj5U3FOm/EgOQn8efnrUL231PqB1R9PIKYv/938p3iDMIi0ETiKi5ced
-WV8m2PcykPdNOKMCAwEAAaOB2jCB1zAJBgNVHRMEAjAAMB0GA1UdDgQWBBTs9eey
-OkMw3uiPpDOa3b9KErbEfzCBqgYDVR0jBIGiMIGfgBTvjN7SQBC057HlKmcj+L5e
-V+0plKF8pHoweDE1MDMGA1UECgwsSW50ZXJuYXRpb25hbCBVbmlvbiBvZiBFeGFt
-cGxlIE9yZ2FuaXphdGlvbnMxHzAdBgNVBAMMFkNlcnRpZmljYXRlIGlzc3VlciBn
-dXkxHjAcBgkqhkiG9w0BCQEWD2NhQG1haWwuZXhhbXBsZYIJAJmt2W7CutHvMA0G
-CSqGSIb3DQEBCwUAA4IBAQA8MxPjU2h5gwntQeSs8eeaEUILMkoU6JSDS4s5Hex5
-xYMLfcSoPPI0E6ahvKtWkSM0UZThyWsulSDTI1EgAiebjms06m1Ogh9V+0VbcOlQ
-D/k3+fSRIiyY+v3J/h8ArUby+m5O2g1TgECr/nZl4avoAI0RpBi3lH6tC8GQYdbc
-SA6hpNCM/dY3LWtAo2W6mdE8+RlCuTj4VZiQ1g6GE77t6XwDFL6vQBzLLXrinvXK
-Ha+IssV5sGdpH9bVFWIJV2q3OZuv3HLhQfGmeUrGyWVcokQQ8d6kRwg65Zb1+KT2
-bNlVKhPAMBk4ayEocpqFIfqfCKDjGdPUruIh8IVDc684
------END CERTIFICATE-----
-
-[@pem(a)cert_client_key]
------BEGIN PRIVATE KEY-----
-MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDhOQ/5VIWkwt8S
-9vNbbWT0VEV5Siai8HBxl0ErkJusMGFrQIS8jCxB668hNKAoSncN3lezZ/yDg8b5
-NUvLiLinx1rjXeal/8ruwowlr8optgkiRxduK0BZm/Xj6HXTmZwzDACM+zwt9uSV
-YW6/y0gS26oWdLJh8tRysq88xx8ylOGHEx/9/tx+DB2cJzWX23xuaoUWRjbrv/Lf
-gFlXBKHD0RmGac1iTaugAM6IwB0kjscYrHATIrkPgXaHz8PV4cKUvhbLZK7xfCfR
-X2Y+VNxTpvxIDkJ/Hn561C9t9T6gdUfTyCmL//d/Kd4gzCItBE4iouXHnVlfJtj3
-MpD3TTijAgMBAAECggEBAIbg9YAL7j1NtupUmkkWqm7oSPLqRVkvRSfBvXWplJD6
-KF1itht0lsyjqK3qJj/62HGlxj/a9o6MTIzSLiImLu/Lo9KmWYrwNUfnmqa3MArq
-yW2NxapknJUNoaRrgqTGSZUIiwvjKZcdVKdhQkH6K5+fja0FFg8yrahC+k8bsMNI
-5mw8NwRdR3SvHJWHCLfKCQ31tju7On/4C6jr0siUCc2//W+SO5c+FHDY1bma02cp
-jXTEiFpw91YcyKxiADIaH9/qfxWdefxqYg1WlUeXF3jYt5xYnYr34qKW1gOZ3jy1
-QJ3esn382ZTml3TFZWy+g9tkYyOSgmDwQZbLk/ppBAECgYEA8RzLBFwP018ieMBv
-khDtwcKk6ZihkWZxEPQPuUljWzzAHn/f3dXOcrfmflAKeoDEeYDimDYDizTLDPC4
-zmWkMJHNadcM5H065BbGVFQWXo47ltccfIlB/1vzG8aywfJ/yNfHvH87wbH2eg6N
-yOr+96ZjLJszQ+Rv189BbXDzTcMCgYEA7yEbUL/A1J0l2kLoYyS0vfVa7AyBVOFW
-vPgfkF7HdNpIiFWlukMr+DWOolaoZp5iHqQXFwJsL8qCcrbZuHbaNHAI/5vDE9xG
-fh8KzrfBrjIPIyNm6EWpsBo5unXK+wTeqIAGKdzDo5Q3zEE6G5DkkHItKA7yjPOM
-gz/b/MR3W6ECgYBBv3dA3hXWrreIs/j4nLMoxfoQVPWh34xvcg4jmXaFd6Bv8LDM
-HjRopestgIgK9bgd5d5kYT5AJIpGIhJS/fZy5B9egCzc1aVMc0Vr024yJJjtPgVf
-lFIx3xIA/gLazlS4INcveIaEABJVIEjbg/E4+N9MV5n4Jn+1GqgdvtIp3wKBgQC0
-C3lFkxrc+nVFoJrYCwsK+3E5yTCXeBKWtTsOuE307WUvQU1GsMyqVajPEfA5U4cN
-Cv9Xk7thQFh3hrTm7pXcZX5g9iYrDe8FhtncSv7I6Wf8TOtudwUMUrKkcYwi88ex
-lrMNUer7ft2ELJhTqQRuvYjCYH6/IaDqMWqxJju4AQKBgQDPjOh75ykQc93SsYpt
-Tb4gQKLeqOb57pofT8D44DccatfEgk31D4fBIIQu6XKopQmCtQyX9DUDjOWFTxuo
-IMPysN6Fh1quCbC6Xt5xfKoaJG5yQYKeKtLhknwEW9SUifU2xVrOcPikLs7Iwmmp
-BkDLsu/YKwRFSfrbYZXbTlU8tQ=3D=3D
------END PRIVATE KEY-----
-
-[Settings]
-AutoConnect=3DFalse
diff --git a/autotests/testEAP-TLS-embedded-pems/ssidEAP-TLS.conf b/autotes=
ts/testEAP-TLS-embedded-pems/ssidEAP-TLS.conf
deleted file mode 100644
index e1d7c6b4..00000000
--- a/autotests/testEAP-TLS-embedded-pems/ssidEAP-TLS.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-TLS
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TLS/connection_test.py b/autotests/testEAP-T=
LS/connection_test.py
deleted file mode 100644
index ab096e72..00000000
--- a/autotests/testEAP-TLS/connection_test.py
+++ /dev/null
@@ -1,74 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-import testutil
-from hostapd import HostapdCLI
-
-class Test(unittest.TestCase):
-
-    def do_test_connection_success(self, ssid, passphrase=3DNone):
-        hapd =3D HostapdCLI(config=3Dssid + '.conf')
-        wd =3D IWD()
-
-        if passphrase:
-            psk_agent =3D PSKAgent(passphrase)
-            wd.register_psk_agent(psk_agent)
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network(ssid)
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        testutil.test_iface_operstate()
-        testutil.test_ifaces_connected(hapd.ifname, device.name)
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        if passphrase:
-            wd.unregister_psk_agent(psk_agent)
-
-    def test_eap_tls(self):
-        self.do_test_connection_success('ssidEAP-TLS')
-
-    def test_eap_tls2(self):
-        self.do_test_connection_success('ssidEAP-TLS2')
-
-    def test_eap_tls3(self):
-        self.do_test_connection_success('ssidEAP-TLS3', 'abc')
-
-    def test_eap_tls4(self):
-        self.do_test_connection_success('ssidEAP-TLS4')
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-TLS.8021x')
-        IWD.copy_to_storage('ssidEAP-TLS2.8021x')
-        IWD.copy_to_storage('ssidEAP-TLS3.8021x')
-        IWD.copy_to_storage('ssidEAP-TLS4.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-TLS/hw.conf b/autotests/testEAP-TLS/hw.conf
deleted file mode 100644
index 03ded83a..00000000
--- a/autotests/testEAP-TLS/hw.conf
+++ /dev/null
@@ -1,8 +0,0 @@
-[SETUP]
-num_radios=3D5
-
-[HOSTAPD]
-rad0=3DssidEAP-TLS.conf
-rad1=3DssidEAP-TLS2.conf
-rad2=3DssidEAP-TLS3.conf
-rad3=3DssidEAP-TLS4.conf
diff --git a/autotests/testEAP-TLS/ssidEAP-TLS.8021x b/autotests/testEAP-TL=
S/ssidEAP-TLS.8021x
deleted file mode 100644
index 7908545f..00000000
--- a/autotests/testEAP-TLS/ssidEAP-TLS.8021x
+++ /dev/null
@@ -1,9 +0,0 @@
-[Security]
-EAP-Method=3DTLS
-EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
-EAP-TLS-ClientCert=3D/tmp/certs/cert-client.pem
-EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-Identity=3Dabc(a)example.com
-
-[Settings]
-AutoConnect=3DFalse
diff --git a/autotests/testEAP-TLS/ssidEAP-TLS.conf b/autotests/testEAP-TLS=
/ssidEAP-TLS.conf
deleted file mode 100644
index b14ea423..00000000
--- a/autotests/testEAP-TLS/ssidEAP-TLS.conf
+++ /dev/null
@@ -1,13 +0,0 @@
-ctrl_interface=3D/var/run/hostapd
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-TLS
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TLS/ssidEAP-TLS2.8021x b/autotests/testEAP-T=
LS/ssidEAP-TLS2.8021x
deleted file mode 100644
index 3f5b0012..00000000
--- a/autotests/testEAP-TLS/ssidEAP-TLS2.8021x
+++ /dev/null
@@ -1,10 +0,0 @@
-[Security]
-EAP-Method=3DTLS
-EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
-EAP-TLS-ClientCert=3D/tmp/certs/cert-client.pem
-EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-md5-des.pem
-EAP-TLS-ClientKeyPassphrase=3Dabc
-EAP-Identity=3Dabc(a)example.com
-
-[Settings]
-AutoConnect=3DFalse
diff --git a/autotests/testEAP-TLS/ssidEAP-TLS2.conf b/autotests/testEAP-TL=
S/ssidEAP-TLS2.conf
deleted file mode 100644
index 6a811deb..00000000
--- a/autotests/testEAP-TLS/ssidEAP-TLS2.conf
+++ /dev/null
@@ -1,13 +0,0 @@
-ctrl_interface=3D/var/run/hostapd
-hw_mode=3Dg
-channel=3D2
-ssid=3DssidEAP-TLS2
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TLS/ssidEAP-TLS3.8021x b/autotests/testEAP-T=
LS/ssidEAP-TLS3.8021x
deleted file mode 100644
index 03d571e9..00000000
--- a/autotests/testEAP-TLS/ssidEAP-TLS3.8021x
+++ /dev/null
@@ -1,9 +0,0 @@
-[Security]
-EAP-Method=3DTLS
-EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
-EAP-TLS-ClientCert=3D/tmp/certs/cert-client.crt
-EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-v2-des-ede3.pem
-EAP-Identity=3Dabc(a)example.com
-
-[Settings]
-AutoConnect=3DFalse
diff --git a/autotests/testEAP-TLS/ssidEAP-TLS3.conf b/autotests/testEAP-TL=
S/ssidEAP-TLS3.conf
deleted file mode 100644
index 3a5f70bf..00000000
--- a/autotests/testEAP-TLS/ssidEAP-TLS3.conf
+++ /dev/null
@@ -1,13 +0,0 @@
-ctrl_interface=3D/var/run/hostapd
-hw_mode=3Dg
-channel=3D3
-ssid=3DssidEAP-TLS3
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TLS/ssidEAP-TLS4.8021x b/autotests/testEAP-T=
LS/ssidEAP-TLS4.8021x
deleted file mode 100644
index 61523310..00000000
--- a/autotests/testEAP-TLS/ssidEAP-TLS4.8021x
+++ /dev/null
@@ -1,9 +0,0 @@
-[Security]
-EAP-Method=3DTLS
-EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
-EAP-TLS-ClientKeyBundle=3D/tmp/certs/cert-client.p12
-EAP-TLS-ClientKeyPassphrase=3Dabc
-EAP-Identity=3Dabc(a)example.com
-
-[Settings]
-AutoConnect=3DFalse
diff --git a/autotests/testEAP-TLS/ssidEAP-TLS4.conf b/autotests/testEAP-TL=
S/ssidEAP-TLS4.conf
deleted file mode 100644
index 41c63c95..00000000
--- a/autotests/testEAP-TLS/ssidEAP-TLS4.conf
+++ /dev/null
@@ -1,13 +0,0 @@
-ctrl_interface=3D/var/run/hostapd
-hw_mode=3Dg
-channel=3D4
-ssid=3DssidEAP-TLS4
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TLSwithMFPC/ssidEAP-TLS.8021x b/autotests/te=
stEAP-TLSwithMFPC/ssidEAP-TLS.8021x
index 7908545f..88c622ad 100644
--- a/autotests/testEAP-TLSwithMFPC/ssidEAP-TLS.8021x
+++ b/autotests/testEAP-TLSwithMFPC/ssidEAP-TLS.8021x
@@ -3,7 +3,7 @@ EAP-Method=3DTLS
 EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
 EAP-TLS-ClientCert=3D/tmp/certs/cert-client.pem
 EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-Identity=3Dabc(a)example.com
+EAP-Identity=3Dtls(a)example.com
 =

 [Settings]
 AutoConnect=3DFalse
diff --git a/autotests/testEAP-TLSwithMFPC/ssidEAP-TLS.conf b/autotests/tes=
tEAP-TLSwithMFPC/ssidEAP-TLS.conf
index f97a7294..2ffd41be 100644
--- a/autotests/testEAP-TLSwithMFPC/ssidEAP-TLS.conf
+++ b/autotests/testEAP-TLSwithMFPC/ssidEAP-TLS.conf
@@ -5,7 +5,7 @@ ssid=3DssidEAP-TLS
 wpa=3D2
 ieee8021x=3D1
 eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TLSwithMFPR/ssidEAP-TLS.8021x b/autotests/te=
stEAP-TLSwithMFPR/ssidEAP-TLS.8021x
index 7908545f..88c622ad 100644
--- a/autotests/testEAP-TLSwithMFPR/ssidEAP-TLS.8021x
+++ b/autotests/testEAP-TLSwithMFPR/ssidEAP-TLS.8021x
@@ -3,7 +3,7 @@ EAP-Method=3DTLS
 EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
 EAP-TLS-ClientCert=3D/tmp/certs/cert-client.pem
 EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-Identity=3Dabc(a)example.com
+EAP-Identity=3Dtls(a)example.com
 =

 [Settings]
 AutoConnect=3DFalse
diff --git a/autotests/testEAP-TLSwithMFPR/ssidEAP-TLS.conf b/autotests/tes=
tEAP-TLSwithMFPR/ssidEAP-TLS.conf
index 28d5d5eb..7653dbe6 100644
--- a/autotests/testEAP-TLSwithMFPR/ssidEAP-TLS.conf
+++ b/autotests/testEAP-TLSwithMFPR/ssidEAP-TLS.conf
@@ -5,7 +5,7 @@ ssid=3DssidEAP-TLS
 wpa=3D2
 ieee8021x=3D1
 eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TTLS-CHAP/connection_test.py b/autotests/tes=
tEAP-TTLS-CHAP/connection_test.py
deleted file mode 100644
index 0cbe251f..00000000
--- a/autotests/testEAP-TTLS-CHAP/connection_test.py
+++ /dev/null
@@ -1,68 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-import testutil
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-
-from hostapd import HostapdCLI
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        hostapd =3D HostapdCLI(config=3D'ssidEAP-TTLS-CHAP.conf')
-
-        self.assertIsNotNone(hostapd)
-
-        wd =3D IWD()
-
-        psk_agent =3D PSKAgent('abc', ('user', 'testpasswd'))
-        wd.register_psk_agent(psk_agent)
-
-        device =3D wd.list_devices(1)[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-TTLS-CHAP')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        hostapd.eapol_reauth(device.address)
-
-        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
-        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        testutil.test_iface_operstate()
-        testutil.test_ifaces_connected()
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        wd.unregister_psk_agent(psk_agent)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-TTLS-CHAP.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-TTLS-CHAP/eap-user-ttls-chap.text b/autotest=
s/testEAP-TTLS-CHAP/eap-user-ttls-chap.text
deleted file mode 100644
index b10868ad..00000000
--- a/autotests/testEAP-TTLS-CHAP/eap-user-ttls-chap.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-* TTLS
-# Phase 2
-"user" TTLS-CHAP "testpasswd" [2]
diff --git a/autotests/testEAP-TTLS-CHAP/hw.conf b/autotests/testEAP-TTLS-C=
HAP/hw.conf
deleted file mode 100644
index c209fa4e..00000000
--- a/autotests/testEAP-TTLS-CHAP/hw.conf
+++ /dev/null
@@ -1,5 +0,0 @@
-[SETUP]
-num_radios=3D2
-
-[HOSTAPD]
-rad0=3DssidEAP-TTLS-CHAP.conf
diff --git a/autotests/testEAP-TTLS-CHAP/ssidEAP-TTLS-CHAP.8021x b/autotest=
s/testEAP-TTLS-CHAP/ssidEAP-TTLS-CHAP.8021x
deleted file mode 100644
index 5c44947a..00000000
--- a/autotests/testEAP-TTLS-CHAP/ssidEAP-TTLS-CHAP.8021x
+++ /dev/null
@@ -1,12 +0,0 @@
-[Security]
-EAP-Method=3DTTLS
-EAP-Identity=3Danonymous
-EAP-TTLS-Phase2-Method=3DTunneled-CHAP
-
-# If CHAP Identity and Password are left out, they will be requested throu=
gh
-# the agent.
-#EAP-TTLS-Phase2-Identity=3Duser
-#EAP-TTLS-Phase2-Password=3Dtestpasswd
-
-[Settings]
-AutoConnect=3DFalse
diff --git a/autotests/testEAP-TTLS-CHAP/ssidEAP-TTLS-CHAP.conf b/autotests=
/testEAP-TTLS-CHAP/ssidEAP-TTLS-CHAP.conf
deleted file mode 100644
index babf6dbd..00000000
--- a/autotests/testEAP-TTLS-CHAP/ssidEAP-TTLS-CHAP.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-TTLS-CHAP
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/eap-user-ttls-chap.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TTLS-EAP-MSCHAPV2/connection_test.py b/autot=
ests/testEAP-TTLS-EAP-MSCHAPV2/connection_test.py
deleted file mode 100644
index fcfdcb86..00000000
--- a/autotests/testEAP-TTLS-EAP-MSCHAPV2/connection_test.py
+++ /dev/null
@@ -1,55 +0,0 @@
-#! /usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-import testutil
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        wd =3D IWD()
-
-        psk_agent =3D PSKAgent('abc', ('user', 'testpasswd'))
-        wd.register_psk_agent(psk_agent)
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-TTLS')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        testutil.test_iface_operstate()
-        testutil.test_ifaces_connected()
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        wd.unregister_psk_agent(psk_agent)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-TTLS.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-TTLS-EAP-MSCHAPV2/hw.conf b/autotests/testEA=
P-TTLS-EAP-MSCHAPV2/hw.conf
deleted file mode 100644
index 8cef6a61..00000000
--- a/autotests/testEAP-TTLS-EAP-MSCHAPV2/hw.conf
+++ /dev/null
@@ -1,5 +0,0 @@
-[SETUP]
-num_radios=3D2
-
-[HOSTAPD]
-rad0=3DssidEAP-TTLS.conf
diff --git a/autotests/testEAP-TTLS-EAP-MSCHAPV2/ssidEAP-TTLS.8021x b/autot=
ests/testEAP-TTLS-EAP-MSCHAPV2/ssidEAP-TTLS.8021x
deleted file mode 100644
index b89a2671..00000000
--- a/autotests/testEAP-TTLS-EAP-MSCHAPV2/ssidEAP-TTLS.8021x
+++ /dev/null
@@ -1,8 +0,0 @@
-[Security]
-EAP-Method=3DTTLS
-EAP-Identity=3Dabc(a)example.com
-EAP-TTLS-CACert=3D/tmp/certs/cert-ca.pem
-EAP-TTLS-ClientCert=3D/tmp/certs/cert-client.pem
-EAP-TTLS-ClientKey=3D/tmp/certs/cert-client-key-v2-des-ede3.pem
-EAP-TTLS-Phase2-Method=3DMSCHAPV2
-EAP-TTLS-Phase2-Identity=3Duser
diff --git a/autotests/testEAP-TTLS-EAP-MSCHAPV2/ssidEAP-TTLS.conf b/autote=
sts/testEAP-TTLS-EAP-MSCHAPV2/ssidEAP-TTLS.conf
deleted file mode 100644
index 0803bc1e..00000000
--- a/autotests/testEAP-TTLS-EAP-MSCHAPV2/ssidEAP-TTLS.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-TTLS
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-ttls-mschapv2.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TTLS-Frag/ssidEAP-TTLS.8021x b/autotests/tes=
tEAP-TTLS-Frag/ssidEAP-TTLS.8021x
index 911490b5..f789fe42 100644
--- a/autotests/testEAP-TTLS-Frag/ssidEAP-TTLS.8021x
+++ b/autotests/testEAP-TTLS-Frag/ssidEAP-TTLS.8021x
@@ -1,12 +1,12 @@
 [Security]
 EAP-Method=3DTTLS
-EAP-Identity=3Dabc(a)example.com
+EAP-Identity=3Dttls(a)example.com
 EAP-TTLS-CACert=3D/tmp/certs/cert-ca.pem
 EAP-TTLS-ClientCert=3D/tmp/certs/cert-client.pem
 EAP-TTLS-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
 EAP-TTLS-Phase2-Method=3DMD5
-EAP-TTLS-Phase2-Identity=3Dabc(a)example.com
-EAP-TTLS-Phase2-Password=3Dtestpasswd
+EAP-TTLS-Phase2-Identity=3Dmd5-phase2(a)example.com
+EAP-TTLS-Phase2-Password=3DPassword
 =

 [Settings]
 AutoConnect=3DFalse
diff --git a/autotests/testEAP-TTLS-Frag/ssidEAP-TTLS.conf b/autotests/test=
EAP-TTLS-Frag/ssidEAP-TTLS.conf
index 8ca33599..fb177c57 100644
--- a/autotests/testEAP-TTLS-Frag/ssidEAP-TTLS.conf
+++ b/autotests/testEAP-TTLS-Frag/ssidEAP-TTLS.conf
@@ -8,7 +8,7 @@ wpa=3D3
 wpa_key_mgmt=3DWPA-EAP
 ieee8021x=3D1
 eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-ttls.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TTLS-MSCHAP/connection_test.py b/autotests/t=
estEAP-TTLS-MSCHAP/connection_test.py
deleted file mode 100644
index 4832eaae..00000000
--- a/autotests/testEAP-TTLS-MSCHAP/connection_test.py
+++ /dev/null
@@ -1,68 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-import testutil
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-
-from hostapd import HostapdCLI
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        hostapd =3D HostapdCLI(config=3D'ssidEAP-TTLS-MSCHAP.conf')
-
-        self.assertIsNotNone(hostapd)
-
-        wd =3D IWD()
-
-        psk_agent =3D PSKAgent('abc', ('user', 'testpasswd'))
-        wd.register_psk_agent(psk_agent)
-
-        device =3D wd.list_devices(1)[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-TTLS-MSCHA=
P')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        hostapd.eapol_reauth(device.address)
-
-        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
-        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        testutil.test_iface_operstate()
-        testutil.test_ifaces_connected()
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        wd.unregister_psk_agent(psk_agent)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-TTLS-MSCHAP.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-TTLS-MSCHAP/eap-user-ttls-mschap.text b/auto=
tests/testEAP-TTLS-MSCHAP/eap-user-ttls-mschap.text
deleted file mode 100644
index ddb14b93..00000000
--- a/autotests/testEAP-TTLS-MSCHAP/eap-user-ttls-mschap.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-* TTLS
-# Phase 2
-"user" TTLS-MSCHAP "testpasswd" [2]
diff --git a/autotests/testEAP-TTLS-MSCHAP/hw.conf b/autotests/testEAP-TTLS=
-MSCHAP/hw.conf
deleted file mode 100644
index cffb804b..00000000
--- a/autotests/testEAP-TTLS-MSCHAP/hw.conf
+++ /dev/null
@@ -1,5 +0,0 @@
-[SETUP]
-num_radios=3D2
-
-[HOSTAPD]
-rad0=3DssidEAP-TTLS-MSCHAP.conf
diff --git a/autotests/testEAP-TTLS-MSCHAP/ssidEAP-TTLS-MSCHAP.8021x b/auto=
tests/testEAP-TTLS-MSCHAP/ssidEAP-TTLS-MSCHAP.8021x
deleted file mode 100644
index 4eaa9a60..00000000
--- a/autotests/testEAP-TTLS-MSCHAP/ssidEAP-TTLS-MSCHAP.8021x
+++ /dev/null
@@ -1,12 +0,0 @@
-[Security]
-EAP-Method=3DTTLS
-EAP-Identity=3Danonymous
-EAP-TTLS-Phase2-Method=3DTunneled-MSCHAP
-
-# If MSCHAP Identity and Password are left out, they will be requested thr=
ough
-# the agent.
-#EAP-TTLS-Phase2-Identity=3Duser
-#EAP-TTLS-Phase2-Password=3Dtestpasswd
-
-[Settings]
-AutoConnect=3DFalse
diff --git a/autotests/testEAP-TTLS-MSCHAP/ssidEAP-TTLS-MSCHAP.conf b/autot=
ests/testEAP-TTLS-MSCHAP/ssidEAP-TTLS-MSCHAP.conf
deleted file mode 100644
index 1aef9fbe..00000000
--- a/autotests/testEAP-TTLS-MSCHAP/ssidEAP-TTLS-MSCHAP.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-TTLS-MSCHAP
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/eap-user-ttls-mschap.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py b/autotests=
/testEAP-TTLS-MSCHAPv2/connection_test.py
deleted file mode 100644
index 05f6a604..00000000
--- a/autotests/testEAP-TTLS-MSCHAPv2/connection_test.py
+++ /dev/null
@@ -1,72 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-import testutil
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-
-from hostapd import HostapdCLI
-
-class Test(unittest.TestCase):
-
-    def validate_connection(self, wd):
-        hostapd =3D HostapdCLI(config=3D'ssidEAP-TTLS-MSCHAPv2.conf')
-
-        self.assertIsNotNone(hostapd)
-
-        psk_agent =3D PSKAgent('abc', ('domain\\user', 'testpasswd'))
-        wd.register_psk_agent(psk_agent)
-
-        device =3D wd.list_devices(1)[0];
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-TTLS-MSCHA=
Pv2')
-
-        self.assertEqual(ordered_network.name, "ssidEAP-TTLS-MSCHAPv2")
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        hostapd.eapol_reauth(device.address)
-
-        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
-        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        testutil.test_iface_operstate()
-        testutil.test_ifaces_connected()
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        wd.unregister_psk_agent(psk_agent)
-
-    def test_connection_success(self):
-        wd =3D IWD(True)
-
-        self.validate_connection(wd)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-TTLS-MSCHAPv2.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-TTLS-MSCHAPv2/eap-user-ttls-mschapv2.text b/=
autotests/testEAP-TTLS-MSCHAPv2/eap-user-ttls-mschapv2.text
deleted file mode 100644
index 6acbdede..00000000
--- a/autotests/testEAP-TTLS-MSCHAPv2/eap-user-ttls-mschapv2.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-* TTLS
-# Phase 2
-"domain\user" TTLS-MSCHAPV2 "testpasswd" [2]
diff --git a/autotests/testEAP-TTLS-MSCHAPv2/failure_test.py b/autotests/te=
stEAP-TTLS-MSCHAPv2/failure_test.py
deleted file mode 100644
index 5fc4e5b9..00000000
--- a/autotests/testEAP-TTLS-MSCHAPv2/failure_test.py
+++ /dev/null
@@ -1,57 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-import testutil
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-
-from hostapd import HostapdCLI
-
-class Test(unittest.TestCase):
-
-    def validate_connection(self, wd):
-        hostapd =3D HostapdCLI(config=3D'ssidEAP-TTLS-MSCHAPv2.conf')
-
-        self.assertIsNotNone(hostapd)
-
-        psk_agent =3D PSKAgent('abc', ('user', 'incorrect_password'))
-        wd.register_psk_agent(psk_agent)
-
-        device =3D wd.list_devices(1)[0];
-
-        ordered_network =3D device.get_ordered_network("ssidEAP-TTLS-MSCHA=
Pv2")
-
-        self.assertEqual(ordered_network.name, "ssidEAP-TTLS-MSCHAPv2")
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        with self.assertRaises(iwd.FailedEx):
-            ordered_network.network_object.connect()
-
-        wd.unregister_psk_agent(psk_agent)
-
-    def test_connection_success(self):
-        wd =3D IWD(True)
-
-        try:
-            self.validate_connection(wd)
-        finally:
-            del wd
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-TTLS-MSCHAPv2.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-TTLS-MSCHAPv2/hw.conf b/autotests/testEAP-TT=
LS-MSCHAPv2/hw.conf
deleted file mode 100644
index 856678b6..00000000
--- a/autotests/testEAP-TTLS-MSCHAPv2/hw.conf
+++ /dev/null
@@ -1,6 +0,0 @@
-[SETUP]
-num_radios=3D2
-start_iwd=3DFalse
-
-[HOSTAPD]
-rad0=3DssidEAP-TTLS-MSCHAPv2.conf
diff --git a/autotests/testEAP-TTLS-MSCHAPv2/ssidEAP-TTLS-MSCHAPv2.8021x b/=
autotests/testEAP-TTLS-MSCHAPv2/ssidEAP-TTLS-MSCHAPv2.8021x
deleted file mode 100644
index cafc4b5f..00000000
--- a/autotests/testEAP-TTLS-MSCHAPv2/ssidEAP-TTLS-MSCHAPv2.8021x
+++ /dev/null
@@ -1,12 +0,0 @@
-[Security]
-EAP-Method=3DTTLS
-EAP-Identity=3Danonymous
-EAP-TTLS-Phase2-Method=3DTunneled-MSCHAPv2
-
-# If MSCHAP Identity and Password are left out, they will be requested thr=
ough
-# the agent.
-#EAP-TTLS-Phase2-Identity=3Duser
-#EAP-TTLS-Phase2-Password=3Dtestpasswd
-
-[Settings]
-AutoConnect=3DFalse
diff --git a/autotests/testEAP-TTLS-MSCHAPv2/ssidEAP-TTLS-MSCHAPv2.conf b/a=
utotests/testEAP-TTLS-MSCHAPv2/ssidEAP-TTLS-MSCHAPv2.conf
deleted file mode 100644
index 968589e4..00000000
--- a/autotests/testEAP-TTLS-MSCHAPv2/ssidEAP-TTLS-MSCHAPv2.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-TTLS-MSCHAPv2
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/eap-user-ttls-mschapv2.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TTLS-PAP/connection_test.py b/autotests/test=
EAP-TTLS-PAP/connection_test.py
deleted file mode 100644
index 91835642..00000000
--- a/autotests/testEAP-TTLS-PAP/connection_test.py
+++ /dev/null
@@ -1,68 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-import testutil
-from iwd import IWD
-from iwd import PSKAgent
-from iwd import NetworkType
-
-from hostapd import HostapdCLI
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        hostapd =3D HostapdCLI(config=3D'ssidEAP-TTLS-PAP.conf')
-
-        self.assertIsNotNone(hostapd)
-
-        wd =3D IWD()
-
-        psk_agent =3D PSKAgent('abc', ('user', 'testpasswd'))
-        wd.register_psk_agent(psk_agent)
-
-        device =3D wd.list_devices(1)[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-TTLS-PAP')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        hostapd.eapol_reauth(device.address)
-
-        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
-        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        testutil.test_iface_operstate()
-        testutil.test_ifaces_connected()
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        wd.unregister_psk_agent(psk_agent)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-TTLS-PAP.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-TTLS-PAP/eap-user-ttls-pap.text b/autotests/=
testEAP-TTLS-PAP/eap-user-ttls-pap.text
deleted file mode 100644
index 76b39b59..00000000
--- a/autotests/testEAP-TTLS-PAP/eap-user-ttls-pap.text
+++ /dev/null
@@ -1,4 +0,0 @@
-# Phase 1 users
-* TTLS
-# Phase 2
-"user" TTLS-PAP "testpasswd" [2]
diff --git a/autotests/testEAP-TTLS-PAP/hw.conf b/autotests/testEAP-TTLS-PA=
P/hw.conf
deleted file mode 100644
index dccfb229..00000000
--- a/autotests/testEAP-TTLS-PAP/hw.conf
+++ /dev/null
@@ -1,5 +0,0 @@
-[SETUP]
-num_radios=3D2
-
-[HOSTAPD]
-rad0=3DssidEAP-TTLS-PAP.conf
diff --git a/autotests/testEAP-TTLS-PAP/ssidEAP-TTLS-PAP.8021x b/autotests/=
testEAP-TTLS-PAP/ssidEAP-TTLS-PAP.8021x
deleted file mode 100644
index 8ff686ed..00000000
--- a/autotests/testEAP-TTLS-PAP/ssidEAP-TTLS-PAP.8021x
+++ /dev/null
@@ -1,12 +0,0 @@
-[Security]
-EAP-Method=3DTTLS
-EAP-Identity=3Danonymous
-EAP-TTLS-Phase2-Method=3DTunneled-PAP
-
-# If PAP Identity and Password are left out, they will be requested through
-# the agent.
-#EAP-TTLS-Phase2-Identity=3Duser
-#EAP-TTLS-Phase2-Password=3Dtestpasswd
-
-[Settings]
-AutoConnect=3DFalse
diff --git a/autotests/testEAP-TTLS-PAP/ssidEAP-TTLS-PAP.conf b/autotests/t=
estEAP-TTLS-PAP/ssidEAP-TTLS-PAP.conf
deleted file mode 100644
index 0f5103a7..00000000
--- a/autotests/testEAP-TTLS-PAP/ssidEAP-TTLS-PAP.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-TTLS-PAP
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/eap-user-ttls-pap.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testEAP-TTLS/connection_test.py b/autotests/testEAP-=
TTLS/connection_test.py
deleted file mode 100644
index c9fff4e1..00000000
--- a/autotests/testEAP-TTLS/connection_test.py
+++ /dev/null
@@ -1,49 +0,0 @@
-#!/usr/bin/python3
-
-import unittest
-import sys
-
-sys.path.append('../util')
-import iwd
-from iwd import IWD
-from iwd import NetworkType
-import testutil
-
-class Test(unittest.TestCase):
-
-    def test_connection_success(self):
-        wd =3D IWD()
-
-        devices =3D wd.list_devices(1)
-        device =3D devices[0]
-
-        ordered_network =3D device.get_ordered_network('ssidEAP-TTLS')
-
-        self.assertEqual(ordered_network.type, NetworkType.eap)
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-        ordered_network.network_object.connect()
-
-        condition =3D 'obj.state =3D=3D DeviceState.connected'
-        wd.wait_for_object_condition(device, condition)
-
-        testutil.test_iface_operstate()
-        testutil.test_ifaces_connected()
-
-        device.disconnect()
-
-        condition =3D 'not obj.connected'
-        wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-
-    @classmethod
-    def setUpClass(cls):
-        IWD.copy_to_storage('ssidEAP-TTLS.8021x')
-
-    @classmethod
-    def tearDownClass(cls):
-        IWD.clear_storage()
-
-if __name__ =3D=3D '__main__':
-    unittest.main(exit=3DTrue)
diff --git a/autotests/testEAP-TTLS/hw.conf b/autotests/testEAP-TTLS/hw.conf
deleted file mode 100644
index 8cef6a61..00000000
--- a/autotests/testEAP-TTLS/hw.conf
+++ /dev/null
@@ -1,5 +0,0 @@
-[SETUP]
-num_radios=3D2
-
-[HOSTAPD]
-rad0=3DssidEAP-TTLS.conf
diff --git a/autotests/testEAP-TTLS/ssidEAP-TTLS.8021x b/autotests/testEAP-=
TTLS/ssidEAP-TTLS.8021x
deleted file mode 100644
index 911490b5..00000000
--- a/autotests/testEAP-TTLS/ssidEAP-TTLS.8021x
+++ /dev/null
@@ -1,12 +0,0 @@
-[Security]
-EAP-Method=3DTTLS
-EAP-Identity=3Dabc(a)example.com
-EAP-TTLS-CACert=3D/tmp/certs/cert-ca.pem
-EAP-TTLS-ClientCert=3D/tmp/certs/cert-client.pem
-EAP-TTLS-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-TTLS-Phase2-Method=3DMD5
-EAP-TTLS-Phase2-Identity=3Dabc(a)example.com
-EAP-TTLS-Phase2-Password=3Dtestpasswd
-
-[Settings]
-AutoConnect=3DFalse
diff --git a/autotests/testEAP-TTLS/ssidEAP-TTLS.conf b/autotests/testEAP-T=
TLS/ssidEAP-TTLS.conf
deleted file mode 100644
index 296e9c1a..00000000
--- a/autotests/testEAP-TTLS/ssidEAP-TTLS.conf
+++ /dev/null
@@ -1,12 +0,0 @@
-hw_mode=3Dg
-channel=3D1
-ssid=3DssidEAP-TTLS
-
-wpa=3D3
-wpa_key_mgmt=3DWPA-EAP
-ieee8021x=3D1
-eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-ttls.text
-ca_cert=3D/tmp/certs/cert-ca.pem
-server_cert=3D/tmp/certs/cert-server.pem
-private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testFILS/fils_256_test.py b/autotests/testFILS/fils_=
256_test.py
index a9ef3663..62de581b 100644
--- a/autotests/testFILS/fils_256_test.py
+++ b/autotests/testFILS/fils_256_test.py
@@ -7,7 +7,6 @@ import os
 sys.path.append('../util')
 import iwd
 from iwd import IWD
-from iwd import PSKAgent
 from iwd import NetworkType
 from hostapd import HostapdCLI
 import testutil
@@ -18,10 +17,6 @@ class Test(unittest.TestCase):
 =

         wd =3D IWD(True)
 =

-        psk_agent =3D PSKAgent('user(a)example.com', ('user(a)example.com',
-                                                                  'secret1=
23'))
-        wd.register_psk_agent(psk_agent)
-
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

@@ -62,8 +57,6 @@ class Test(unittest.TestCase):
 =

         device.disconnect()
 =

-        wd.unregister_psk_agent(psk_agent)
-
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('ssidFILS-256.8021x')
diff --git a/autotests/testFILS/fils_384_test.py b/autotests/testFILS/fils_=
384_test.py
index b1f0e1c5..8df5554c 100644
--- a/autotests/testFILS/fils_384_test.py
+++ b/autotests/testFILS/fils_384_test.py
@@ -7,7 +7,6 @@ import os
 sys.path.append('../util')
 import iwd
 from iwd import IWD
-from iwd import PSKAgent
 from iwd import NetworkType
 from hostapd import HostapdCLI
 import testutil
@@ -18,10 +17,6 @@ class Test(unittest.TestCase):
 =

         wd =3D IWD(True)
 =

-        psk_agent =3D PSKAgent('user(a)example.com', ('user(a)example.com',
-                                                                  'secret1=
23'))
-        wd.register_psk_agent(psk_agent)
-
         devices =3D wd.list_devices(1)
         device =3D devices[0]
 =

@@ -62,8 +57,6 @@ class Test(unittest.TestCase):
 =

         device.disconnect()
 =

-        wd.unregister_psk_agent(psk_agent)
-
     @classmethod
     def setUpClass(cls):
         IWD.copy_to_storage('ssidFILS-384.8021x')
diff --git a/autotests/testFILS/pwd.eap_user b/autotests/testFILS/pwd.eap_u=
ser
deleted file mode 100644
index 69079c24..00000000
--- a/autotests/testFILS/pwd.eap_user
+++ /dev/null
@@ -1 +0,0 @@
-"user(a)example.com"	PWD     "secret123"
diff --git a/autotests/testFILS/radius.conf b/autotests/testFILS/radius.conf
index 4fcfdfff..1ec52e46 100644
--- a/autotests/testFILS/radius.conf
+++ b/autotests/testFILS/radius.conf
@@ -1,7 +1,7 @@
 driver=3Dnone
 radius_server_clients=3D/tmp/certs/radius-clients.text
 radius_server_auth_port=3D1812
-eap_user_file=3D/tmp/pwd.eap_user
+eap_user_file=3D/tmp/secrets/eap-user.text
 eap_server=3D0
 eap_server_erp=3D1
 =

diff --git a/autotests/testFILS/ssidFILS-256.8021x b/autotests/testFILS/ssi=
dFILS-256.8021x
index db9a053d..8136230e 100644
--- a/autotests/testFILS/ssidFILS-256.8021x
+++ b/autotests/testFILS/ssidFILS-256.8021x
@@ -1,2 +1,4 @@
 [Security]
 EAP-Method=3DPWD
+EAP-Identity=3Dpwd(a)example.com
+EAP-Password=3DPassword
diff --git a/autotests/testFILS/ssidFILS-384.8021x b/autotests/testFILS/ssi=
dFILS-384.8021x
index db9a053d..8136230e 100644
--- a/autotests/testFILS/ssidFILS-384.8021x
+++ b/autotests/testFILS/ssidFILS-384.8021x
@@ -1,2 +1,4 @@
 [Security]
 EAP-Method=3DPWD
+EAP-Identity=3Dpwd(a)example.com
+EAP-Password=3DPassword
diff --git a/autotests/testFT-8021x-roam/TestFT.8021x b/autotests/testFT-80=
21x-roam/TestFT.8021x
index 7908545f..88c622ad 100644
--- a/autotests/testFT-8021x-roam/TestFT.8021x
+++ b/autotests/testFT-8021x-roam/TestFT.8021x
@@ -3,7 +3,7 @@ EAP-Method=3DTLS
 EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
 EAP-TLS-ClientCert=3D/tmp/certs/cert-client.pem
 EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-Identity=3Dabc(a)example.com
+EAP-Identity=3Dtls(a)example.com
 =

 [Settings]
 AutoConnect=3DFalse
diff --git a/autotests/testFT-8021x-roam/ft-eap-ccmp-1.conf b/autotests/tes=
tFT-8021x-roam/ft-eap-ccmp-1.conf
index 936ef22b..a7f220d9 100644
--- a/autotests/testFT-8021x-roam/ft-eap-ccmp-1.conf
+++ b/autotests/testFT-8021x-roam/ft-eap-ccmp-1.conf
@@ -13,7 +13,7 @@ wpa_key_mgmt=3DFT-EAP
 wpa_pairwise=3DCCMP
 ieee8021x=3D1
 eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testFT-8021x-roam/ft-eap-ccmp-2.conf b/autotests/tes=
tFT-8021x-roam/ft-eap-ccmp-2.conf
index 29750ae3..289d7a17 100644
--- a/autotests/testFT-8021x-roam/ft-eap-ccmp-2.conf
+++ b/autotests/testFT-8021x-roam/ft-eap-ccmp-2.conf
@@ -13,7 +13,7 @@ wpa_key_mgmt=3DFT-EAP
 wpa_pairwise=3DCCMP
 ieee8021x=3D1
 eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testFT-FILS/TestFT.8021x b/autotests/testFT-FILS/Tes=
tFT.8021x
index 3b16769b..22737434 100644
--- a/autotests/testFT-FILS/TestFT.8021x
+++ b/autotests/testFT-FILS/TestFT.8021x
@@ -1,7 +1,7 @@
 [Security]
 EAP-Method=3DPWD
-EAP-Identity=3Duser(a)example.com
-EAP-Password=3Dsecret123
+EAP-Identity=3Dpwd(a)example.com
+EAP-Password=3DPassword
 =

 [Settings]
 AutoConnect=3DFalse
diff --git a/autotests/testFT-FILS/pwd.eap_user b/autotests/testFT-FILS/pwd=
.eap_user
deleted file mode 100644
index 69079c24..00000000
--- a/autotests/testFT-FILS/pwd.eap_user
+++ /dev/null
@@ -1 +0,0 @@
-"user(a)example.com"	PWD     "secret123"
diff --git a/autotests/testFT-FILS/radius.conf b/autotests/testFT-FILS/radi=
us.conf
index 4fcfdfff..1ec52e46 100644
--- a/autotests/testFT-FILS/radius.conf
+++ b/autotests/testFT-FILS/radius.conf
@@ -1,7 +1,7 @@
 driver=3Dnone
 radius_server_clients=3D/tmp/certs/radius-clients.text
 radius_server_auth_port=3D1812
-eap_user_file=3D/tmp/pwd.eap_user
+eap_user_file=3D/tmp/secrets/eap-user.text
 eap_server=3D0
 eap_server_erp=3D1
 =

diff --git a/autotests/testPreauth-roam/TestPreauth.8021x b/autotests/testP=
reauth-roam/TestPreauth.8021x
index 83d48784..584171ff 100644
--- a/autotests/testPreauth-roam/TestPreauth.8021x
+++ b/autotests/testPreauth-roam/TestPreauth.8021x
@@ -3,7 +3,7 @@ EAP-Method=3DTLS
 EAP-TLS-CACert=3D/tmp/certs/cert-ca.pem
 EAP-TLS-ClientCert=3D/tmp/certs/cert-client.pem
 EAP-TLS-ClientKey=3D/tmp/certs/cert-client-key-pkcs8.pem
-EAP-Identity=3Dabc(a)example.com
+EAP-Identity=3Dtls(a)example.com
 =

 [Settings]
 AutoConnect=3Dfalse
diff --git a/autotests/testPreauth-roam/eaptls-preauth-1.conf b/autotests/t=
estPreauth-roam/eaptls-preauth-1.conf
index bc808ed7..dac086e6 100644
--- a/autotests/testPreauth-roam/eaptls-preauth-1.conf
+++ b/autotests/testPreauth-roam/eaptls-preauth-1.conf
@@ -13,7 +13,7 @@ ieee80211w=3D1
 =

 # Run the RADIUS server in the BSS 0 hostapd only, listen for BSS 1 connec=
tions
 eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
diff --git a/autotests/testScan/ssid_8021x.conf b/autotests/testScan/ssid_8=
021x.conf
index 2cb208d4..19b988dd 100644
--- a/autotests/testScan/ssid_8021x.conf
+++ b/autotests/testScan/ssid_8021x.conf
@@ -6,7 +6,7 @@ wpa=3D3
 wpa_key_mgmt=3DWPA-EAP
 ieee8021x=3D1
 eap_server=3D1
-eap_user_file=3D/tmp/certs/eap-user-tls.text
+eap_user_file=3D/tmp/secrets/eap-user.text
 ca_cert=3D/tmp/certs/cert-ca.pem
 server_cert=3D/tmp/certs/cert-server.pem
 private_key=3D/tmp/certs/cert-server-key.pem
-- =

2.31.1

--===============6570717665434101103==--

