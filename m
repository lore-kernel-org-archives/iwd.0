Content-Type: multipart/mixed; boundary="===============2533390396323340174=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/7] autotests: Update APRanges usage in testAP
Date: Fri, 26 Feb 2021 17:17:27 +0100
Message-ID: <20210226161728.677701-6-andrew.zaborowski@intel.com>
In-Reply-To: <20210226161728.677701-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2533390396323340174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[General].APRange is now [IPv4].APAddressPool and the netmask is changed
from 23 to 27 bits to make the test correctly assert that only two
default-sized subnets are allowed by IWD simultaneously (default has
changed from 24 to 28 bits)
---
 autotests/testAP/dhcp/main.conf | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/autotests/testAP/dhcp/main.conf b/autotests/testAP/dhcp/main.c=
onf
index 667de23c..62ae782d 100644
--- a/autotests/testAP/dhcp/main.conf
+++ b/autotests/testAP/dhcp/main.conf
@@ -3,4 +3,6 @@ DisableMacAddressRandomization=3Dtrue
 =

 [General]
 EnableNetworkConfiguration=3Dtrue
-APRanges=3D192.168.80.0/23
+
+[IPv4]
+APAddressPool=3D192.168.80.0/27
-- =

2.27.0

--===============2533390396323340174==--

