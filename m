Content-Type: multipart/mixed; boundary="===============8092346446721634320=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/2] station: disable OCV if offloading is supported
Date: Tue, 19 Oct 2021 14:52:47 -0700
Message-ID: <20211019215247.574475-2-prestwoj@gmail.com>
In-Reply-To: 20211019215247.574475-1-prestwoj@gmail.com

--===============8092346446721634320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It was seen during testing that several offload-capable cards
were not including the OCI in the 4-way handshake. This made
any OCV capable AP unconnectable.

To be safe disable OCV on any cards that support offloading.
---
 src/station.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index a972b4fa..7fca7108 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1087,7 +1087,20 @@ build_ie:
 					&disable_ocv))
 		disable_ocv =3D false;
 =

-	info.ocvc =3D !disable_ocv && bss_info.ocvc && info.mfpc;
+	/*
+	 * Obviously do not enable OCV if explicitly disabled or no AP support.
+	 *
+	 * Not obviously hostapd rejects OCV support if MFPC is not enabled.
+	 * This is not really specified by the spec, but we have to work around
+	 * this limitation.
+	 *
+	 * Another limitation is full mac cards. With limited testing it was
+	 * seen that they do not include the OCI in the 4-way handshake yet
+	 * still advertise the capability. Because of this OCV is disabled if
+	 * any offload features are detected (since IWD prefers to use offload).
+	 */
+	info.ocvc =3D !disable_ocv && bss_info.ocvc && info.mfpc &&
+			!wiphy_can_offload(wiphy);;
 =

 	/*
 	 * IEEE 802.11-2020 9.4.2.24.4 states extended key IDs can only be used
-- =

2.31.1

--===============8092346446721634320==--

