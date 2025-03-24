Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A2F25F985
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825776; cv=none; b=uW4gv8WcrRBfBI1cUdRJfEoZLasDKhr0lwa4Gj4IfvTweH5tXDTbBFPzk6IAqMcyrlmUWpogPzmFDywbdFZQNL8OKKmVTOo6iMYpuqwx/CTQV9nAcNMra+XZ+wm9THfcY4phzGpxnK8aQLNYX7o6hg4AQtJnsFjq+pj5HscQi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825776; c=relaxed/simple;
	bh=EhYkCUOrDHsUDZfAzzIVfxMAiDfgeiDvtMqnzKMt93M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEqYf7Km2DdEVG0ep3pgbBXE2jD3sa2/+OHGWD0iGzq7bNHq95H/a5z7su7rHHfHtz1lBNqSVF+w+8Td7qQi1sMTomGpfiewjDgs51nJMRvzXxCWowdVD61b14vo1nYSELxKYTxS5FNX1RnnVcurf8Pbec0OynlB7QQ6/3bi/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrVL4bkR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrVL4bkR"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-223fd89d036so83519275ad.1
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825773; x=1743430573; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hANVGTDNuNJBwaz1M0ixjk+A8BduGqE4G2Kerywpx9Q=;
        b=XrVL4bkRYMiEHiIpKZgho8/2Fm2VAa4ntxR/MijOEeDaYXCHc3HkSanGjXCimFSfAQ
         I+mKcua7E/sRwuQZmUONhFpnTX+YN3R0+gvL7KQde76RPRVlwMGhuhaYRzzWs1w8UN1G
         9mLpa3O8gopNE7mzgsAAIUxZfQt9M850G3wDi/TYn78yKnmtf4snI4/Uiw8ei+1b77NU
         5OsI5B7SghRUE2zCagG/pr7CTEB6Cr0EQDJfNbqLa8264cCa5hiPRWOlOEP+HgMh+8wn
         O8+N56KdB3cjJ2wnL/KJXLVEwYfphtm2vd3V4WE9tYummKJvbCGodCJMBkEsbT1X4lRz
         zUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825773; x=1743430573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hANVGTDNuNJBwaz1M0ixjk+A8BduGqE4G2Kerywpx9Q=;
        b=dRrKV0daIGEkWZWfdtc7p6P5ovpNwdLJw79Jhpq7MYbCiPBAItMrv5Wqpkdjf+NZIq
         tFILbSTc2ED5drkTpKIy6TDe8Cav4Ne9PoOj/qFRDJFBTqatMtCsMreiAnThjrHisUY5
         zT5dSJzKXZpyGutwothPCIaF7G+AaZRbULcNSPwCA/ydivlSkh6lXdPJOo9Emsc0TIop
         2DY/wAUVUqOvSI58BVlGk7YkOG2X6rUHbtBqkPNtHojG715DnwAEr08XLAeIEKGpfug3
         fzrZw5W8dUgvzFXRNdFNqyPRqQehHkROFs+AwxypdpRybEAS9JZ+YierDfebwDO7vvHs
         gjGw==
X-Gm-Message-State: AOJu0YyDnXSMyYNlkd+GfcRTOHCUM+1qs0GLVGw0myJSTK3oqsbX1zrT
	CZFKzmV3shX5/IXWroh6qHXbILASBLBiVcwNuFXog4jPRXW0lKPxcvf+5w==
X-Gm-Gg: ASbGncuNN2GVXkexIZBiuTfLh5uwwSG1HjNOdUVd7NBCeSWL+a+jW2Zt7fnN9re+zVY
	t8PIZWWNrtXgUd2Y07XYId7HDbrvDlPbV5EXJnW5vscdsj3Za12uqN0JxTrV8+4SsHBM256RZzf
	1VfUIT1u2HN/XXiK3WJVrpQPXURCVGHPLqrQZI8MViOCsU2Ha3aCDiDxcYY6R4m9vZLxunUZ6Y2
	XXEmOQXz+UAi76ofPyyVhLHTSnRiq4HvofIK46ZMSqsyEhmFgAVGczaSeWUoqB/+NIYDeJ6SdOD
	kiDK6pj8A9MrFbcLOV7pBbjxAApXcXTi9az0u/dQT+sX6oOnL+/+Bg0=
X-Google-Smtp-Source: AGHT+IGMXel2mMy/3oFheUl7bZOeIm7s1/eejclFeCatKyQ2MCGxRFCP6nqpkB3q3B8ZYgTKh2dx6g==
X-Received: by 2002:a05:6a00:1301:b0:736:51ab:7aed with SMTP id d2e1a72fcca58-739059ffa18mr20758434b3a.16.1742825773207;
        Mon, 24 Mar 2025 07:16:13 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:16:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 13/13] doc: document OptimalSignalThreshold and InitialRoamRequestedTimeout
Date: Mon, 24 Mar 2025 07:15:38 -0700
Message-Id: <20250324141538.144578-14-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324141538.144578-1-prestwoj@gmail.com>
References: <20250324141538.144578-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 895a1012..a2fea8b4 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -149,6 +149,21 @@ The group ``[General]`` contains general settings.
        This has the same effect as ``CriticalRoamThreshold``, but for the 5GHz
        band.
 
+   * - OptimalSignalThreshold
+     - Value: rssi dBm value, from -100 to -1, default: **0** (disabled)
+
+       When set to a non-zero value, this enables BSS grouping which is a
+       sorts BSS's first based on this optimal signal threshold, then by rank.
+       In addition the BSS's blacklisting status is also taken into account.
+       IWD will order its connection preference first based on the following
+       groupings, then followed by rank:
+
+       1. "Optimal" is the most preferred group. The BSS is both above the
+          **OptimalSignalThreshold** and not roam blacklisted
+       2. "Above Threshold" means the BSS is roam blacklisted, but still above
+          the **OptimalSignalThreshold**
+       3. "Below Threshold" means the BSS is below **OptimalSignalThreshold**
+
    * - RoamRetryInterval
      - Value: unsigned int value in seconds (default: **60**)
 
@@ -292,6 +307,12 @@ control how long a misbehaved BSS spends on the blacklist.
 
        The initial time that a BSS spends on the blacklist. Setting this to zero
        will disable blacklisting functionality in IWD.
+   * - InitialRoamRequestedTimeout
+     - Values: uint64 value in seconds (default: **30**)
+
+       The initial time that a BSS will be marked after a BSS requests a roam.
+       This is to aid in avoiding roaming back to BSS's which are likely
+       overloaded. Setting this to zero will disabled this form of blacklisting.
    * - Multiplier
      - Values: unsigned int value greater than zero, in seconds
        (default: **30**)
-- 
2.34.1

