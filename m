Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39019F485
	for <iwd@lists.linux.dev>; Thu,  5 Sep 2024 15:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550027; cv=none; b=qELECWPd7b2+8uLBgmsc6xYURWWi4qt0cA0n02doEbtJRmcceDk1ymvBKsPGpulggfWyGIbYRhZnz0ILKkwGdoKLRNRajyiPb/vQuIlBv5yU9cwp3paDwKqfH5O1mCSI/T08RUJjEz7bDLEtlMfUOk319F1mwH7CRZEamjlsO5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550027; c=relaxed/simple;
	bh=WjT5XGWlK3un+U8sn7wznyRc4zxyLTY1Rz0UhQRQqRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0ZwXrZk1VAvoHJWvHGqlIOairTLulMnO7MHt1yz/K+Kgj8SxUTZipeqd4in045DtaRYhYcWCrc0d4G4ebLY8O1lAzc9dSYKf9E4gbcLnLHDw9GwrIKQ1zYPorLQQR5Un2OVvw8vbomCsh5Agf7gsPqoFtFIvDnYnw47fARxUKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xb1gcFUu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xb1gcFUu"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a4df9dc885so75449585a.0
        for <iwd@lists.linux.dev>; Thu, 05 Sep 2024 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725550024; x=1726154824; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHrRE4rwLtMHRghESL6APmN8njV8uIbJS9xhBinYjj4=;
        b=Xb1gcFUuULTZwUb1f1PdhyihkgDZQSXr+VP91/erpLPBqb7itH/TgG6/9bqA7LoD+n
         b196SzLfVkbzAHFJk8UIo5n3sepdggT0JjKXm/kUUyYLPJ3/DKQKzdXdISHavaC6mmbU
         pHuyysyKPUp2SV9ys8cI1O2paNiwN+iXIEiY25mDM3L6yh+DFmDxNzZ3+3wBOn7zVhxJ
         pcK3wfow2V+YguPOtYPdHoyuv1LmclPQlisOzi5CTCsh0tq0tm4h53p5TXMCQS96TdAK
         c+LV+P/xPMwKcaGGz7BnlON8f1sgIJznCBaL5bP399p07wGHrvnIcT2qsAWgwHFLAvny
         C01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725550024; x=1726154824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHrRE4rwLtMHRghESL6APmN8njV8uIbJS9xhBinYjj4=;
        b=XRQBPuitiLJK4psgxXdSxHBqNc507otV132QXcTLuj/nFJsFonOTzmUtakDdOu+rxM
         Bk1xAJHnAmM/cK5uY7FMVB76ddNfIuGdqvOqQqaG0ZaOuLLmo7Pl/lYoJQDtXFisnHkS
         PVX+KLbkHs3zMlQhPwBJQF8kOzwdGJpKgzDWXmOgk3MSMeXuM+J0NgraUvXCbBW6q6jn
         a++558WN47mqe0zB+bSvCYFVIaAws9q31oHuBaRjt8VnLY7Odj8qhrFpce75EeZUCKdF
         SoVGSjPqN3eD8nm+BmrdqdIhD4x36jQhwlqzt66E0dkHPzitdPnB/6tXb8MYZcxDtXvn
         Rhhw==
X-Gm-Message-State: AOJu0Yws+VFQWvfnBwnAEdSs9VkRsMAsHWMO3n946vobgXNrQ5rpOQNE
	GnyT4pd95o8HiJlJLudVOdV0W0ud/gJDYFz9ircUC/d5IFBIgsUwlqagkg==
X-Google-Smtp-Source: AGHT+IFQSX/CsdhFnkUogAd5mFoUBIzQqIikJrDcKO6ZcURynduIALgFSd3uZHwtFDK1jCNz7g4fHA==
X-Received: by 2002:a05:620a:2888:b0:7a4:dff8:35d5 with SMTP id af79cd13be357-7a988935150mr977585085a.33.1725550024251;
        Thu, 05 Sep 2024 08:27:04 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b57347sm8026481cf.54.2024.09.05.08.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 08:27:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] scan: check pending requests after regdom update
Date: Thu,  5 Sep 2024 08:26:58 -0700
Message-Id: <20240905152658.380237-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905152658.380237-1-prestwoj@gmail.com>
References: <20240905152658.380237-1-prestwoj@gmail.com>
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
index 1cec9785..2ffbef6d 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2121,6 +2121,22 @@ static void scan_wiphy_watch(struct wiphy *wiphy,
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

