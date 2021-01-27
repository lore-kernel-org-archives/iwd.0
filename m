Content-Type: multipart/mixed; boundary="===============0026096627846337199=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: [PATCH 5/5] doc: update test-runner invocation documentation
Date: Wed, 27 Jan 2021 10:05:04 +0000
Message-ID: <20210127100457.341757-5-alsi@bang-olufsen.dk>
In-Reply-To: <20210127100457.341757-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0026096627846337199==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The test-runner no longer recognizes -t to specify an autotest. Instead
it uses -A.
---
 doc/test-runner.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index c5f29324..89a7c44c 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -137,16 +137,16 @@ tests shipped with IWD:
 	$ sudo ./test-runner
 =

 One can specify a particular set of test configurations to be executed by =
using
-'-t <dir1,dir2>' parameter. An absolute path is necessary for the test
+'-A <dir1,dir2>' parameter. An absolute path is necessary for the test
 configuration directories outside of <iwd>/autotests.
 =

 The command line may look as follows:
 =

-	$ sudo ./test-runner -t test1,test3,/home/test4
+	$ sudo ./test-runner -A test1,test3,/home/test4
 =

 Glob matching is also supported when specifying a test list:
 =

-	$ sudo ./test-runner -t testWPA*
+	$ sudo ./test-runner -A testWPA*
 =

 =

 Creating Test Configurations
-- =

2.29.2
--===============0026096627846337199==--

