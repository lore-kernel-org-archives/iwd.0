Content-Type: multipart/mixed; boundary="===============4308973320459290457=="
MIME-Version: 1.0
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
Subject: [PATCH 1/3] client: fix ad-hoc start_open DBus method name
Date: Tue, 07 Apr 2020 23:33:45 +0200
Message-ID: <20200407213347.32130-1-Diego.SantaCruz@spinetix.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4308973320459290457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Doing 'ad-hoc <wlan> start_open <"network name">' returned a
"No matching method found" error because start_open called
net.connman.iwd.AdHoc.Start instead of net.connman.iwd.AdHoc.StartOpen.
---
 client/ad-hoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/ad-hoc.c b/client/ad-hoc.c
index 41d5e2aa..c90f9dd6 100644
--- a/client/ad-hoc.c
+++ b/client/ad-hoc.c
@@ -189,7 +189,7 @@ static enum cmd_status cmd_start_open(const char *devic=
e_name,
 		return CMD_STATUS_INVALID_VALUE;
 	}
 =

-	proxy_interface_method_call(adhoc_i, "Start", "s",
+	proxy_interface_method_call(adhoc_i, "StartOpen", "s",
 						check_errors_method_callback,
 						argv[0]);
 =

-- =

2.18.1

--===============4308973320459290457==--

