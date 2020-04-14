Content-Type: multipart/mixed; boundary="===============2002947754235498265=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v3 2/3] auto-t: Remove unused imports
Date: Mon, 13 Apr 2020 18:16:44 -0700
Message-ID: <20200414011645.22321-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200414011645.22321-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2002947754235498265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testAdHoc/adhoc_test.py         | 1 -
 autotests/testFILS/fils_256_test.py       | 2 --
 autotests/testFILS/fils_384_test.py       | 2 --
 autotests/testHotspot/autoconnect_test.py | 2 --
 4 files changed, 7 deletions(-)

diff --git a/autotests/testAdHoc/adhoc_test.py b/autotests/testAdHoc/adhoc_=
test.py
index 83c99fe5..119c6c7e 100644
--- a/autotests/testAdHoc/adhoc_test.py
+++ b/autotests/testAdHoc/adhoc_test.py
@@ -3,7 +3,6 @@
 import unittest
 import sys
 import time
-from time import sleep
 =

 sys.path.append('../util')
 import iwd
diff --git a/autotests/testFILS/fils_256_test.py b/autotests/testFILS/fils_=
256_test.py
index 1894c074..aa9e441d 100644
--- a/autotests/testFILS/fils_256_test.py
+++ b/autotests/testFILS/fils_256_test.py
@@ -4,8 +4,6 @@ import unittest
 import sys
 import os
 =

-from time import sleep
-
 sys.path.append('../util')
 import iwd
 from iwd import IWD
diff --git a/autotests/testFILS/fils_384_test.py b/autotests/testFILS/fils_=
384_test.py
index 09ff0b21..ed5cc3b0 100644
--- a/autotests/testFILS/fils_384_test.py
+++ b/autotests/testFILS/fils_384_test.py
@@ -4,8 +4,6 @@ import unittest
 import sys
 import os
 =

-from time import sleep
-
 sys.path.append('../util')
 import iwd
 from iwd import IWD
diff --git a/autotests/testHotspot/autoconnect_test.py b/autotests/testHots=
pot/autoconnect_test.py
index 936373f1..edefb296 100644
--- a/autotests/testHotspot/autoconnect_test.py
+++ b/autotests/testHotspot/autoconnect_test.py
@@ -4,8 +4,6 @@ import unittest
 import sys
 import os
 =

-from time import sleep
-
 sys.path.append('../util')
 import iwd
 from iwd import IWD
-- =

2.13.6

--===============2002947754235498265==--

