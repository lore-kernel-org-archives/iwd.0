Content-Type: multipart/mixed; boundary="===============6860293332835581776=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/5] util: add util_is_valid_sta_address
Date: Thu, 19 Mar 2020 15:58:58 -0700
Message-ID: <20200319225902.16249-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6860293332835581776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Checks that that address is neither broadcast or group
---
 src/util.c | 5 +++++
 src/util.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/util.c b/src/util.c
index 0c41ceb5..13b01c81 100644
--- a/src/util.c
+++ b/src/util.c
@@ -166,6 +166,11 @@ bool util_is_broadcast_address(const uint8_t *addr)
 	return !memcmp(addr, bcast_addr, 6);
 }
 =

+bool util_is_valid_sta_address(const uint8_t *addr)
+{
+	return !util_is_broadcast_address(addr) && !util_is_group_address(addr);
+}
+
 /* This function assumes that identity is not bigger than 253 bytes */
 const char *util_get_domain(const char *identity)
 {
diff --git a/src/util.h b/src/util.h
index dfd1c847..edc6e777 100644
--- a/src/util.h
+++ b/src/util.h
@@ -38,6 +38,7 @@ const char *util_address_to_string(const uint8_t *addr);
 bool util_string_to_address(const char *str, uint8_t *addr);
 bool util_is_group_address(const uint8_t *addr);
 bool util_is_broadcast_address(const uint8_t *addr);
+bool util_is_valid_sta_address(const uint8_t *addr);
 =

 const char *util_get_domain(const char *identity);
 const char *util_get_username(const char *identity);
-- =

2.21.1

--===============6860293332835581776==--

