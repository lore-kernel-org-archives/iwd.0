Content-Type: multipart/mixed; boundary="===============8231407831325546184=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH 1/2] test-runner: Add missing space between qemus arguments
Date: Sat, 07 Mar 2020 19:01:12 +0100
Message-ID: <20200307180113.30779-1-wagi@monom.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8231407831325546184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 6a3a29325ce8..c4623d790446 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -408,7 +408,7 @@ static bool start_qemu(void)
 			"mac80211_hwsim.radios=3D0 init=3D%s TESTHOME=3D%s "
 			"TESTVERBOUT=3D\'%s\' DEBUG_FILTER=3D\'%s\'"
 			"TEST_ACTION=3D%u TEST_ACTION_PARAMS=3D\'%s\' "
-			"TESTARGS=3D\'%s\' PATH=3D\'%s\' VALGRIND=3D%u"
+			"TESTARGS=3D\'%s\' PATH=3D\'%s\' VALGRIND=3D%u "
 			"GDB=3D\'%s\' HW=3D\'%s\' SHELL=3D%u "
 			"LOG_PATH=3D\'%s\' LOG_UID=3D\'%d\' LOG_GID=3D\'%d\'",
 			check_verbosity("kernel") ? "ignore_loglevel" : "quiet",
-- =

2.25.1
--===============8231407831325546184==--

