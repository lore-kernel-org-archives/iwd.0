Content-Type: multipart/mixed; boundary="===============7890891885431168622=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/3] util: surround MAC_STR array access with ()
Date: Mon, 27 Sep 2021 15:41:34 -0700
Message-ID: <20210927224136.312226-1-prestwoj@gmail.com>

--===============7890891885431168622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This allows printing from pointer offsets, for example:

MAC_STR(buf + 10)
---
 src/util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/util.h b/src/util.h
index ae640698..23353ddb 100644
--- a/src/util.h
+++ b/src/util.h
@@ -29,7 +29,7 @@
 #define align_len(len, boundary) (((len)+(boundary)-1) & ~((boundary)-1))
 =

 #define MAC "%02x:%02x:%02x:%02x:%02x:%02x"
-#define MAC_STR(a) a[0], a[1], a[2], a[3], a[4], a[5]
+#define MAC_STR(a) (a)[0], (a)[1], (a)[2], (a)[3], (a)[4], (a)[5]
 =

 const char *util_ssid_to_utf8(size_t len, const uint8_t *ssid);
 bool util_ssid_is_utf8(size_t len, const uint8_t *ssid);
-- =

2.31.1

--===============7890891885431168622==--

