Content-Type: multipart/mixed; boundary="===============0777687390117599599=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/3] wsc: set ssid in handshake
Date: Fri, 03 Sep 2021 12:35:43 -0700
Message-ID: <20210903193544.13897-2-prestwoj@gmail.com>
In-Reply-To: <20210903193544.13897-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0777687390117599599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

netdev now assumes the SSID was set in the handshake (normally via
network_handshake_setup) but WSC calls netdev_connect directly so
it also should set the SSID.
---
 src/wsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/wsc.c b/src/wsc.c
index 4ab497d4..2618497a 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -356,6 +356,7 @@ static int wsc_enrollee_connect(struct wsc_enrollee *ws=
ce, struct scan_bss *bss,
 =

 	handshake_state_set_event_func(hs, wsc_enrollee_handshake_event, wsce);
 	handshake_state_set_8021x_config(hs, settings);
+	handshake_state_set_ssid(hs, bss->ssid, bss->ssid_len);
 	wsce->eap_settings =3D settings;
 =

 	request.version2 =3D true;
-- =

2.31.1

--===============0777687390117599599==--

