Content-Type: multipart/mixed; boundary="===============8501246880947005763=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] station: set preparing_roam flag on Roam()
Date: Fri, 06 Aug 2021 16:02:11 -0700
Message-ID: <20210806230212.381657-4-prestwoj@gmail.com>
In-Reply-To: <20210806230212.381657-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8501246880947005763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The preparing_roam flag is expected to be set by a few roam
routines and normally this is done prior to the roam scan.
The Roam() developer option was not doing this and would
cause failed roams in some cases.
---
 src/station.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/station.c b/src/station.c
index 05a4a239..a441a63d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3740,6 +3740,9 @@ static struct l_dbus_message *station_force_roam(stru=
ct l_dbus *dbus,
 =

 	l_debug("Attempting forced roam to BSS "MAC, MAC_STR(mac));
 =

+	/* The various roam routines expect this to be set from scanning */
+	station->preparing_roam =3D true;
+
 	station_transition_start(station, target);
 =

 	return l_dbus_message_new_method_return(message);
-- =

2.31.1

--===============8501246880947005763==--

