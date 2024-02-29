Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04347A14D
	for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 18:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230346; cv=none; b=PN2FdAXt6xOwfvRJRhVdJ3ah9g+IpHTrzJX/NV3HM+I7DUh0y7ZWJ8clULCyVDTubrUeZG3p3nDeRINjjM18FlgqwFxC/w1sOfiR06AUGZbkkCi8FVTkr5ifaXfpuruScc7HtPFMsg6uwKDN9Ki7+d8uo0kg6kuWF968uAqtL/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230346; c=relaxed/simple;
	bh=D9qaCwOs2WfvFweRi46JlUNqo4Im3anMYizu90zR5OM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0gzWD08vr6noCEH2P2I9Y8C+yspzOaPxQNKS5jIHGtq5nQgI99pQZ0NoNEEB4+XAAGZ/b6qu3pF6ckrZe/fugKhGEWaU1hOo/8I5gmczeC+GSWyiOdPDc8qd8sBeyhq1pv9/D1YCMYcan8RRWp+Ze6L/Irjnt/gaW7EA3/DM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW7mxOgQ; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW7mxOgQ"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68ee2c0a237so9657236d6.1
        for <iwd@lists.linux.dev>; Thu, 29 Feb 2024 10:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230343; x=1709835143; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sc0k+IPPi4zpQnvnZ9sLDHJ5NbYazm4LKQBcmJ3HcdE=;
        b=GW7mxOgQb1QbCudeFD+Fgp/xKm52qdu2/6Vw7RjSQ6FLZOvZbdgUJMEAneeBlCqqrT
         aYqrBGV4ssUnRoYskrTbIWFr9ctd0O7TWqIkpih5CH4HPYrsi9K2zZKMnVQubzRTUpLW
         8ekGmaIabdTbBtQxJEi3CJq8ooPbG5Il73dX8T3U2odrC7iBJw1KAM749AFCNFGGo0E8
         nKgCQSuRjeol5MMd95raqyT5/1KOT14ru3dUHv7jsxjXGSLN9+U5dGAGDsD+mqLj0O3y
         sk98QCrTc0n+gV1xK0qdTAYK5m+IfvYTMkoGfIJ0/d3U7lZCSyxWU/3rM3DRDCPWz6BS
         hmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230343; x=1709835143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sc0k+IPPi4zpQnvnZ9sLDHJ5NbYazm4LKQBcmJ3HcdE=;
        b=Mdx/FVQ+GCwJJMsMwqNRP4yyr4QZWVl5UPMsGCce9moU2LiEd+JZZaQFH/tJ2n3/lf
         w+LmzYB+EaHoCFykeg+us+wLERcZ6DFIIteNLZNAMlVfWNE3rrJ1qFehadJdoZs8V9Mg
         GdGsmZRk1uPTki1nhrbyUTmm7uG2/HTWKiy4ZMN6KGP5JH91TZ5GSMvpB2AP0nTMImZ2
         gLiTrMNsf9l2gBh891pWQ+dyvZYTxK4P4o7PbOLT+jm86Uu/sBmPBAybu29HyWHk8woT
         LzjCP/x7aD00Fkzxi2mI2bDBqdr7hSdKb+wmZ4a8Pvy0P9OC4T3WYPITGnX3fLrC2ugL
         tOoA==
X-Gm-Message-State: AOJu0YwjElHBiAuQv1sf0Okyg6cLYbxZ9Xjm/znf30/eaZNPX2AGgRcX
	J9wI0zoT4oiZxZiRXJoyG1IIbCrj5HhURgWt5m+FmQgQmuElDKtubU5vopsz
X-Google-Smtp-Source: AGHT+IGYx1X6e66i+NXTlXZ+vM5tbX+ly7Vr04W2sKlpgViobqJSw+cDy0aVySjKKzW9eoR8EX/8fw==
X-Received: by 2002:a05:6214:4119:b0:68f:71b5:b234 with SMTP id kc25-20020a056214411900b0068f71b5b234mr4170608qvb.23.1709230343545;
        Thu, 29 Feb 2024 10:12:23 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id mf15-20020a0562145d8f00b0068cc0b46682sm994209qvb.4.2024.02.29.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:12:23 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] nl80211util: check l_genl_attr_recurse return in extract_nested
Date: Thu, 29 Feb 2024 10:12:15 -0800
Message-Id: <20240229181217.1503555-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240229181217.1503555-1-prestwoj@gmail.com>
References: <20240229181217.1503555-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caught by static analysis, the recurse operation return was not being
checked.
---
 src/nl80211util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/nl80211util.c b/src/nl80211util.c
index 0f45c905..3f9a43ac 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -136,9 +136,7 @@ static bool extract_nested(const void *data, uint16_t len, void *o)
 	const struct l_genl_attr *outer = data;
 	struct l_genl_attr *nested = o;
 
-	l_genl_attr_recurse(outer, nested);
-
-	return true;
+	return l_genl_attr_recurse(outer, nested);
 }
 
 static bool extract_u8(const void *data, uint16_t len, void *o)
-- 
2.34.1

