Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB08613E04B
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054485; cv=none; b=EsTIwgTBFG9rX9hhrsquJnzE7cCLq7oWGpCeBhY57RjDccct0irVInfswTvRkQoouy/wtK+shu9zlpb1OYal5a9p4Yf8tc0khAcBG8XYldIQlhHGCaq1XFZ61EBxTjS6IPWHNwC1U8imNT+kkS5pN+Fv4V8cxoS6SWcZksANaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054485; c=relaxed/simple;
	bh=4YFB5h8zKkmMyRzSrqpkAovpdCwEtyubNe5Bd94jGSs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iSFgxTDCo3J05Es+z5RWSZTEzGdXZRse4NdioukA4+xWtI+vObE7tV5SraApZEZCFhBE+S0dpjLqpUwg4TDs3ZRRmflbnqv1j/dUbYVkPePzi4nAoBQ1uV7qmIsYlRxgEDA++1Vl9+AEyub69b8dNHJJ8UacMtAHPvg0ZqbpyTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpJ2w2Qr; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpJ2w2Qr"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1d3e93cceso114270785a.1
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054482; x=1723659282; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ci5+tjb70kTDD0CyGyfEAkcddsN33FelYMkFVd1mz+8=;
        b=RpJ2w2QrgL76dma32x+U9sWMKzW5q4FyF6m5iwa5Y0aje3Sj9TQ5LdELyt8tHU0Zph
         QqOxPCj5ORmx6rTupgTCX8KNAgbrePpp6x3ewQzyG6iPpc8HohHeEdEvY2LERjWbSG7a
         2SIgsx4j8oaXDMAvHZrpPK7K4w3vR4DhTMnEXbO6RhPYSN7nTxFGeEifbluENMx5fzqX
         NpFZazfOrYXCWfM4CYnLTEwyC2YSa4yBuCojY6VPGP/sKl9bfIyfFInDHJc0GBDiZGnX
         QTIOwHvZt1p4uIvK+lkX4AE1GI3GmqlLj1zUs/A226+KwKXK99i+6TI4hQnEp98gDbXS
         GbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054482; x=1723659282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ci5+tjb70kTDD0CyGyfEAkcddsN33FelYMkFVd1mz+8=;
        b=JZ4ZPKMPV+4s7sv7WT8DIQ49+aNFd/VZEUWkhuIivuiY2wrElIdhH1uaf5fu4bPInU
         uC7wtTZ0jwoDl27zcm4XJGwMy5yPvsbkgP92Xbl4FLadnt0+hHcC7tcHyyFN6iJsuF10
         BHns45D79eKiRNB0Nl0wj0OtR2jsm6wI4bMjMVosGibQMC4OrxXOaQkZIushnADvyk/b
         AoOAVVQItX/Vn12ybrIEGGrLV3SbTKFvQhzW7E9meliQ/E0bdY7+kJgNcR+Gm+MnPFxD
         9pYL2OG0Hk/ivwYkBZLwoaWWrELHwXg+sOK+HV1/+fo9K3fnCMOkZYznHRUutS3tDhuZ
         EIcw==
X-Gm-Message-State: AOJu0YxfcEgq7SuqiTwCB2Z0dT2J1DW/hmtAShltlZ5mIrXkZuV1W583
	/JWprpr9xXT7osh+ToGvYMpgrw4r/j79+jyNYzE6LXJeo3YsKAsfM25r3A==
X-Google-Smtp-Source: AGHT+IFoX/t+gbtnL8wYGY8/BAjtJ0PMtnz4skmOPjkoE92yPbzlm9k/wuzWo0SvzwSOpC/LNb2jvA==
X-Received: by 2002:a05:620a:178b:b0:79f:aa9:b3a0 with SMTP id af79cd13be357-7a377ba6598mr574156685a.13.1723054482286;
        Wed, 07 Aug 2024 11:14:42 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/14] doc: document BasicServiceSet API
Date: Wed,  7 Aug 2024 11:14:21 -0700
Message-Id: <20240807181427.170515-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807181427.170515-1-prestwoj@gmail.com>
References: <20240807181427.170515-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 doc/basic-service-set.txt | 10 ++++++++++
 doc/network-api.txt       |  5 +++++
 doc/station-api.txt       |  6 ++++++
 3 files changed, 21 insertions(+)
 create mode 100644 doc/basic-service-set.txt

diff --git a/doc/basic-service-set.txt b/doc/basic-service-set.txt
new file mode 100644
index 00000000..2ebb63be
--- /dev/null
+++ b/doc/basic-service-set.txt
@@ -0,0 +1,10 @@
+Basic service set hierarchy
+=================
+
+Service		net.connman.iwd
+Interface	net.connman.iwd.BasicServiceSet
+Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}/Xxx
+
+Properties	string Bssid [readonly]
+
+			MAC address of BSS
diff --git a/doc/network-api.txt b/doc/network-api.txt
index e4a34411..3aa68382 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -50,3 +50,8 @@ Properties	string Name [readonly]
 			corresponding to this Network.  If the network
 			is not provisioned or has not been connected to
 			before, the property is omitted.
+
+		a(o) BasicServiceSets [readonly]
+
+			Contains a list of paths of each individual
+			BasicServiceSet object.
diff --git a/doc/station-api.txt b/doc/station-api.txt
index 05dd137e..7b067620 100644
--- a/doc/station-api.txt
+++ b/doc/station-api.txt
@@ -164,6 +164,12 @@ Properties	string State [readonly]
 			for networks.  net.connman.iwd.Network objects are
 			updated when this property goes from true to false.
 
+		object ConnectedBss [readonly, optional]
+
+			net.connman.iwd.BasicServiceSet object represeting the
+			BSS the device is currently connected to or to which
+			a connection is in progress.
+
 SignalLevelAgent hierarchy
 ==========================
 
-- 
2.34.1

