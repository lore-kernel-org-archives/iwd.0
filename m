Content-Type: multipart/mixed; boundary="===============2614810733887646212=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] peap: Add debug statements
Date: Fri, 13 Dec 2019 11:32:51 -0800
Message-ID: <20191213193251.8714-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2614810733887646212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap-peap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/eap-peap.c b/src/eap-peap.c
index 5de6e862..ee71514a 100644
--- a/src/eap-peap.c
+++ b/src/eap-peap.c
@@ -170,6 +170,8 @@ static int eap_extensions_handle_cryptobinding_tlv(stru=
ct eap_state *eap,
 	uint8_t buf[61];
 	uint8_t imck[60];
 =

+	l_debug();
+
 	if (tlv_value_len !=3D cryptobinding_val_len)
 		return -EBADMSG;
 =

@@ -405,8 +407,11 @@ static void eap_extensions_handle_request(struct eap_s=
tate *eap,
 					&response[EAP_EXTENSIONS_HEADER_LEN],
 					&result);
 =

-	if (response_len < 0)
+	if (response_len < 0) {
+		l_debug("PEAP: Failed to process TLVs %d", response_len);
+
 		return;
+	}
 =

 	response_len +=3D EAP_EXTENSIONS_HEADER_LEN;
 =

-- =

2.13.6

--===============2614810733887646212==--

