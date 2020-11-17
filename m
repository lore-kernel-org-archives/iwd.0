Content-Type: multipart/mixed; boundary="===============2443422316127167474=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: use hwsim_medium=no (testSAE/HiddenNetworks)
Date: Tue, 17 Nov 2020 10:50:07 -0800
Message-ID: <20201117185007.3536477-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2443422316127167474==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Both these tests create many radios which sometimes causes timing
problems when hwsim is running. Since hwsim is not required for
these tests we can disable it and increase test reliability.
---
 autotests/testHiddenNetworks/hw.conf | 3 +--
 autotests/testSAE/hw.conf            | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/autotests/testHiddenNetworks/hw.conf b/autotests/testHiddenNet=
works/hw.conf
index 7147e4be..065e9003 100644
--- a/autotests/testHiddenNetworks/hw.conf
+++ b/autotests/testHiddenNetworks/hw.conf
@@ -1,8 +1,7 @@
 [SETUP]
 num_radios=3D7
 start_iwd=3D0
-max_test_exec_interval_sec=3D160
-tmpfs_extra_stuff=3Dmain.conf
+hwsim_medium=3Dno
 =

 [HOSTAPD]
 rad0=3DssidHiddenOpen.conf
diff --git a/autotests/testSAE/hw.conf b/autotests/testSAE/hw.conf
index d79aa1c7..86f42630 100644
--- a/autotests/testSAE/hw.conf
+++ b/autotests/testSAE/hw.conf
@@ -1,7 +1,7 @@
 [SETUP]
 num_radios=3D7
 start_iwd=3D0
-max_test_exec_interval_sec=3D45
+hwsim_medium=3Dno
 =

 [HOSTAPD]
 rad0=3DssidSAE.conf
-- =

2.26.2

--===============2443422316127167474==--

