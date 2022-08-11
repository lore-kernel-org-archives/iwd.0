Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D132CA7
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 17:59:04 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 73so17724267pgb.9
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Ipl4an6rKguN3FMXDtrPuFyxjG+SRjLiEMvLxzXRQQY=;
        b=KQO42zjYJvMpbafuCc/xa6YfYZA6uNyciBRPcLEqzjF+sGlmf2eIOiSatmZJcfVt1g
         yENLfmyjZRNKN4YORd6VWF77CeitPosUlEI+vMd+UnTCIYKz41oV80kFcFK0DvC3zrju
         uS7W9IbPBENEHF1TrcNuvMUh3AERI5+kzuXDImli4H9WbVymf17rCsxuNGRKK/VU76v0
         ZImiGB0ZtD72LdJ6Byvvm6Pw49oF+w9yYWlFfK3RtxNTO8yN+Cm6cYbSm9HVScI2ttqj
         f9cO1xzc5XeBM414nyxa2al4jLHLRiylNE6YGJMU79VAUmlp0IOSKKFcYAnJBb04hgRf
         oztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Ipl4an6rKguN3FMXDtrPuFyxjG+SRjLiEMvLxzXRQQY=;
        b=pPaGMhGuqrYRw1ipeEZjUxDRjTxbsgVCrSOgIYVpb8lUfgrmC2b9b4yJTWTwk+1yrO
         LBX5azx1pM/H3+yBk/4h2KOOfQBY+MaWeqyrCVXUiczaCPu/EtJ3g4PBGj8c1qUSk03T
         S+h6GsjFge18Ya4xjA00t78oWHRc0PSJCk03DlWdVUIiSgJ7Ykz1r0oQfuPjSLmTdnlX
         SnXx+q2iqNCqNrkEEgjvKd/9p7UTmv9dYj/t2nDYquS9sU9UAbqceeYHo5FsVdYmi/pZ
         Q5T7QJUFtxdDrQGGCap2QpgTofoYt9+115TljosDdxtDSIYOYumgzXkhjKL+1Cz39vmD
         lO+A==
X-Gm-Message-State: ACgBeo0Mzm+vf9c0BHvpHQ6WuXshBiEwHrIMM9OkRdx6tAjB+T7DI+g0
	7yZl/OzjCDWYkZdUu+I+I6EUnRQpMgY=
X-Google-Smtp-Source: AA6agR6piyFHBjgte2Rpb1JasXnx0JNZKAWTK+1VQ6GBsn0nff/oKE4ZprRfkBaX1t8UfGVAfTsZ6Q==
X-Received: by 2002:a63:1a49:0:b0:41b:c0b2:c94d with SMTP id a9-20020a631a49000000b0041bc0b2c94dmr171698pgm.524.1660240743557;
        Thu, 11 Aug 2022 10:59:03 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w125-20020a626283000000b0052ab602a7d0sm4292685pfb.100.2022.08.11.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:59:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/6] doc: add documentation for StationDebug
Date: Thu, 11 Aug 2022 10:58:55 -0700
Message-Id: <20220811175900.443310-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/station-debug-api.txt | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 doc/station-debug-api.txt

diff --git a/doc/station-debug-api.txt b/doc/station-debug-api.txt
new file mode 100644
index 00000000..18971f1b
--- /dev/null
+++ b/doc/station-debug-api.txt
@@ -0,0 +1,72 @@
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
+			Hidden BSS's are also included under the network path
+			"/hidden" since this will not interfere with a valid
+			network path.
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

