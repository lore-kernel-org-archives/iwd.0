Content-Type: multipart/mixed; boundary="===============2450263213780596909=="
MIME-Version: 1.0
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
Subject: [PATCH] wired: use 802.1X-2001 instead of 802.1X-2004
Date: Mon, 27 Apr 2020 19:13:15 +0200
Message-ID: <20200427171315.9897-1-Diego.SantaCruz@spinetix.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2450263213780596909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For wired authentication the protocol version used in the EAPOL
packets sent by ead is fixed to 802.1X-2004 (2) but some switches
implementing only 802.1X-2001 erroneously ignore these packets.

As ead only sends EAPOL-Start and EAP-Packet packets and these have
not changed between 802.1X-2001 and 802.1X-2004 there should be
no reason to use 802.1X-2004. Hence, this changes ead to always use
802.1X-2001 (1) instead.

Switches implementing newer versions of 802.1X should not have
problems responding to packets using the original version.

---
 wired/ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wired/ethdev.c b/wired/ethdev.c
index c80d4fa0..e000afae 100644
--- a/wired/ethdev.c
+++ b/wired/ethdev.c
@@ -83,7 +83,7 @@ struct eapol_hdr {
 	__be16  pkt_len;
 } __attribute__ ((packed));
 =

-static const uint8_t eapol_start[] =3D { 0x02, 0x01, 0x00, 0x00 };
+static const uint8_t eapol_start[] =3D { 0x01, 0x01, 0x00, 0x00 };
 static const uint8_t pae_group_addr[] =3D { 0x01, 0x80, 0xc2, 0x00, 0x00, =
0x03 };
 =

 static bool pae_write(struct ethdev *dev, const uint8_t *addr,
@@ -149,7 +149,7 @@ static void eap_tx_packet(const uint8_t *eap_data, size=
_t len, void *user_data)
 	struct eapol *eapol =3D user_data;
 	uint8_t frame[1500];
 =

-	l_put_u8(0x02, frame);
+	l_put_u8(0x01, frame);
 	l_put_u8(0x00, frame + 1);
 	l_put_be16(len, frame + 2);
 	memcpy(frame + 4, eap_data, len);
-- =

2.18.1

--===============2450263213780596909==--

