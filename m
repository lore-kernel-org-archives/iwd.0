Content-Type: multipart/mixed; boundary="===============7900930326481438598=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] test-runner: add special radius_server key
Date: Mon, 30 Dec 2019 10:09:51 -0800
Message-ID: <20191230180954.12644-2-prestwoj@gmail.com>
In-Reply-To: <20191230180954.12644-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7900930326481438598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some test cases require (at least with recent hostapd versions) a
stand alone radius server. This is done using driver=3Dnone in the
hostapd config file. For this use case hostapd does not need any
radio since its not doing anything wireless related.

Now inside the hw.conf file, under the HOSTAPD group, you can
specify a config file as the value to 'radius_server' key. This
config file will be used without any associated radio when hostapd
is started.
---
 tools/test-runner.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 71c5f14e..6a3a2932 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -1398,6 +1398,9 @@ static bool configure_hostapd_instances(struct l_sett=
ings *hw_settings,
 			goto done;
 		}
 =

+		if (!strcmp(hostap_keys[i], "radius_server"))
+			continue;
+
 		for (wiphy_entry =3D l_queue_get_entries(wiphy_list);
 					wiphy_entry;
 					wiphy_entry =3D wiphy_entry->next,
-- =

2.17.1

--===============7900930326481438598==--

