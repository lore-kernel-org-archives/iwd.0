Content-Type: multipart/mixed; boundary="===============1950774803217118371=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 05/11] util: add 6GHz support to scan_freq_set* APIs
Date: Fri, 25 Feb 2022 09:58:04 -0800
Message-ID: <20220225175810.2914413-5-prestwoj@gmail.com>
In-Reply-To: 20220225175810.2914413-1-prestwoj@gmail.com

--===============1950774803217118371==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 6GHz channels are stored and accessed identically to 5GHz,
just using a separate uintset object.
---
 src/util.c | 53 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/src/util.c b/src/util.c
index 16df59ac..2832486d 100644
--- a/src/util.c
+++ b/src/util.c
@@ -314,6 +314,7 @@ bool util_ip_prefix_tohl(const char *ip, uint8_t *prefi=
x_out,
 struct scan_freq_set {
 	uint16_t channels_2ghz;
 	struct l_uintset *channels_5ghz;
+	struct l_uintset *channels_6ghz;
 };
 =

 struct scan_freq_set *scan_freq_set_new(void)
@@ -322,6 +323,7 @@ struct scan_freq_set *scan_freq_set_new(void)
 =

 	/* 802.11-2012, 8.4.2.10 hints that 200 is the largest channel number */
 	ret->channels_5ghz =3D l_uintset_new_from_range(1, 200);
+	ret->channels_6ghz =3D l_uintset_new_from_range(1, 233);
 =

 	return ret;
 }
@@ -329,6 +331,7 @@ struct scan_freq_set *scan_freq_set_new(void)
 void scan_freq_set_free(struct scan_freq_set *freqs)
 {
 	l_uintset_free(freqs->channels_5ghz);
+	l_uintset_free(freqs->channels_6ghz);
 	l_free(freqs);
 }
 =

@@ -348,7 +351,7 @@ bool scan_freq_set_add(struct scan_freq_set *freqs, uin=
t32_t freq)
 	case BAND_FREQ_5_GHZ:
 		return l_uintset_put(freqs->channels_5ghz, channel);
 	case BAND_FREQ_6_GHZ:
-		return false;
+		return l_uintset_put(freqs->channels_6ghz, channel);
 	}
 =

 	return false;
@@ -369,7 +372,7 @@ bool scan_freq_set_contains(const struct scan_freq_set =
*freqs, uint32_t freq)
 	case BAND_FREQ_5_GHZ:
 		return l_uintset_contains(freqs->channels_5ghz, channel);
 	case BAND_FREQ_6_GHZ:
-		return false;
+		return l_uintset_contains(freqs->channels_6ghz, channel);
 	}
 =

 	return false;
@@ -388,10 +391,15 @@ uint32_t scan_freq_set_get_bands(struct scan_freq_set=
 *freqs)
 	if (l_uintset_find_min(freqs->channels_5ghz) <=3D max)
 		bands |=3D BAND_FREQ_5_GHZ;
 =

+	max =3D l_uintset_get_max(freqs->channels_6ghz);
+
+	if (l_uintset_find_min(freqs->channels_6ghz) <=3D max)
+		bands |=3D BAND_FREQ_6_GHZ;
+
 	return bands;
 }
 =

-static void scan_channels_5ghz_add(uint32_t channel, void *user_data)
+static void scan_channels_add(uint32_t channel, void *user_data)
 {
 	struct l_uintset *to =3D user_data;
 =

@@ -403,37 +411,41 @@ void scan_freq_set_merge(struct scan_freq_set *to,
 {
 	to->channels_2ghz |=3D from->channels_2ghz;
 =

-	l_uintset_foreach(from->channels_5ghz, scan_channels_5ghz_add,
+	l_uintset_foreach(from->channels_5ghz, scan_channels_add,
 							to->channels_5ghz);
+	l_uintset_foreach(from->channels_6ghz, scan_channels_add,
+							to->channels_6ghz);
 }
 =

 bool scan_freq_set_isempty(const struct scan_freq_set *set)
 {
-	if (set->channels_2ghz =3D=3D 0 && l_uintset_isempty(set->channels_5ghz))
+	if (set->channels_2ghz =3D=3D 0 && l_uintset_isempty(set->channels_5ghz) =
&&
+					l_uintset_isempty(set->channels_6ghz))
 		return true;
 =

 	return false;
 }
 =

-struct channels_5ghz_foreach_data {
+struct channels_foreach_data {
 	scan_freq_set_func_t func;
+	enum band_freq band;
 	void *user_data;
 };
 =

-static void scan_channels_5ghz_frequency(uint32_t channel, void *user_data)
+static void scan_channels_foreach(uint32_t channel, void *user_data)
 {
-	const struct channels_5ghz_foreach_data *channels_5ghz_data =3D user_data;
+	const struct channels_foreach_data *channels_data =3D user_data;
 	uint32_t freq;
 =

-	freq =3D band_channel_to_freq(channel, BAND_FREQ_5_GHZ);
+	freq =3D band_channel_to_freq(channel, channels_data->band);
 =

-	channels_5ghz_data->func(freq, channels_5ghz_data->user_data);
+	channels_data->func(freq, channels_data->user_data);
 }
 =

 void scan_freq_set_foreach(const struct scan_freq_set *freqs,
 				scan_freq_set_func_t func, void *user_data)
 {
-	struct channels_5ghz_foreach_data data =3D { };
+	struct channels_foreach_data data =3D { };
 	uint8_t channel;
 	uint32_t freq;
 =

@@ -441,10 +453,14 @@ void scan_freq_set_foreach(const struct scan_freq_set=
 *freqs,
 		return;
 =

 	data.func =3D func;
+	data.band =3D BAND_FREQ_5_GHZ;
 	data.user_data =3D user_data;
 =

-	l_uintset_foreach(freqs->channels_5ghz, scan_channels_5ghz_frequency,
-									&data);
+	l_uintset_foreach(freqs->channels_5ghz, scan_channels_foreach, &data);
+
+	data.band =3D BAND_FREQ_6_GHZ;
+
+	l_uintset_foreach(freqs->channels_6ghz, scan_channels_foreach, &data);
 =

 	if (!freqs->channels_2ghz)
 		return;
@@ -472,6 +488,14 @@ void scan_freq_set_constrain(struct scan_freq_set *set,
 	l_uintset_free(set->channels_5ghz);
 	set->channels_5ghz =3D intersection;
 =

+	intersection =3D l_uintset_intersect(constraint->channels_6ghz,
+							set->channels_6ghz);
+	if (!intersection)
+		return;
+
+	l_uintset_free(set->channels_6ghz);
+	set->channels_6ghz =3D intersection;
+
 	set->channels_2ghz &=3D constraint->channels_2ghz;
 }
 =

@@ -491,7 +515,8 @@ uint32_t *scan_freq_set_to_fixed_array(const struct sca=
n_freq_set *set,
 	uint32_t *freqs;
 =

 	count =3D __builtin_popcount(set->channels_2ghz) +
-				l_uintset_size(set->channels_5ghz);
+				l_uintset_size(set->channels_5ghz) +
+				l_uintset_size(set->channels_6ghz);
 =

 	if (!count)
 		return NULL;
-- =

2.34.1

--===============1950774803217118371==--

