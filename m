Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6DD4A0A
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 18:47:38 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id g13so10726654plo.6
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ScYNqYcGxI0Yy3FBPl3VJlZtt2r+8cp6HszI1rnbEQU=;
        b=K1unrB8jAKkJuSD7nwqsrDUrpm3vs/kmpEUgxNDPIkZTpofyMRaEzCwbX+9Aslodwq
         VWomrGQCK158sXoYObQzTaGJmpU0tIunXFLD/6RNQcweEGp12CmNP183gCM/LnzdQeGK
         JX6iSpueeJogmFqBBwRjDf3QU2WH85ORXKfMVWSDu1JRwniO2fdfaCZOBOnGjZ0t/hq0
         fsuGUWJLTBfZY9zk/R/AEBTWUdZKzck4pOQcq8nnutgO/OOJYVexvGeydgoy3a3cEHrn
         +i9xsuBNmXAQbPLY2zuRkMCCYkzU2u8k3wP4/5E+ht8jV9cuhTgZwfbWAD9Dm79ZxdvE
         xflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ScYNqYcGxI0Yy3FBPl3VJlZtt2r+8cp6HszI1rnbEQU=;
        b=Fp9xHCWEDQEW0+nmwyCCEbPnhSNOvhPeNtLdZY1+O9+2Q1uAq4V/TaHJdDsXycLjTM
         GG/Qr+R1ntiKajAN90HmQmQFzo/yvnLRacipfhPBG/zfxoxuU3icMAIgyJtZokd/fWG6
         GIW9iB68D338t+xO5aGN+9Ij2WB1qNHPSRYhFr4BlNmXNKp9rHRwoiWF4TzJiUQ62oXT
         hdNcRi5Ne2v3ChR3suj7YFUL1FGU7CoBfmxw/oM3P5IQduIPZHmBwt9KDgY6pQvrVqtR
         5AQcdM/Mkkn50iZfZH/bIoUGIKXAHoU6btg4u1nIKOcLpo1M4uQMlYLWCpxr83VII2jM
         /tLw==
X-Gm-Message-State: ACgBeo0j7vb7i6PGlDWOR+B2iPLC2B0AtjYMd5WOfBpIgL9A8Nh+vAVY
	MoacIoHTsQVFNKWs7JILB3dQoJzCTOQ=
X-Google-Smtp-Source: AA6agR7KaZbWwW28fVrTmxUkXw63sZrRHj8TC3NEZh2z2ZXkZNno3Px98aeWuX2RWnLRxuX/+SPTQg==
X-Received: by 2002:a17:902:70c7:b0:170:9030:8219 with SMTP id l7-20020a17090270c700b0017090308219mr419623plt.163.1660243657875;
        Thu, 11 Aug 2022 11:47:37 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b0052b84ca900csm24986pfh.62.2022.08.11.11.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:47:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/6] doc: add documentation for StationDebug
Date: Thu, 11 Aug 2022 11:47:30 -0700
Message-Id: <20220811184735.465951-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/station-debug-api.txt | 68 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 doc/station-debug-api.txt

v3:
 * Removed the special /hidden object 

diff --git a/doc/station-debug-api.txt b/doc/station-debug-api.txt
new file mode 100644
index 00000000..ad91fc3b
--- /dev/null
+++ b/doc/station-debug-api.txt
@@ -0,0 +1,68 @@
+Station Debug hierarchy [experimental]
+============================
+
+These are all development APIs not meant for production use.
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.StationDebug
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
+
+Methods		void ConnectBssid(array(y) address)
+
+			Connect to a specific BSS. The address parameter should
+			be a byte array of length 6, the BSSID of a BSS which
+			IWD already has in its scan list.
+
+			Possible errors: net.connman.iwd.InvalidArguments
+					 net.connman.iwd.NotFound
+
+		void Roam(array(y) address)
+
+			Roam to a specific BSS. The address parameter should be
+			a byte array of length 6, the BSSID of a BSS to roam to.
+			This BSS needs to be in IWD's scan results and fit the
+			requirements for a roam candidate (same network).
+			The type of roam is dependent on the network and is
+			chosen automatically by IWD.
+
+			Possible errors: net.connman.iwd.InvalidArguments
+					 net.connman.iwd.NotConnected
+
+		void Scan(array(q) frequencies)
+
+			Scan on specific frequencies. The frequencies parameter
+			should be a list of valid frequencies.
+
+			Possible errors: net.connman.iwd.Busy
+					 net.connman.iwd.InvalidArguments
+					 net.connamn.iwd.Failed
+
+		a{oaa{sv}} GetNetworks()
+
+			Get a list of networks including data for individual
+			BSS's. Returns a dictionary where keys are network
+			object paths and values are arrays of dictionaries
+			containing BSS information:
+
+			{
+				/network/path/1: [
+					{
+						Address: 11:22:33:44:55,
+						Frequency: 1234,
+						RSSI: -20,
+						Rank: 1000
+						MDE: 001122
+					},
+					{ ... }
+				]
+			}
+
+Signals:	Event(s name, av data)
+
+			Signal sent for various debug events. The 'name' is the
+			event name, and 'data' is event dependent.
+
+Properties:	boolean AutoConnect
+
+			True if IWD is in an autoconnect state. This property
+			can be written to put IWD into an autoconnect state.
-- 
2.34.3

