Content-Type: multipart/mixed; boundary="===============4284228497633560735=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 2/3] scan: add scan_freq_set_serialize
Date: Tue, 30 Nov 2021 09:48:12 -0800
Message-ID: <20211130174813.384374-2-prestwoj@gmail.com>
In-Reply-To: 20211130174813.384374-1-prestwoj@gmail.com

--===============4284228497633560735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This serializes a scan_freq_set into a uint32_t array.
---
 src/util.c | 33 +++++++++++++++++++++++++++++++++
 src/util.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/src/util.c b/src/util.c
index 381894f4..c0d5e258 100644
--- a/src/util.c
+++ b/src/util.c
@@ -470,3 +470,36 @@ void scan_freq_set_constrain(struct scan_freq_set *set,
 =

 	set->channels_2ghz &=3D constraint->channels_2ghz;
 }
+
+static void add_foreach(uint32_t freq, void *user_data)
+{
+	uint32_t **list =3D user_data;
+
+	**list =3D freq;
+
+	*list =3D *list + 1;
+}
+
+uint32_t *scan_freq_set_to_fixed_array(const struct scan_freq_set *set,
+					size_t *len_out)
+{
+	uint8_t count =3D 0;
+	uint32_t *freqs;
+
+	count =3D __builtin_popcount(set->channels_2ghz) +
+				l_uintset_count(set->channels_5ghz);
+
+	if (!count)
+		return NULL;
+
+	freqs =3D l_new(uint32_t, count);
+
+	scan_freq_set_foreach(set, add_foreach, &freqs);
+
+	/* Move pointer back to start of list */
+	freqs -=3D count;
+
+	*len_out =3D count;
+
+	return freqs;
+}
diff --git a/src/util.h b/src/util.h
index 8cced9cd..b55a7ea7 100644
--- a/src/util.h
+++ b/src/util.h
@@ -115,5 +115,7 @@ void scan_freq_set_merge(struct scan_freq_set *to,
 void scan_freq_set_constrain(struct scan_freq_set *set,
 					const struct scan_freq_set *constraint);
 bool scan_freq_set_isempty(const struct scan_freq_set *set);
+uint32_t *scan_freq_set_to_fixed_array(const struct scan_freq_set *set,
+					size_t *len_out);
 =

 #endif /* __UTIL_H */
-- =

2.31.1

--===============4284228497633560735==--

