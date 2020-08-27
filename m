Content-Type: multipart/mixed; boundary="===============7039974651444292648=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/16] hwsim: return radio ID on create
Date: Thu, 27 Aug 2020 10:32:14 -0700
Message-ID: <20200827173229.26466-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7039974651444292648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hwsim was relying on some internal behavior of mac80211_hwsim where new
radios are created with ID's starting at zero and incremented. While
this is a reasonable assumption its better to obtain the actual radio
ID since mac80211_hwsim returns it in the radio creation callback.

Now hwsim will return the radio ID when creating radios. Negative returns
are still errors, but any value >=3D 0 indicates the radio ID of the newly
created radio.
---
 tools/hwsim.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 02053fa1..467ccd2d 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -216,6 +216,7 @@ static void create_callback(struct l_genl_msg *msg, voi=
d *user_data)
 		radio_id =3D err;
 =

 		l_info("Created new radio with id %u", radio_id);
+		exit_status =3D radio_id;
 	} else {
 		l_warn("Failed to get create return value");
 		exit_status =3D EXIT_FAILURE;
@@ -2605,7 +2606,8 @@ static void usage(void)
 	printf("\thwsim [options]\n");
 	printf("Options:\n"
 		"\t-L, --list [id]        List simulated radios\n"
-		"\t-C, --create           Create new simulated radio\n"
+		"\t-C, --create           Create new simulated radio. The "
+						"return value is the new radio ID\n"
 		"\t-D, --destroy <id>     Destroy existing radio\n"
 		"\t-n, --name <name>      Name of a radio to be created\n"
 		"\t-i, --nointerface      Do not create VIF\n"
@@ -2632,6 +2634,7 @@ static const struct option main_options[] =3D {
 int main(int argc, char *argv[])
 {
 	int actions =3D 0;
+	int ret;
 =

 	for (;;) {
 		int opt;
@@ -2729,7 +2732,9 @@ int main(int argc, char *argv[])
 		goto done;
 	}
 =

-	exit_status =3D l_main_run_with_signal(signal_handler, NULL);
+	ret =3D l_main_run_with_signal(signal_handler, NULL);
+	if (ret)
+		exit_status =3D ret;
 =

 	l_genl_family_free(hwsim);
 	l_genl_family_free(nl80211);
-- =

2.21.1

--===============7039974651444292648==--

