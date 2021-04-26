Content-Type: multipart/mixed; boundary="===============4060661455994569885=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3] doc: Update iwd.ap(5) man page
Date: Tue, 27 Apr 2021 01:34:08 +0200
Message-ID: <20210426233408.775576-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210426233408.775576-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4060661455994569885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Try to document some of the settings moved from struct ap_config to the
settings object now passed to ap_start(), skip the strictly internal-use
ones.
---
 src/iwd.ap.rst | 60 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index d4534120..51622509 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -41,6 +41,23 @@ SETTINGS
 The settings are split into several categories.  Each category has a group
 associated with it and is described in the corresponding table below.
 =

+General Settings
+----------------
+
+The group ``[General]`` contains general AP configuration.
+
+.. list-table::
+   :header-rows: 0
+   :stub-columns: 0
+   :widths: 20 80
+   :align: left
+
+   * - Channel
+     - Channel number
+
+       Optional channel number for the access point to operate on.  Only t=
he
+       2.4GHz-band channels are currently allowed.
+
 Network Authentication Settings
 -------------------------------
 =

@@ -56,7 +73,14 @@ configuration.
    * - Passphrase
      - 8..63 character string
 =

-       WPA-PSK Passphrase to be used with this access point.
+       WPA-PSK Passphrase to be used with this access point.  At least one=
 of
+       *Passphrase*, *PreSharedKey* must be present.
+
+   * - PreSharedKey
+     - 64-character hex-string
+
+       Processed passphrase for this network in the form of a hex-encoded
+       32-byte pre-shared key.  Either this or *Passphrase* must be presen=
t.
 =

 IPv4 Network Configuration
 --------------------------
@@ -117,6 +141,40 @@ is desired, the group header line must still be presen=
t:
        From and to addresses of the range assigned to clients through DHCP.
        If not provided the range from local address + 1 to .254 will be us=
ed.
 =

+Wi-Fi Simple Configuration
+--------------------------
+
+The group ``[WSC]`` fine-tunes some Wi-Fi Simple Configuration local param=
eters
+(formerly known as WPS, Wi-Fi Protected Setup.)
+
+.. list-table::
+   :header-rows: 0
+   :stub-columns: 0
+   :widths: 20 80
+   :align: left
+
+   * - DeviceName
+     - 1..32-character string
+
+       Optional Device Name string for the AP to advertise as.  Defaults to
+       the SSID.
+
+   * - PrimaryDeviceType
+     - Subcategory string or a 64-bit integer
+
+       Optional Primary Device Type for the AP to advertise as.  Defaults =
to
+       PC computer.  Can be specified as a lower-case WSC v2.0.5 subcatego=
ry
+       string or a 64-bit integer encoding, from MSB to LSB: the 16-bit
+       category ID, the 24-bit OUI, the 8-bit OUI type and the 16-bit
+       subcategory ID.
+
+   * - AuthorizedMACs
+     - Comma-separated MAC address list
+
+       Optional list of Authorized MAC addresses for the WSC registrar to
+       check on association.  Each address is specified in the
+       colon-hexadecimal notation.  Defaults to no MAC-based checks.
+
 SEE ALSO
 =3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

2.27.0

--===============4060661455994569885==--

