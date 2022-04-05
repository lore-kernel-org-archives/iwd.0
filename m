Content-Type: multipart/mixed; boundary="===============8952781486992439218=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] doc: update hwsim documentation
Date: Tue, 05 Apr 2022 11:50:57 -0700
Message-ID: <20220405185057.858098-1-prestwoj@gmail.com>

--===============8952781486992439218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was quite dated and needed to be updated both to
reflect the API change to a dictionary argument, as well
as document NoVirtualInterface.
---
 doc/hwsim-radio-api.txt | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/doc/hwsim-radio-api.txt b/doc/hwsim-radio-api.txt
index 7303c33d..c8c889a2 100644
--- a/doc/hwsim-radio-api.txt
+++ b/doc/hwsim-radio-api.txt
@@ -5,17 +5,33 @@ Service		net.connman.hwsim
 Interface	net.connman.hwsim.RadioManager [Experimental]
 Object path	/
 =

-Methods		object CreateRadio(string name, boolean p2p_device)
+Methods		object CreateRadio(dict)
 			Add one virtual radio device to the simulator, a
 			path to a new object with the
 			net.connman.hwsim.Radio interface is returned.
-			The radio is created with one network interface of
-			the type "managed" (Station) and optionally one
-			P2P Device interface.  The name parameter may be
-			an empty string or a requested name for the radio
-			and its wiphy.  If empty, the kernel will use a
-			default name.  If non-empty, the kernel may still
-			use the default name if the requested name can not
+
+			This API takes a dictionary of arguments (all optional)
+			with keys:
+
+			string Name -			Name of radio
+			bool P2P -			Create a P2P device
+			string InterfaceTypeDisable -	List of disabled
+							interface types (comma
+							separated)
+			string CipherTypeDisable -	List of disabled
+							cipher types (comma
+							separated)
+			string NoVirtualInterface -	Don't create an
+							interface for this
+							radio.
+
+			The radio is created with one network interface (unless
+			NoVirtualInterface is used) of the type "managed"
+			(Station) and optionally one P2P Device interface.
+			The name parameter may be an empty string or a requested
+			name for the radio and its wiphy.  If empty, the kernel
+			will use a default name. If non-empty, the kernel may
+			still use the default name if the requested name can not
 			be used.
 =

 Service		net.connman.hwsim
-- =

2.34.1

--===============8952781486992439218==--

