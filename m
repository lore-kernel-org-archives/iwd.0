Content-Type: multipart/mixed; boundary="===============6988651693849721605=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] doc: add section about regulatory.db missing
Date: Mon, 07 Oct 2019 09:35:44 -0700
Message-ID: <20191007163544.15041-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6988651693849721605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It was found that some distros do not ship with a regulatory.db file.
This is required to run some of the autotests, and if not found on the
system the kernel build will fail due to some of the IWD config
options which require regulatory.db.

The fix is to manually download regulatory.db from git.kernel.org and
place it in /lib/firmware.
---
 doc/test-runner.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

-v2:
 * Fixed missing 'this' in sentence

diff --git a/doc/test-runner.txt b/doc/test-runner.txt
index 3660381a..ccc17f7b 100644
--- a/doc/test-runner.txt
+++ b/doc/test-runner.txt
@@ -69,6 +69,16 @@ After that a default kernel with the required options ca=
n be built:
 =

 	$ make -j$(nproc)
 =

+Note: If your host distribution does not contain a regulatory.db you may g=
et an
+error similar to this when building the kernel:
+
+No rule to make target '/lib/firmware/regulatory.db'...
+
+To fix this you must download the regulatory.db manually and place it in
+/lib/firmware. This can be found here:
+
+https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git
+
 Note: To catch locking related issues the following set of kernel config
 options may be useful:
 =

-- =

2.17.1

--===============6988651693849721605==--

