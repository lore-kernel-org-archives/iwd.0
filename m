Content-Type: multipart/mixed; boundary="===============3742801999334266129=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 15/15] doc: Document autotests' wpa_supplicant dependency
Date: Fri, 04 Jun 2021 03:50:52 +0200
Message-ID: <20210604015052.163727-15-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3742801999334266129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/test-runner.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 89a7c44c..9140aa0f 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -28,6 +28,7 @@ OS:
 	10. <iwd>/src/iwd	0.0
 	11. ofono (optional)
 	12. phonesim (optional)
+	13. wpa_supplicant	2.9
 =

 Note: The version for hostapd is listed as 'recent'. Older hostapd versions
 will work but we are continually adopting new features from hostapd and us=
ing
-- =

2.30.2

--===============3742801999334266129==--

