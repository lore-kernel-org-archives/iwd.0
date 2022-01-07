Content-Type: multipart/mixed; boundary="===============2475589926199217904=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/5] dpp: don't allocate transient ssid strings
Date: Fri, 07 Jan 2022 14:31:08 -0800
Message-ID: <20220107223112.715855-1-prestwoj@gmail.com>

--===============2475589926199217904==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These can be kept on the stack and avoid the need for
allocated memory and unneeded auto-free functionality.
---
 src/dpp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 20c27a57..61c6b36d 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -400,7 +400,7 @@ static void send_config_result(struct dpp_sm *dpp, cons=
t uint8_t *to)
 static void dpp_write_config(struct dpp_configuration *config,
 				struct network *network)
 {
-	_auto_(l_free) char *ssid =3D l_malloc(config->ssid_len + 1);
+	char ssid[33];
 	_auto_(l_settings_free) struct l_settings *settings =3D l_settings_new();
 	_auto_(l_free) char *path;
 	_auto_(l_free) uint8_t *psk =3D NULL;
@@ -494,7 +494,7 @@ static void dpp_handle_config_response_frame(const stru=
ct mmpdu_header *frame,
 	struct station *station =3D station_find(netdev_get_ifindex(dpp->netdev));
 	struct network *network;
 	struct scan_bss *bss =3D NULL;
-	_auto_(l_free) char *ssid =3D NULL;
+	char ssid[33];
 =

 	if (dpp->state !=3D DPP_STATE_CONFIGURING)
 		return;
@@ -618,7 +618,6 @@ static void dpp_handle_config_response_frame(const stru=
ct mmpdu_header *frame,
 		return;
 	}
 =

-	ssid =3D l_malloc(config->ssid_len + 1);
 	memcpy(ssid, config->ssid, config->ssid_len);
 	ssid[config->ssid_len] =3D '\0';
 =

-- =

2.31.1

--===============2475589926199217904==--

