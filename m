Content-Type: multipart/mixed; boundary="===============2229536279601855624=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/4] ie: parse RSNXE Present bit
Date: Tue, 21 Sep 2021 13:44:45 -0700
Message-ID: <20210921204448.119199-1-prestwoj@gmail.com>

--===============2229536279601855624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ie.c | 1 +
 src/ie.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index 0440373c..b2a8102a 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -1732,6 +1732,7 @@ int ie_parse_fast_bss_transition(struct ie_tlv_iter *=
iter, uint32_t mic_len,
 =

 	memset(info, 0, sizeof(*info));
 =

+	info->rsnxe_used =3D test_bit(data, 0);
 	info->mic_element_count =3D data[1];
 =

 	memcpy(info->mic, data + 2, mic_len);
diff --git a/src/ie.h b/src/ie.h
index f64072b3..844e9950 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -419,6 +419,7 @@ enum ie_bss_capability {
 =

 struct ie_ft_info {
 	uint8_t mic_element_count;
+	bool rsnxe_used;
 	uint8_t mic[24];
 	uint8_t anonce[32];
 	uint8_t snonce[32];
-- =

2.31.1

--===============2229536279601855624==--

