Content-Type: multipart/mixed; boundary="===============2843576733711198366=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] client: re-enable iwctl refresh for 'station <wlan> show'
Date: Mon, 29 Mar 2021 10:11:28 -0700
Message-ID: <20210329171128.702923-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2843576733711198366==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When diagnostics got added to iwctl the refresh capabilities were
accidentally removed. This re-enables refresh.
---
 client/station.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/client/station.c b/client/station.c
index c2e7a12b..de25d12b 100644
--- a/client/station.c
+++ b/client/station.c
@@ -612,7 +612,6 @@ static void get_diagnostics_callback(struct l_dbus_mess=
age *message,
 done:
 	/* Finish the table started by cmd_show */
 	display_table_footer();
-	display_refresh_reset();
 }
 =

 static enum cmd_status cmd_show(const char *device_name,
@@ -637,7 +636,6 @@ static enum cmd_status cmd_show(const char *device_name,
 	 */
 	if (!diagnostic) {
 		display_table_footer();
-		display_refresh_reset();
 		return CMD_STATUS_DONE;
 	}
 =

-- =

2.26.2

--===============2843576733711198366==--

