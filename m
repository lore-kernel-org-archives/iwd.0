Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844BD1DF755
	for <iwd@lists.linux.dev>; Tue,  8 Oct 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398839; cv=none; b=OT/xP16J73xmX9MM6SjeBq+22dv0vqeLapL439fvVKCEC680XtzuitU82NXaWEEyt5EBzotjoDkmIR+fbi0BvzW/4c0HhvFDdK30lUyGs+IQSPy5hZqLcjU58OYcwpnf7Ct84AUUYvflZMJ/gZQKipQ0PXzMAk1EkmlWZ5Ogpck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398839; c=relaxed/simple;
	bh=5+JIbc0aGejNnjSIkl3CtrXgnaUgu/m7XzlGwkfXRXY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QgO33qmvLWqhqnRgyMFzcPgxCKyrC2Fy7nlEGzSpkwMCRal7CPjatWNiuwW9iakUMcbFrr7nd/BUt6FQSqLSbwBeBR3qOrxO8mviccc6jArBbgf3XPKRUIo4BZ0viQn8GnAGGXCXz5FYPShSouGsw2jo3OioaR7odDNN83AZYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHXUb0It; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHXUb0It"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e7ffcd95c1so262178eaf.2
        for <iwd@lists.linux.dev>; Tue, 08 Oct 2024 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728398836; x=1729003636; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ms6aLNkcVmI+//WZvRwyi+JJbq574QW4iiKHGR+PlQ=;
        b=VHXUb0It5/xDYVF9P/Zl2oLn87FaInT9u1D/4j6GRtsOBfYR7AF5HbF/zp1eufsS7T
         pawdCcBhcINEj+XIeVioNJm3LBrtB/VXpr6kYM077IRYsprdIHGMpYGVLgWIjEY2MOCj
         WaUunyGsxY/thTX/VWyGclzuXwNmVU/84UPmRZINHw7dNBs1V2Z9CqUQjqxCZ4SyDW7I
         DZ+l5NnO+QSQLQhGkTOo27Oau/JEyk3tbTCxNb/6T9aT94HDkK9ZC4f17fUVDHpfdjFY
         Z7rjXxSKRLz1MLY+RTG9SuQoUcxI3onS/oqcVzI/i81DoHQRFVAL5OCMDBVzPt0wGKAW
         /i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398836; x=1729003636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ms6aLNkcVmI+//WZvRwyi+JJbq574QW4iiKHGR+PlQ=;
        b=GMNDWSQuF3JGNCoVs7hf1+DGD2j9BiZIU7foH7hixynGc+chlMOHISveWW3bNdE+it
         7O58W1GYdloTcPBNtzzTPJT2wFnhpA7VstFx+YrIXhO017475X3jK6Xz+KlLuv/OkvKH
         ZxW+8dQi1FGdM85efjerksdYr5pvnkRMdYCMN+U0jCPe8f2juq841UqkkZKCf33Ps+PY
         ITZYSSA0nrkrpe3h1xvKkXt0ixtJztRW3NDGm+uKholis3fii8HuMiV+p8RNmo3VCE1p
         YjPqScFV94tfmgSzCGU82X8QgtBbxLE30VukZJS1Y2PwbAJ7qgEPl6mzRx4D8iC/0ncH
         j4mg==
X-Gm-Message-State: AOJu0YzGwpR5uU+5tG0oQdijjpP22pD7UBqL7a64w1RA2deRJ9HU3KTQ
	e67e+/cDgj05HQrTKKpMy45l5OMQT5DA1NKB86/ZDQvq9A0d9cEs8nRMbQ==
X-Google-Smtp-Source: AGHT+IEc/guoiy1YTQZFYpvbt60DgE74WdTSm+ssAUYseoxs7G0NKyOA2OinUE8kJUmrn0trWp49tw==
X-Received: by 2002:a05:6358:5923:b0:1b5:f81c:8768 with SMTP id e5c5f4694b2df-1c2b7f6f20bmr572433055d.9.1728398836212;
        Tue, 08 Oct 2024 07:47:16 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbc5ba842esm3326236d6.45.2024.10.08.07.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:47:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] band: add "GB" as a valid alpha2 code
Date: Tue,  8 Oct 2024 07:47:12 -0700
Message-Id: <20241008144712.403893-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "UK" alpha2 code is not the official code for the United Kingdom
but is a "reserved" code for compatibility. The official alpha2 is
"GB" which is being added to the EU list. This fixes issues parsing
neighbor reports, for example:

src/station.c:parse_neighbor_report() Neighbor report received for xx:xx:xx:xx:xx:xx: ch 136 (oper class 3), MD not set
Failed to find band with country string 'GB 32' and oper class 3, trying fallback
src/station.c:station_add_neighbor_report_freqs() Ignored: unsupported oper class
---
 src/band.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/band.c b/src/band.c
index 6891d06c..14daeb37 100644
--- a/src/band.c
+++ b/src/band.c
@@ -1426,7 +1426,7 @@ static const char *const oper_class_eu_codes[] = {
 	"AL", "AM", "AT", "AZ", "BA", "BE", "BG", "BY", "CH", "CY", "CZ", "DE",
 	"DK", "EE", "EL", "ES", "FI", "FR", "GE", "HR", "HU", "IE", "IS", "IT",
 	"LI", "LT", "LU", "LV", "MD", "ME", "MK", "MT", "NL", "NO", "PL", "PT",
-	"RO", "RS", "RU", "SE", "SI", "SK", "TR", "UA", "UK"
+	"RO", "RS", "RU", "SE", "SI", "SK", "TR", "UA", "UK", "GB"
 };
 
 /* Annex E, table E-1 */
-- 
2.34.1

