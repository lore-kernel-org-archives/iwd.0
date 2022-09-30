Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0B4C6C
	for <iwd@lists.linux.dev>; Fri, 30 Sep 2022 14:48:19 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id c11so7200627wrp.11
        for <iwd@lists.linux.dev>; Fri, 30 Sep 2022 07:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mnat45Sc5bYQRhlem9JJZc+pi34uzJt4baVQ9+vh2gc=;
        b=rfbMBwDfn8G5zoFz5cTdYewGCQTvf77CAROu7Cn1RnH7YqwHUSxC7koGr+ASypB6Z0
         zzMqNp0sttYEiam5np4LiKSP4l6C/ZGkqMqEBLsabp8nMtlUk2RRz6x7MzoG13HHE9YC
         8nW/5ARZ2/1ZxDE0JZZbKGgOEuY19TffuOGcjiW9JPYfswqtFOgG6qPzyOCuccPSQshM
         +84R4C+p8mIsF3a48ueDMxGmUbkHZ9nvq4PaMiEpUBv91RWy6LzzJ39u/OemkyWHhEB3
         b1HT34qG9uq3v9M3sJd4ZbeSR3y3XWy9W4MUIWyTl5egIHrf/BrkOpxME1TxLbPPdUmr
         HPyw==
X-Gm-Message-State: ACrzQf3o6THpSNOcK0oyCM0eZiT43jei28qKzsCv/hKdHdTUF6XzioLy
	nMIXZ5btH389uRIK5behpnRSwwzdwlU=
X-Google-Smtp-Source: AMsMyM4rynrabjwcmTAoc0lIcaIH1v1UqCqm/pb+4OzY1SPg+fmsvBbnrbnvNC2BmEF8mtVL3X9c+Q==
X-Received: by 2002:a05:6000:1f9b:b0:22e:504:1bb with SMTP id bw27-20020a0560001f9b00b0022e050401bbmr949008wrb.90.1664549297384;
        Fri, 30 Sep 2022 07:48:17 -0700 (PDT)
Received: from localhost.localdomain ([82.213.228.103])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c214d00b003b505d26776sm6900284wml.5.2022.09.30.07.48.16
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 07:48:17 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 3/3] doc: Drop proposed and unimplemented API doc
Date: Fri, 30 Sep 2022 16:48:01 +0200
Message-Id: <20220930144801.548229-3-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220930144801.548229-1-andrew.zaborowski@intel.com>
References: <20220930144801.548229-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/ip-configuration-api.txt | 47 ------------------------------------
 1 file changed, 47 deletions(-)
 delete mode 100644 doc/ip-configuration-api.txt

diff --git a/doc/ip-configuration-api.txt b/doc/ip-configuration-api.txt
deleted file mode 100644
index 58a522de..00000000
--- a/doc/ip-configuration-api.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-IP Configuration hierarchy
-===============================
-
-Service		net.connman.iwd
-Interface	net.connman.iwd.IPv4Configuration [Experimental]
-Interface	net.connman.iwd.IPv6Configuration [Experimental]
-Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}
-Object path	/net/connman/iwd/{phy0,phy1,...}/p2p_peers/{aa_bb_cc_dd_ee_ff}
-
-The interfaces net.connman.iwd.IPv4Configuration and
-net.connman.iwd.IPv6Configuration currently have the same sets of methods,
-signals and properties.  In station mode, when network configuration is
-enabled there may be one or both interfaces present on a device object in
-connected state depending on if IPv4 and IPv6 addresses have both been
-configured.  In P2P mode only net.connman.iwd.IPv4Configuration is used.
-
-Properties	string Method [readonly]
-
-			Indicates whether the local address was set
-			statically (value "static") or obtained automatically
-			such as through DHCP (value "auto").  Even when the
-			address was obtained from the remote end some
-			configuration bits, such as DNS addresses, may have
-			been overridden locally.
-
-		string Address [readonly]
-
-			Holds the local IP address.
-
-		byte PrefixLength [readonly]
-
-			Holds the prefix-length of the local subnet.  For
-			IPv4 this maps to the netmask.
-
-		string Gateway [readonly, optional]
-
-			Holds the gateway address for the subnet if one
-			exists.
-
-		array(string) DomainNameServers [readonly, optional]
-
-			Holds the list of domain name server addresses
-			configured if any.
-
-		array(string) DomainNames [readonly, optional]
-
-			Holds the network's local domain names if any exist.
-- 
2.34.1

