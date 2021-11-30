Content-Type: multipart/mixed; boundary="===============0333889133407914589=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/3] scan: move scan_freq_set* into util
Date: Tue, 30 Nov 2021 09:48:11 -0800
Message-ID: <20211130174813.384374-1-prestwoj@gmail.com>

--===============0333889133407914589==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This will allow scan_freq_set utilities to be used in any
modules requiring unit testing
---
 src/scan.c | 160 ----------------------------------------------------
 src/scan.h |  14 -----
 src/util.c | 161 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/util.h |  15 +++++
 4 files changed, 176 insertions(+), 174 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 4a0e274e..97b0a933 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2017,166 +2017,6 @@ bool scan_get_firmware_scan(uint64_t wdev_id, scan_=
notify_func_t notify,
 	return true;
 }
 =

-struct scan_freq_set {
-	uint16_t channels_2ghz;
-	struct l_uintset *channels_5ghz;
-};
-
-struct scan_freq_set *scan_freq_set_new(void)
-{
-	struct scan_freq_set *ret =3D l_new(struct scan_freq_set, 1);
-
-	/* 802.11-2012, 8.4.2.10 hints that 200 is the largest channel number */
-	ret->channels_5ghz =3D l_uintset_new_from_range(1, 200);
-
-	return ret;
-}
-
-void scan_freq_set_free(struct scan_freq_set *freqs)
-{
-	l_uintset_free(freqs->channels_5ghz);
-	l_free(freqs);
-}
-
-bool scan_freq_set_add(struct scan_freq_set *freqs, uint32_t freq)
-{
-	enum band_freq band;
-	uint8_t channel;
-
-	channel =3D band_freq_to_channel(freq, &band);
-	if (!channel)
-		return false;
-
-	switch (band) {
-	case BAND_FREQ_2_4_GHZ:
-		freqs->channels_2ghz |=3D 1 << (channel - 1);
-		return true;
-	case BAND_FREQ_5_GHZ:
-		return l_uintset_put(freqs->channels_5ghz, channel);
-	}
-
-	return false;
-}
-
-bool scan_freq_set_contains(const struct scan_freq_set *freqs, uint32_t fr=
eq)
-{
-	enum band_freq band;
-	uint8_t channel;
-
-	channel =3D band_freq_to_channel(freq, &band);
-	if (!channel)
-		return false;
-
-	switch (band) {
-	case BAND_FREQ_2_4_GHZ:
-		return freqs->channels_2ghz & (1 << (channel - 1));
-	case BAND_FREQ_5_GHZ:
-		return l_uintset_contains(freqs->channels_5ghz, channel);
-	}
-
-	return false;
-}
-
-uint32_t scan_freq_set_get_bands(struct scan_freq_set *freqs)
-{
-	uint32_t bands =3D 0;
-	uint32_t max;
-
-	if (freqs->channels_2ghz)
-		bands |=3D BAND_FREQ_2_4_GHZ;
-
-	max =3D l_uintset_get_max(freqs->channels_5ghz);
-
-	if (l_uintset_find_min(freqs->channels_5ghz) <=3D max)
-		bands |=3D BAND_FREQ_5_GHZ;
-
-	return bands;
-}
-
-static void scan_channels_5ghz_add(uint32_t channel, void *user_data)
-{
-	struct l_uintset *to =3D user_data;
-
-	l_uintset_put(to, channel);
-}
-
-void scan_freq_set_merge(struct scan_freq_set *to,
-					const struct scan_freq_set *from)
-{
-	to->channels_2ghz |=3D from->channels_2ghz;
-
-	l_uintset_foreach(from->channels_5ghz, scan_channels_5ghz_add,
-							to->channels_5ghz);
-}
-
-bool scan_freq_set_isempty(const struct scan_freq_set *set)
-{
-	if (set->channels_2ghz =3D=3D 0 && l_uintset_isempty(set->channels_5ghz))
-		return true;
-
-	return false;
-}
-
-struct channels_5ghz_foreach_data {
-	scan_freq_set_func_t func;
-	void *user_data;
-};
-
-static void scan_channels_5ghz_frequency(uint32_t channel, void *user_data)
-{
-	const struct channels_5ghz_foreach_data *channels_5ghz_data =3D user_data;
-	uint32_t freq;
-
-	freq =3D band_channel_to_freq(channel, BAND_FREQ_5_GHZ);
-
-	channels_5ghz_data->func(freq, channels_5ghz_data->user_data);
-}
-
-void scan_freq_set_foreach(const struct scan_freq_set *freqs,
-				scan_freq_set_func_t func, void *user_data)
-{
-	struct channels_5ghz_foreach_data data =3D { };
-	uint8_t channel;
-	uint32_t freq;
-
-	if (unlikely(!freqs || !func))
-		return;
-
-	data.func =3D func;
-	data.user_data =3D user_data;
-
-	l_uintset_foreach(freqs->channels_5ghz, scan_channels_5ghz_frequency,
-									&data);
-
-	if (!freqs->channels_2ghz)
-		return;
-
-	for (channel =3D 1; channel <=3D 14; channel++) {
-		if (freqs->channels_2ghz & (1 << (channel - 1))) {
-			freq =3D band_channel_to_freq(channel, BAND_FREQ_2_4_GHZ);
-
-			func(freq, user_data);
-		}
-	}
-}
-
-void scan_freq_set_constrain(struct scan_freq_set *set,
-					const struct scan_freq_set *constraint)
-{
-	struct l_uintset *intersection;
-
-	intersection =3D l_uintset_intersect(constraint->channels_5ghz,
-							set->channels_5ghz);
-	if (!intersection)
-		/* This shouldn't ever be the case. */
-		return;
-
-	l_uintset_free(set->channels_5ghz);
-	set->channels_5ghz =3D intersection;
-
-	set->channels_2ghz &=3D constraint->channels_2ghz;
-}
-
 bool scan_wdev_add(uint64_t wdev_id)
 {
 	struct scan_context *sc;
diff --git a/src/scan.h b/src/scan.h
index 1623468e..81cb9e46 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -108,7 +108,6 @@ typedef bool (*scan_notify_func_t)(int err, struct l_qu=
eue *bss_list,
 					const struct scan_freq_set *freqs,
 					void *userdata);
 typedef void (*scan_destroy_func_t)(void *userdata);
-typedef void (*scan_freq_set_func_t)(uint32_t freq, void *userdata);
 =

 static inline int scan_bss_addr_cmp(const struct scan_bss *a1,
 					const struct scan_bss *a2)
@@ -168,18 +167,5 @@ struct scan_bss *scan_bss_new_from_probe_req(const str=
uct mmpdu_header *mpdu,
 						size_t body_len,
 						uint32_t frequency, int rssi);
 =

-struct scan_freq_set *scan_freq_set_new(void);
-void scan_freq_set_free(struct scan_freq_set *freqs);
-bool scan_freq_set_add(struct scan_freq_set *freqs, uint32_t freq);
-bool scan_freq_set_contains(const struct scan_freq_set *freqs, uint32_t fr=
eq);
-uint32_t scan_freq_set_get_bands(struct scan_freq_set *freqs);
-void scan_freq_set_foreach(const struct scan_freq_set *freqs,
-				scan_freq_set_func_t func, void *user_data);
-void scan_freq_set_merge(struct scan_freq_set *to,
-					const struct scan_freq_set *from);
-void scan_freq_set_constrain(struct scan_freq_set *set,
-					const struct scan_freq_set *constraint);
-bool scan_freq_set_isempty(const struct scan_freq_set *set);
-
 bool scan_wdev_add(uint64_t wdev_id);
 bool scan_wdev_remove(uint64_t wdev_id);
diff --git a/src/util.c b/src/util.c
index ca56316d..381894f4 100644
--- a/src/util.c
+++ b/src/util.c
@@ -35,6 +35,7 @@
 =

 #include "ell/useful.h"
 #include "src/util.h"
+#include "src/band.h"
 =

 const char *util_ssid_to_utf8(size_t len, const uint8_t *ssid)
 {
@@ -309,3 +310,163 @@ bool util_ip_prefix_tohl(const char *ip, uint8_t *pre=
fix_out,
 =

 	return true;
 }
+
+struct scan_freq_set {
+	uint16_t channels_2ghz;
+	struct l_uintset *channels_5ghz;
+};
+
+struct scan_freq_set *scan_freq_set_new(void)
+{
+	struct scan_freq_set *ret =3D l_new(struct scan_freq_set, 1);
+
+	/* 802.11-2012, 8.4.2.10 hints that 200 is the largest channel number */
+	ret->channels_5ghz =3D l_uintset_new_from_range(1, 200);
+
+	return ret;
+}
+
+void scan_freq_set_free(struct scan_freq_set *freqs)
+{
+	l_uintset_free(freqs->channels_5ghz);
+	l_free(freqs);
+}
+
+bool scan_freq_set_add(struct scan_freq_set *freqs, uint32_t freq)
+{
+	enum band_freq band;
+	uint8_t channel;
+
+	channel =3D band_freq_to_channel(freq, &band);
+	if (!channel)
+		return false;
+
+	switch (band) {
+	case BAND_FREQ_2_4_GHZ:
+		freqs->channels_2ghz |=3D 1 << (channel - 1);
+		return true;
+	case BAND_FREQ_5_GHZ:
+		return l_uintset_put(freqs->channels_5ghz, channel);
+	}
+
+	return false;
+}
+
+bool scan_freq_set_contains(const struct scan_freq_set *freqs, uint32_t fr=
eq)
+{
+	enum band_freq band;
+	uint8_t channel;
+
+	channel =3D band_freq_to_channel(freq, &band);
+	if (!channel)
+		return false;
+
+	switch (band) {
+	case BAND_FREQ_2_4_GHZ:
+		return freqs->channels_2ghz & (1 << (channel - 1));
+	case BAND_FREQ_5_GHZ:
+		return l_uintset_contains(freqs->channels_5ghz, channel);
+	}
+
+	return false;
+}
+
+uint32_t scan_freq_set_get_bands(struct scan_freq_set *freqs)
+{
+	uint32_t bands =3D 0;
+	uint32_t max;
+
+	if (freqs->channels_2ghz)
+		bands |=3D BAND_FREQ_2_4_GHZ;
+
+	max =3D l_uintset_get_max(freqs->channels_5ghz);
+
+	if (l_uintset_find_min(freqs->channels_5ghz) <=3D max)
+		bands |=3D BAND_FREQ_5_GHZ;
+
+	return bands;
+}
+
+static void scan_channels_5ghz_add(uint32_t channel, void *user_data)
+{
+	struct l_uintset *to =3D user_data;
+
+	l_uintset_put(to, channel);
+}
+
+void scan_freq_set_merge(struct scan_freq_set *to,
+					const struct scan_freq_set *from)
+{
+	to->channels_2ghz |=3D from->channels_2ghz;
+
+	l_uintset_foreach(from->channels_5ghz, scan_channels_5ghz_add,
+							to->channels_5ghz);
+}
+
+bool scan_freq_set_isempty(const struct scan_freq_set *set)
+{
+	if (set->channels_2ghz =3D=3D 0 && l_uintset_isempty(set->channels_5ghz))
+		return true;
+
+	return false;
+}
+
+struct channels_5ghz_foreach_data {
+	scan_freq_set_func_t func;
+	void *user_data;
+};
+
+static void scan_channels_5ghz_frequency(uint32_t channel, void *user_data)
+{
+	const struct channels_5ghz_foreach_data *channels_5ghz_data =3D user_data;
+	uint32_t freq;
+
+	freq =3D band_channel_to_freq(channel, BAND_FREQ_5_GHZ);
+
+	channels_5ghz_data->func(freq, channels_5ghz_data->user_data);
+}
+
+void scan_freq_set_foreach(const struct scan_freq_set *freqs,
+				scan_freq_set_func_t func, void *user_data)
+{
+	struct channels_5ghz_foreach_data data =3D { };
+	uint8_t channel;
+	uint32_t freq;
+
+	if (unlikely(!freqs || !func))
+		return;
+
+	data.func =3D func;
+	data.user_data =3D user_data;
+
+	l_uintset_foreach(freqs->channels_5ghz, scan_channels_5ghz_frequency,
+									&data);
+
+	if (!freqs->channels_2ghz)
+		return;
+
+	for (channel =3D 1; channel <=3D 14; channel++) {
+		if (freqs->channels_2ghz & (1 << (channel - 1))) {
+			freq =3D band_channel_to_freq(channel, BAND_FREQ_2_4_GHZ);
+
+			func(freq, user_data);
+		}
+	}
+}
+
+void scan_freq_set_constrain(struct scan_freq_set *set,
+					const struct scan_freq_set *constraint)
+{
+	struct l_uintset *intersection;
+
+	intersection =3D l_uintset_intersect(constraint->channels_5ghz,
+							set->channels_5ghz);
+	if (!intersection)
+		/* This shouldn't ever be the case. */
+		return;
+
+	l_uintset_free(set->channels_5ghz);
+	set->channels_5ghz =3D intersection;
+
+	set->channels_2ghz &=3D constraint->channels_2ghz;
+}
diff --git a/src/util.h b/src/util.h
index 23353ddb..8cced9cd 100644
--- a/src/util.h
+++ b/src/util.h
@@ -101,4 +101,19 @@ static inline bool util_ip_subnet_match(uint8_t prefix=
_len,
 		  ~((1u << (8 - (prefix_len % 8))) - 1));
 }
 =

+typedef void (*scan_freq_set_func_t)(uint32_t freq, void *userdata);
+
+struct scan_freq_set *scan_freq_set_new(void);
+void scan_freq_set_free(struct scan_freq_set *freqs);
+bool scan_freq_set_add(struct scan_freq_set *freqs, uint32_t freq);
+bool scan_freq_set_contains(const struct scan_freq_set *freqs, uint32_t fr=
eq);
+uint32_t scan_freq_set_get_bands(struct scan_freq_set *freqs);
+void scan_freq_set_foreach(const struct scan_freq_set *freqs,
+				scan_freq_set_func_t func, void *user_data);
+void scan_freq_set_merge(struct scan_freq_set *to,
+					const struct scan_freq_set *from);
+void scan_freq_set_constrain(struct scan_freq_set *set,
+					const struct scan_freq_set *constraint);
+bool scan_freq_set_isempty(const struct scan_freq_set *set);
+
 #endif /* __UTIL_H */
-- =

2.31.1

--===============0333889133407914589==--

