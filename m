Content-Type: multipart/mixed; boundary="===============7568871679130437002=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/5] doc: document AlwaysRandomizeAddress and
 AddressOverride
Date: Thu, 19 Mar 2020 15:59:01 -0700
Message-ID: <20200319225902.16249-4-prestwoj@gmail.com>
In-Reply-To: <20200319225902.16249-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7568871679130437002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/iwd.network.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 6b068202..74520db3 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -109,6 +109,21 @@ The group ``[Settings]`` contains general settings.
 =

        Whether the network is hidden, i.e. its SSID must be included in an
        active scan request
+   * - AlwaysRandomizeAddress
+     - Values: true, **false**
+
+       If enabled, the MAC address will be fully randomized on each connec=
tion.
+       This option is only used if [General].AddressRandomization is set to
+       'network'. See iwd.config. This value should not be used with
+       [Settings].AddressOverride, if both are set AddressOverride will be=
 used.
+   * - AddressOverride
+     - MAC address string
+
+       Override the MAC address used for connecting to this network. This =
option
+       is only used if [General].AddressRandomization is set to 'network'.=
 See
+       iwd.config. This value should not be used with
+       [Settings].FullAddressRandomization, if both are set AddressOverrid=
e will
+       be used.
 =

 Network Authentication Settings
 -------------------------------
-- =

2.21.1

--===============7568871679130437002==--

