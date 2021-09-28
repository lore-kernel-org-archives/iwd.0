Content-Type: multipart/mixed; boundary="===============4041213597630995720=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/6] auto-t: add OCV to FILS test
Date: Tue, 28 Sep 2021 15:36:05 -0700
Message-ID: <20210928223609.1163537-2-prestwoj@gmail.com>
In-Reply-To: 20210928223609.1163537-1-prestwoj@gmail.com

--===============4041213597630995720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testFILS/ssidFILS-256.conf | 1 +
 autotests/testFILS/ssidFILS-384.conf | 1 +
 2 files changed, 2 insertions(+)

diff --git a/autotests/testFILS/ssidFILS-256.conf b/autotests/testFILS/ssid=
FILS-256.conf
index a5f70f3a..66d4bfb5 100644
--- a/autotests/testFILS/ssidFILS-256.conf
+++ b/autotests/testFILS/ssidFILS-256.conf
@@ -19,3 +19,4 @@ disable_pmksa_caching=3D1
 =

 wpa_group_rekey=3D30
 wpa_ptk_rekey=3D30
+ocv=3D1
diff --git a/autotests/testFILS/ssidFILS-384.conf b/autotests/testFILS/ssid=
FILS-384.conf
index 613c37be..5254d5f8 100644
--- a/autotests/testFILS/ssidFILS-384.conf
+++ b/autotests/testFILS/ssidFILS-384.conf
@@ -19,3 +19,4 @@ disable_pmksa_caching=3D1
 =

 wpa_group_rekey=3D30
 wpa_ptk_rekey=3D30
+ocv=3D1
-- =

2.31.1

--===============4041213597630995720==--

