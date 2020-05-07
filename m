Content-Type: multipart/mixed; boundary="===============7086764712911569189=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] fils: include RSNE in authenticate
Date: Thu, 07 May 2020 14:50:59 -0700
Message-ID: <20200507215059.15987-2-prestwoj@gmail.com>
In-Reply-To: <20200507215059.15987-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7086764712911569189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

802.11ai mandates that the RSN element is included during authentication
for FILS. This previously was happening by chance since supplicant_ie
was being included with CMD_AUTHENTICATE. This included more than just
the RSNE so that was removed in an earlier commit. Now FILS builds the
RSNE itself and includes this with CMD_AUTHENTICATE.
---
 src/fils.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/fils.c b/src/fils.c
index 2d2a0913..acead506 100644
--- a/src/fils.c
+++ b/src/fils.c
@@ -91,6 +91,8 @@ static void fils_erp_tx_func(const uint8_t *eap_data, siz=
e_t len,
 	uint8_t data[256];
 	uint8_t *ptr =3D data;
 	unsigned int tlv_len;
+	struct ie_rsn_info rsn_info;
+	uint8_t *rsne;
 =

 	l_getrandom(fils->nonce, 16);
 	l_getrandom(fils->session, 8);
@@ -106,6 +108,15 @@ static void fils_erp_tx_func(const uint8_t *eap_data, =
size_t len,
 =

 	ie_tlv_builder_init(&builder, ptr, sizeof(data) - 4);
 =

+	ie_parse_rsne_from_data(fils->hs->supplicant_ie,
+				fils->hs->supplicant_ie[1] + 2,
+				&rsn_info);
+	rsne =3D alloca(256);
+	ie_build_rsne(&rsn_info, rsne);
+
+	ie_tlv_builder_next(&builder, IE_TYPE_RSN);
+	ie_tlv_builder_set_data(&builder, rsne + 2, rsne[1]);
+
 	ie_tlv_builder_next(&builder, IE_TYPE_FILS_NONCE);
 	ie_tlv_builder_set_data(&builder, fils->nonce, sizeof(fils->nonce));
 =

-- =

2.21.1

--===============7086764712911569189==--

