Content-Type: multipart/mixed; boundary="===============8704746428896327713=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] fils: pragma false positive for uninitialized variable
Date: Fri, 10 Jun 2022 11:40:17 -0700
Message-ID: <20220610184017.356608-1-prestwoj@gmail.com>

--===============8704746428896327713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On musl-gcc the compiler is giving a warning for igtk_key_index
and gtk_key_index being used uninitialized. This isn't possible
since they are only used if gtk/igtk are non-NULL so pragma to
ignore the warning.

src/fils.c: In function 'fils_rx_associate':
src/fils.c:580:17: error: 'igtk_key_index' may be used uninitialized
	in this function [-Werror=3Dmaybe-uninitialized]
  580 |                 handshake_state_install_igtk(fils->hs,
					igtk_key_index,igtk + 6,
					igtk_len - 6, igtk);

(same error for gtk_key_index)
---
 src/fils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/fils.c b/src/fils.c
index d1d46d65..c3337352 100644
--- a/src/fils.c
+++ b/src/fils.c
@@ -572,6 +572,8 @@ static int fils_rx_associate(struct auth_proto *driver,=
 const uint8_t *frame,
 	handshake_state_set_pmk(fils->hs, fils->pmk, fils->pmk_len);
 	handshake_state_set_pmkid(fils->hs, fils->pmkid);
 =

+_Pragma("GCC diagnostic push")
+_Pragma("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
 	if (gtk)
 		handshake_state_install_gtk(fils->hs, gtk_key_index, gtk,
 						gtk_len, key_rsc, 6);
@@ -579,6 +581,7 @@ static int fils_rx_associate(struct auth_proto *driver,=
 const uint8_t *frame,
 	if (igtk)
 		handshake_state_install_igtk(fils->hs, igtk_key_index,
 						igtk + 6, igtk_len - 6, igtk);
+_Pragma("GCC diagnostic pop")
 =

 	handshake_state_set_ptk(fils->hs, fils->kek_and_tk, fils->kek_len + 16);
 	handshake_state_install_ptk(fils->hs);
-- =

2.34.1

--===============8704746428896327713==--

