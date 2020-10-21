Content-Type: multipart/mixed; boundary="===============4447937921243701209=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 0/2] Add DHCP to AP
Date: Wed, 21 Oct 2020 11:44:25 -0700
Message-ID: <20201021184427.1730146-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4447937921243701209==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Removed all the provisioning file changes for now and left just the
minimum require for a DHCP server. All default values will be
chosen.

James Prestwood (2):
  ap: add support for DHCPv4 server
  auto-t: add AP test with DHCP server

 autotests/testAP-DHCP/connection_test.py | 76 ++++++++++++++++++++++++
 autotests/testAP-DHCP/failure_test.py    | 57 ++++++++++++++++++
 autotests/testAP-DHCP/hw.conf            |  3 +
 autotests/testAP-DHCP/main.conf          |  5 ++
 src/ap.c                                 | 70 ++++++++++++++++++++--
 5 files changed, 205 insertions(+), 6 deletions(-)
 create mode 100644 autotests/testAP-DHCP/connection_test.py
 create mode 100644 autotests/testAP-DHCP/failure_test.py
 create mode 100644 autotests/testAP-DHCP/hw.conf
 create mode 100644 autotests/testAP-DHCP/main.conf

-- =

2.26.2

--===============4447937921243701209==--

