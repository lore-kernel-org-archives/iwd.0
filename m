Content-Type: multipart/mixed; boundary="===============8979261040170414561=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] knownnetworks: sanitize known_network.freq on load
Date: Fri, 29 Jan 2021 13:35:18 -0800
Message-ID: <20210129213518.110457-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8979261040170414561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An invalid known_network.freq file containing several UUID
groups which have the same 'name' key results in memory leaks
in IWD. This is because the file is loaded and the group's
are iterated without any verification that the UUID matches
whatever provisioning file we have on disk. This leads to the
same network_info's known_frequencies being set/overridden
multiple times.

To fix this the UUID/group is verified after we lookup the
network_info. If it does not match the stale entry is removed
and synced to disk.
---
 src/knownnetworks.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 53cfc30f..9a6d8aad 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -889,6 +889,21 @@ static struct network_info *find_network_info_from_pat=
h(const char *path)
 	return search.info;
 }
 =

+static bool verify_network_uuid(struct network_info *info,
+				const char *uuid_check)
+{
+	char uuid_str[37];
+	const uint8_t *uuid =3D network_info_get_uuid(info);
+
+	if (!l_uuid_to_string(uuid, uuid_str, sizeof(uuid_str)))
+		return false;
+
+	if (!strcmp(uuid_str, uuid_check))
+		return true;
+
+	return false;
+}
+
 static int known_network_frequencies_load(void)
 {
 	char **groups;
@@ -916,6 +931,12 @@ static int known_network_frequencies_load(void)
 		if (!info)
 			continue;
 =

+		if (!verify_network_uuid(info, groups[i])) {
+			l_settings_remove_group(known_freqs, groups[i]);
+			known_network_frequency_sync(info);
+			continue;
+		}
+
 		freq_list =3D l_settings_get_string(known_freqs, groups[i],
 							"list");
 		if (!freq_list)
-- =

2.26.2

--===============8979261040170414561==--

