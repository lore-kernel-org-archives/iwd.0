Content-Type: multipart/mixed; boundary="===============4463959522162630423=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] doc: document FullAddressRandomization and AddressOverride
Date: Thu, 19 Mar 2020 13:03:52 -0700
Message-ID: <20200319200353.7001-3-prestwoj@gmail.com>
In-Reply-To: <20200319200353.7001-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4463959522162630423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.network.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 6b068202..12efca72 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -109,6 +109,20 @@ The group ``[Settings]`` contains general settings.
 =

        Whether the network is hidden, i.e. its SSID must be included in an
        active scan request
+   * - FullAddressRandomization
+     - Values: true, **false**
+
+       If enabled, the MAC address will be fully randomized on each connec=
tion.
+       This option is only used if [General].AddressRandomization is set to
+       'network'. See iwd.config. This value may not be used with
+       [Settings].AddressOverride.
+   * - AddressOverride
+     - MAC address string
+
+       Override the MAC address used for connecting to this network. This =
option
+       is only used if [General].AddressRandomization is set to 'network'.=
 See
+       iwd.config. This value may not be used with
+       [Settings].FullAddressRandomization.
 =

 Network Authentication Settings
 -------------------------------
-- =

2.21.1

--===============4463959522162630423==--

