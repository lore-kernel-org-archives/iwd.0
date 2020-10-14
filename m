Content-Type: multipart/mixed; boundary="===============3591367706630844030=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] doc: Fix SignalLevelAgent interface name and filename
 pointers
Date: Wed, 14 Oct 2020 14:35:20 +0200
Message-ID: <20201014123520.1245755-2-andrew.zaborowski@intel.com>
In-Reply-To: <20201014123520.1245755-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3591367706630844030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When the SignalLevelAgent doc blurb was moved to station-api.txt it
seems the interface was changed to Station.SignalLevelAgent in some
places but not in most and not in the code.  Also fix the pointers to
the doc file.
---
 doc/p2p-api.txt     |  4 ++--
 doc/station-api.txt | 30 ++++++++++++++----------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/doc/p2p-api.txt b/doc/p2p-api.txt
index 08ee8d92..b10c51ed 100644
--- a/doc/p2p-api.txt
+++ b/doc/p2p-api.txt
@@ -47,8 +47,8 @@ Methods		array(on) GetPeers()
 =

 			Register the agent object to receive signal strength
 			level change notifications on the
-			net.connman.iwd.Station.SignalLevelAgent interface,
-			see station-api.txt.  The "levels" parameter decides
+			net.connman.iwd.SignalLevelAgent interface, see
+			station-api.txt.  The "levels" parameter decides
 			the thresholds in dBm that will generate a call to
 			the agent's Changed method whenever current RSSI
 			crosses any of the values.  The values must be
diff --git a/doc/station-api.txt b/doc/station-api.txt
index b2131890..f5aef0d5 100644
--- a/doc/station-api.txt
+++ b/doc/station-api.txt
@@ -112,14 +112,13 @@ Methods		void Scan()
 			Register the agent object to receive signal strength
 			level change notifications on the
 			net.connman.iwd.SignalLevelAgent interface, see
-			signal-level-agent-api.txt.  The "levels"
-			parameters decides the thresholds in dBm that will
-			generate a call to the agent's Changed
-			method whenever current RSSI crosses any of the
-			values.  The values must be passed in descending
-			order.  The number and distance between requested
-			threshold values is a compromise between resolution
-			and the frequency of system wakeups and
+			below.  The "levels" parameters decides the
+			thresholds in dBm that will generate a call to the
+			agent's Changed method whenever current RSSI crosses
+			any of the values.  The values must be passed in
+			descending order.  The number and distance between
+			requested threshold values is a compromise between
+			resolution and the frequency of system wakeups and
 			context-switches that are going to be occurring to
 			update the client's signal meter.  Only one agent
 			can be registered at any time.
@@ -187,14 +186,13 @@ Methods		void Release(object device)
 			changes enough to go from one level to another out
 			of the N ranges defined by the array of (N-1)
 			threshold values passed to
-			net.connman.iwd.Station.RegisterSignalLevelAgent
-			(see device-api.txt.)  The level parameter is in
-			the range from 0 to N, 0 being the strongest
-			signal or above the first threshold value in the
-			array, and N being the weakest and below the
-			last threshold value.  For example if
-			RegisterSignalLevelAgent was called with the
-			array [-40, -50, -60], the 'level' parameter of
+			net.connman.iwd.RegisterSignalLevelAgent.
+			The level parameter is in the range from 0 to N,
+			0 being the strongest signal or above the first
+			threshold value in the array, and N being the
+			weakest and below the last threshold value.  For
+			example if RegisterSignalLevelAgent was called with
+			the array [-40, -50, -60], the 'level' parameter of
 			0 would mean signal is received at -40 or more dBm
 			and 3 would mean below -60 dBm and might correspond
 			to 1 out of 4 bars on a UI signal meter.
-- =

2.25.1

--===============3591367706630844030==--

