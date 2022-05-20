Content-Type: multipart/mixed; boundary="===============6895989396627898732=="
MIME-Version: 1.0
From: Jesse Lentz <jesse at twosheds.org>
To: iwd at lists.01.org
Subject: [PATCH 2/2] Document initial signal level notification
Date: Fri, 20 May 2022 14:59:48 -0400
Message-ID: <20220520185948.9533-2-jesse@twosheds.org>
In-Reply-To: 20220520185948.9533-1-jesse@twosheds.org

--===============6895989396627898732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Document the initial "Changed" method call following SignalLevelAgent
registration.
---
 doc/station-api.txt | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/doc/station-api.txt b/doc/station-api.txt
index 0bb372ab..05dd137e 100644
--- a/doc/station-api.txt
+++ b/doc/station-api.txt
@@ -182,16 +182,17 @@ Methods		void Release(object device) [noreply]
 		void Changed(object device, uint8 level) [noreply]
 =

 			This method gets called when the signal strength
-			measurement for the device's connected network
-			changes enough to go from one level to another out
-			of the N ranges defined by the array of (N-1)
-			threshold values passed to RegisterSignalLevelAgent().
-			The level parameter is in the range from 0 to N,
-			0 being the strongest signal or above the first
-			threshold value in the array, and N being the
-			weakest and below the last threshold value.  For
-			example if RegisterSignalLevelAgent was called with
-			the array [-40, -50, -60], the 'level' parameter of
-			0 would mean signal is received at -40 or more dBm
-			and 3 would mean below -60 dBm and might correspond
-			to 1 out of 4 bars on a UI signal meter.
+			measurement for the device's connected network changes
+			enough to go from one level to another out of the N
+			ranges defined by the array of (N-1) threshold values
+			passed to RegisterSignalLevelAgent().  It also gets
+			called immediately after the signal level agent is
+			registered.  The level parameter is in the range from 0
+			to N, 0 being the strongest signal or above the first
+			threshold value in the array, and N being the weakest
+			and below the last threshold value.  For example if
+			RegisterSignalLevelAgent was called with the array [-40,
+			-50, -60], the 'level' parameter of 0 would mean signal
+			is received at -40 or more dBm and 3 would mean below
+			-60 dBm and might correspond to 1 out of 4 bars on a UI
+			signal meter.
-- =

2.36.0

--===============6895989396627898732==--

