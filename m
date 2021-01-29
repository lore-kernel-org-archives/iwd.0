Content-Type: multipart/mixed; boundary="===============1234021681164049490=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4] knownnetworks: sanitize known_network.freq on load
Date: Fri, 29 Jan 2021 15:47:26 -0800
Message-ID: <20210129234726.132679-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1234021681164049490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An invalid known_network.freq file containing several UUID
groups which have the same 'name' key results in memory leaks
in IWD. This is because the file is loaded and the group's
are iterated without detecting duplicates. This leads to the
same network_info's known_frequencies being set/overridden
multiple times.

To fix this we just check if the network_info already has a
UUID set. If so remove the stale entry.

There may be other old, invalid, or stale entries from previous
versions of IWD, or a user misconfiguring the file. These will
now also be removed during load.
---
 src/knownnetworks.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

v4:
 * Fixed a few memory leak issues

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 53cfc30f..674feca0 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -910,29 +910,38 @@ static int known_network_frequencies_load(void)
 		const char *path =3D l_settings_get_value(known_freqs, groups[i],
 							"name");
 		if (!path)
-			continue;
+			goto invalid_entry;
 =

 		info =3D find_network_info_from_path(path);
 		if (!info)
-			continue;
+			goto invalid_entry;
+
+		if (info->has_uuid)
+			goto invalid_entry;
 =

 		freq_list =3D l_settings_get_string(known_freqs, groups[i],
 							"list");
 		if (!freq_list)
-			continue;
+			goto invalid_entry;
 =

 		known_frequencies =3D known_frequencies_from_string(freq_list);
+		l_free(freq_list);
+
 		if (!known_frequencies)
-			goto next;
+			goto invalid_entry;
 =

-		if (!l_uuid_from_string(groups[i], uuid))
-			goto next;
+		if (!l_uuid_from_string(groups[i], uuid)) {
+			l_queue_destroy(known_frequencies, l_free);
+			goto invalid_entry;
+		}
 =

 		network_info_set_uuid(info, uuid);
 		info->known_frequencies =3D known_frequencies;
 =

-next:
-		l_free(freq_list);
+		continue;
+
+invalid_entry:
+		l_settings_remove_group(known_freqs, groups[i]);
 	}
 =

 	l_strv_free(groups);
-- =

2.26.2

--===============1234021681164049490==--

