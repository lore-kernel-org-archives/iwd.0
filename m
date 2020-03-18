Content-Type: multipart/mixed; boundary="===============6818964059759786528=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] doc: document AddressRandomization=network option
Date: Wed, 18 Mar 2020 10:20:50 -0700
Message-ID: <20200318172050.8989-3-prestwoj@gmail.com>
In-Reply-To: <20200318172050.8989-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6818964059759786528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.config.rst | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index dd04909c..96774092 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -82,7 +82,7 @@ The group ``[General]`` contains general settings.
        this setting.
 =

    * - AddressRandomization
-     - Values: **disabled**, once
+     - Values: **disabled**, once, network
 =

        If ``AddressRandomization`` is set to ``disabled``, the default ker=
nel
        behavior is used.  This means the kernel will assign a mac address =
from
@@ -94,6 +94,12 @@ The group ``[General]`` contains general settings.
        randomized a single time when **iwd** starts or when the hardware is
        detected for the first time (due to hotplug, etc.)
 =

+       If ``AddressRandomization`` is set to ``network``, the MAC address =
is
+       randomized on each connection to a network. The MAC is generated ba=
sed on
+       the SSID and permanent address of the adapter. This allows the same=
 MAC
+       to be generated each time connecting to a given SSID while still hi=
ding
+       the permanent address.
+
    * - AddressRandomizationRange
      - Values: **full**, nic
 =

-- =

2.21.1

--===============6818964059759786528==--

