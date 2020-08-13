Content-Type: multipart/mixed; boundary="===============5538746135991323494=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 04/16] eapol: Don't try setting protocol_version in
 eapol_rx_auth_packet
Date: Thu, 13 Aug 2020 02:50:14 +0200
Message-ID: <20200813005026.294950-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200813005026.294950-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5538746135991323494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In autenticator mode we'll always have protocol_version set from the
start so the condition is always going to be false.
---
 src/eapol.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index ae37f6c2..38c7956e 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -2201,9 +2201,6 @@ static void eapol_rx_auth_packet(uint16_t proto, cons=
t uint8_t *from,
 {
 	struct eapol_sm *sm =3D user_data;
 =

-	if (!sm->protocol_version)
-		sm->protocol_version =3D frame->header.protocol_version;
-
 	switch (frame->header.packet_type) {
 	case 3: /* EAPOL-Key */
 		eapol_auth_key_handle(sm, frame);
-- =

2.25.1

--===============5538746135991323494==--

