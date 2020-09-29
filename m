Content-Type: multipart/mixed; boundary="===============0742281621755226521=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/8] test-runner: Make hwsim medium optional
Date: Tue, 29 Sep 2020 18:37:13 +0200
Message-ID: <20200929163717.754459-10-andrew.zaborowski@intel.com>
In-Reply-To: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0742281621755226521==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Allow the "hwsim_medium=3Dno" setting in hw.conf's SETUP section to
disable starting hwsim.  It looks like the packets going through
userspace add enough latency that active scans don't work, probe
responses don't arrive within the "dwell time" or probe requests are not
ACKed on time.  I've tried modifying tools/hwsim.c to respond with the
HWSIM_CMD_TX_INFO_FRAME cmd as the first thing after receiving a
HWSIM_CMD_FRAME and even skipping the queue in ell/genl.c by writing the
command synchronously, but neither helped enough to make the scans work.
This does not rule out that hwsim or the way our scans are done can be
fixed and that would obviously be better than what I did in this patch.
---
 tools/test-runner | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/test-runner b/tools/test-runner
index dc6b1f7a..ea0f7b79 100755
--- a/tools/test-runner
+++ b/tools/test-runner
@@ -516,8 +516,9 @@ class TestContext:
 			self.radios.append(VirtualRadio(name, rad_config))
 			self.cur_radio_id +=3D 1
 =

-		# register hwsim as medium
-		self.start_process(['hwsim'])
+		if self.hw_config['SETUP'].get('hwsim_medium', 'yes') in ['yes', '1', 't=
rue']:
+			# register hwsim as medium
+			self.start_process(['hwsim'])
 =

 	def discover_radios(self):
 		phys =3D []
-- =

2.25.1

--===============0742281621755226521==--

