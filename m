Content-Type: multipart/mixed; boundary="===============8034322543584781184=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] station: check for duplicate frequencies in debug scan
Date: Wed, 01 Sep 2021 16:38:52 -0700
Message-ID: <20210901233852.2796740-2-prestwoj@gmail.com>
In-Reply-To: <20210901233852.2796740-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8034322543584781184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/station.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/station.c b/src/station.c
index 9f00bfb3..2b4fa7bc 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3980,6 +3980,9 @@ static struct l_dbus_message *station_debug_scan(stru=
ct l_dbus *dbus,
 	freq_set =3D scan_freq_set_new();
 =

 	for (i =3D 0; i < freqs_len; i++) {
+		if (scan_freq_set_contains(freq_set, (uint32_t)freqs[i]))
+			continue;
+
 		if (!scan_freq_set_add(freq_set, (uint32_t)freqs[i])) {
 			scan_freq_set_free(freq_set);
 			goto invalid_args;
-- =

2.31.1

--===============8034322543584781184==--

