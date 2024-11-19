Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE2E2AE74
	for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026289; cv=none; b=q4tMJSH1l3n7Awuk888stzbgYC/bJM96w1HeYw3gK2Fw97cimBvVOoXI3LGjyhlrmHdUgv+nil0x14EqoGGPg+qJ5k+PLtWQgMUSXphyhbYnnTIQXxKkGxAzSiE3/wmDGRqJERKsUEuTur1pif6pdQKOY8bP59MZkHKe3etItQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026289; c=relaxed/simple;
	bh=NirQB3cyt7O5tSx9qFIew+TfmRHe5J4KzY72aCuLJXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gVoualBALaEg2Gl668hqVGC4iD4+fEXIMDVdz+LSdLPaG8PumOmcA7cyP7Sc6Ov4Cz99jjZ/4k80hs8Ye/Zln4agSwRRreL7fyqu6/ru20bfipoXkFoJrpwxuKj57/zxZJBWj+xei9uXQD629iUpcQ8/J31NuKMdZc0OLazKQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCt7g/3H; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCt7g/3H"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e52582cf8so2333594b3a.2
        for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 06:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732026287; x=1732631087; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNRIJ6fma0uq12NiUlwXj9EiGE28Tr3hgf8O7lL/fDw=;
        b=fCt7g/3HRxsy7y8jEtBhaTnSF4dtTl6AGGWihwKqk2rNC0UTRMMEwVt7Euff9iwoWq
         p7X7nmsil5uKOsDJn4RQ2JO5ei/gnzhL8RREjTzM2RC8oXV2csWNgJ1MG/jokMKaQ6SY
         yX83KM6cOuuur4iPPtqKD8y5/uOYAJvVk4A/LEuSweZhpSaw5I2vG9ys8bBZJ9YWtqv1
         FPPT+8Hn7Bibcp/sMdEV2b3veAqbiuWIYQKCPNc6UcIsQf0iRlLXalSkXmAmLtRtgHo7
         TtyMYLtJmRVy7tsXt77jdNbAvPF1U3Z32Wc9vtDq3y6jNEHMTQQHwXI/ssHi3/FzBhs3
         7rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026287; x=1732631087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNRIJ6fma0uq12NiUlwXj9EiGE28Tr3hgf8O7lL/fDw=;
        b=QZlvKI0av9FdQYCpGH4EzmL+0vr7YKLSuXDx5/0tFpnUlxAYMdU8kUKUb8JEsDGSQ3
         DqIMBgfqh7USLYK5+F1CQyo5GY6hs0Vim1hyJvyQELhcBB/KNk+aMRljgjhdlV+O6RX0
         /4i+lztDn4bS9Jg57XDSCF6kRMMYCaOS3WMwkUV3RCwa4x4FUm7rD8sCONanlM83MrhC
         WsDEMYmpxiFgsu2SudJhTiDmG7/DGWnMxTdvTjhhkt6+ogsdZgArocHtmLU6NCDFviHL
         e9KftNwo0NFJcJAyFgRwMr7KuGWiVuLSX9MZxCFozBDpr8IRxQ9MJx3CExAdvoleVFpw
         Sivw==
X-Gm-Message-State: AOJu0YwX9NVO3IZQ48JK7Nikx5vp1PI39WHHE7WTvT87+t438yNS8ehy
	S9M7CIzQPboohgdeyA+HVS40rKCXhAqVfUKsdKQq9hGXtpJwDp27Npnblw==
X-Google-Smtp-Source: AGHT+IFYDHVsZU1ajUBW7ZityAmy4HwCkPfqXKUdmK7htlynLpU/R1cDxykRnXscxk7i7VloDnroYA==
X-Received: by 2002:a17:902:e889:b0:212:6011:594a with SMTP id d9443c01a7336-21260209ce9mr11936855ad.3.1732026286792;
        Tue, 19 Nov 2024 06:24:46 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212389529b6sm29219115ad.236.2024.11.19.06.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:24:46 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/8] doc: document [Rank].HighUtilization/StationCount thresholds
Date: Tue, 19 Nov 2024 06:24:29 -0800
Message-Id: <20241119142430.323074-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142430.323074-1-prestwoj@gmail.com>
References: <20241119142430.323074-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 9dc0fe0c..1cb4b05d 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -341,6 +341,28 @@ autoconnect purposes.
        A value of 0.0 will disable the 6GHz band and prevent scanning or
        connecting on those frequencies.
 
+   * - HighUtilizationThreshold
+     - Values: unsigned integer value 0 - 255 (default: **0**, disabled)
+
+       **Warning: This is an experimental feature**
+
+       The BSS utilization threshold at which a negative rank factor begins to
+       be applied to the BSS. As the load increases for a BSS the ranking factor
+       decays exponentially, meaning the ranking factor will decrease
+       exponentially. Setting this can have very drastic effects on the BSS rank
+       if its utilization is high, use with care.
+
+   * - HighStationCountThreshold
+     - Values: unsigned integer value 0 - 255 (default: **0**, disabled)
+
+       **Warning: This is an experimental feature**
+
+       The BSS station count threshold at which a negative rank factor begins to
+       be applied to the BSS. As the station count increases for a BSS the
+       ranking factor decays exponentially, meaning the ranking factor will
+       decrease exponentially. Setting this can have very drastic effects on the
+       BSS rank if its station count is high, use with care.
+
 Scan
 ----
 
-- 
2.34.1

