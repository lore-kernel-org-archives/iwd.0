Content-Type: multipart/mixed; boundary="===============0418529329341555750=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/6] dpp-util: move up va_end before possible error case
Date: Fri, 18 Mar 2022 09:44:16 -0700
Message-ID: <20220318164420.739968-2-prestwoj@gmail.com>
In-Reply-To: 20220318164420.739968-1-prestwoj@gmail.com

--===============0418529329341555750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was caught by static analysis
---
 src/dpp-util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index cd627e2a..8e7631d0 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -408,6 +408,8 @@ size_t dpp_append_wrapped_data(const void *ad0, size_t =
ad0_len,
 		va_arg(va, void*);
 	}
 =

+	va_end(va);
+
 	if (to_len < attrs_len + 4 + 16)
 		return false;
 =

@@ -415,8 +417,6 @@ size_t dpp_append_wrapped_data(const void *ad0, size_t =
ad0_len,
 =

 	ptr =3D plaintext;
 =

-	va_end(va);
-
 	va_start(va, num_attrs);
 =

 	/* Build up plaintext attributes */
-- =

2.34.1

--===============0418529329341555750==--

