Content-Type: multipart/mixed; boundary="===============0231397497632657234=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 6/7] t-runner: Check for NULL before using strcmp
Date: Tue, 22 Oct 2019 16:13:16 -0700
Message-ID: <20191022231317.11634-6-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191022231317.11634-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0231397497632657234==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 tools/test-runner.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/test-runner.c b/tools/test-runner.c
index 0226dd15..398494e6 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -2957,9 +2957,9 @@ int main(int argc, char *argv[])
 			break;
 		case 'g':
 			gdb_opt =3D optarg;
-			if (!(!strcmp(gdb_opt, "iwd") ||
-					!strcmp(gdb_opt, "hostapd") ||
-					!strcmp(gdb_opt, "hwsim"))) {
+			if (!gdb_opt || (strcmp(gdb_opt, "iwd") &&
+					strcmp(gdb_opt, "hostapd") &&
+					strcmp(gdb_opt, "hwsim"))) {
 				l_error("--gdb can only be used with iwd"
 					", hwsim or hostapd");
 				return EXIT_FAILURE;
-- =

2.13.6

--===============0231397497632657234==--

