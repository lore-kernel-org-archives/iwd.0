Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E819925B
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543804; cv=none; b=t7fREtUQD9jNcMAHQ88FqWr4eYRkj5nUg07WalAQn1YvknJzqYs3SuhAO6veOBrCP/0fO9/DbikjAcuA84SW+VCuIdPR5nz9LIoxHme90N2OG51fDqCa1IsxcUV3mvBd+wzJDyPPoIJw91ez+cS2fotn5UfuUNpY2OvfFgpalkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543804; c=relaxed/simple;
	bh=Y7GJzVHuwca83pD8rQ/RZjFvQdAejg1vBvapTdZkaVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ThaGVDw6PaemcOhIvmZPWhWRJ6TRcoNtenkD7nUby108TlwxymwIpVa/NnCxliBcCS+3hO1ggryJkB9u5+BZC6kM5JiXgKuAiaQUF6Bn/dP5ZJUs1cuFmTbZkE7Ty0VInBcCuatSZbz33s2oygEea/9jCiKkIjwjQI2R87qe8vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtLKINsI; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtLKINsI"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d50532d335so370364a12.1
        for <iwd@lists.linux.dev>; Thu, 05 Sep 2024 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725543802; x=1726148602; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4I745+poCmNkPOdjr9jKm1qGaTAxHRXfYXC/52Yulk=;
        b=dtLKINsIdIVYV3SNmRVd1LpcAiDtc2z1HIiT0em0eNJplVCLxb5u1TvKa9Nbd0UXyT
         +gXYApDA1PzVj19tIO3HzxuyqP0/fen8ZyrZ1wZYBEo35HP+uUiBZo6gqA4V1tTbmOnw
         910HCq8jMYwvNLxjmNFjGEbTIUFkUDDQ1u6cUl8+D0iiGOfKQYg0WgKKJyoHlhbUlJiR
         s8XOXj2+Kj8CYHX+rLP6FPzBatTwVmDzm2y0rbQxMLadUXACgEYtgviVsV7aUQ+iv6JP
         6gdTkawoklKVw8vwyPRot6Nxr8TFrqcZi8F5hTzNzhSlWEeZfyOwVL5SXNKbn8ZcVQv8
         pUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543802; x=1726148602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4I745+poCmNkPOdjr9jKm1qGaTAxHRXfYXC/52Yulk=;
        b=EfqMM9/4MoQJOesDhmC0UJzikIsg9vB6qShvh4reN9bcGLSn7u6J4UlINNI/m2rxEJ
         4C6gUaY4X9ofAW4D9KdMP4JWlt2zQgqyOoLOrKL0GnY4H9nvpw1vavp0vkP2Ea5xptlz
         1XI7ZFSClbZ4/LEsMcke8BxuQKTRYD6NAdnwPXlcD1YBDShhgB0ANqZRKlkd5IY6wxIo
         ScBiygpsngvIN1JRJFCAMegtkiPzOY5yYLAeQqokCpIbpLC7+g3LgX66Zl0pyQMnm+ol
         IryfC3zi2MAKHp4szDKy8OUUlv8wuBfGHKd8Mny7gsA8lIDGi3HWWoQHmK+Y7Q8OdF/e
         35gg==
X-Gm-Message-State: AOJu0YyIYCZ30V9jr6u4Ma2Ke7X5SQyISO8nCwFEnZc7dw3IvJ/feuXO
	X5KlhK5qMuCuAXOV6vfqeb7dTULdx4eRI3IuxnUJpBpGDg2ypzXcO1pFww==
X-Google-Smtp-Source: AGHT+IFeUn3VyoblFkgf15sBKXUT/g9Oqh/d98enB+Qce7F8tgt3Qc3BwpGbaHlUwHQEPWYuCTQUJg==
X-Received: by 2002:a05:6a20:e617:b0:1c6:ed16:30e4 with SMTP id adf61e73a8af0-1cce0ff0eddmr24943848637.7.1725543802340;
        Thu, 05 Sep 2024 06:43:22 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea54f06sm28788405ad.207.2024.09.05.06.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:43:21 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] scan: check pending requests after regdom update
Date: Thu,  5 Sep 2024 06:43:15 -0700
Message-Id: <20240905134315.374800-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905134315.374800-1-prestwoj@gmail.com>
References: <20240905134315.374800-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While there is proper handling for a regdom update during a
TRIGGER_SCAN scan, prior to NEW_SCAN_RESULTS there is no such
handling if the regdom update comes in during a GET_SCAN or
GET_SURVEY.

In both the 6ghz and non-6ghz code paths we have some issues:
  - For non-6ghz devices, or regdom updates that did not enable
    6ghz the wiphy state watch callback will automatically issues
    another GET_SURVEY/GET_SCAN without checking if there was
    already one pending. It does this using the current scan request
    which gets freed by the prior GET_SCAN/GET_SURVEY calls when
    they complete, causing invalid reads when the subsequent calls
    finish.
 - If 6ghz was enabled by the update we actually append another
   trigger command to the list and potentially run it if its the
   current request. This also will end up in the same situation as
   the request is freed by the pending GET_SURVEY/GET_SCAN calls.

For the non-6ghz case there is little to no harm in ignoring the
regdom update because its very unlikely it changed the allowed
frequencies.

For the 6ghz case we could potentially handle the new trigger scan
within get_scan_done, but thats beyond the scope of this change
and is likely quite intrusive.
---
 src/scan.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 205365cd..ccd1e9e1 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2120,6 +2120,22 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
 	if (!sr)
 		return;
 
+	/*
+	 * If the regdom update finished with GET_SCAN/GET_SURVEY in flight
+	 * don't try and get the results again and allow those calls to finish.
+	 * For the non-6ghz case this has no downside as the results should not
+	 * differ.
+	 *
+	 * If 6ghz was enabled by this regdom update there is still not much we
+	 * can do since the scan itself is already completed. Appending to the
+	 * command list won't do anything.
+	 *
+	 * TODO: Handle the 6ghz case by checking for this case in get_scan_done
+	 *       and continuing to iterate the sr->cmds array.
+	 */
+	if (sc->get_scan_cmd_id || sc->get_survey_cmd_id)
+		return;
+
 	/*
 	 * This update did not allow 6GHz, or the original request was
 	 * not expecting 6GHz. The periodic scan should now be ended.
-- 
2.34.1

